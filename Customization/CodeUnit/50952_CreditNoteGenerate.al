codeunit 50952 "Credit Memo Generate"
{
    Subtype = Normal;

    trigger OnRun()
    begin
    end;

    procedure GenerateCreditMemo(requestcreditnoteapproval: Record RequestCreditNoteApprovalList)
    var
        Customer: Record Customer;
        customercard: Record Customer;
        SalesPost: Codeunit "Sales-Post";
        RequestGrid: Record "Request Credit Note Grid";
        GridPerSeries: Record "Request Credit Note Grid";
        PaymentSeriesList: List of [Code[20]];
        CurrentSeries: Code[20];
        NewSalesHeader: Record "Sales Header";
    begin
        Customer.SetRange("No.", requestcreditnoteapproval."Tenant No.");
        if not Customer.FindFirst() then
            Error('Customer not found for the given Sales Credit Memo.');

        RequestGrid.SetRange("Request No.", requestcreditnoteapproval."Request No.");
        RequestGrid.SetRange("Contract ID", requestcreditnoteapproval."Contract ID");
        if not RequestGrid.FindSet() then
            Error('No credit note lines found for the request.');

        // Collect unique payment series
        repeat
            if not PaymentSeriesList.Contains(RequestGrid."Payment Series") then
                PaymentSeriesList.Add(RequestGrid."Payment Series");
        until RequestGrid.Next() = 0;

        // Loop by Payment Series
        foreach CurrentSeries in PaymentSeriesList do begin
            GridPerSeries.Reset();
            GridPerSeries.SetRange("Request No.", requestcreditnoteapproval."Request No.");
            GridPerSeries.SetRange("Contract ID", requestcreditnoteapproval."Contract ID");
            GridPerSeries.SetRange("Payment Series", CurrentSeries);
            GridPerSeries.SetFilter("Credit Memo Generated", '=false');

            if GridPerSeries.FindSet() then begin
                NewSalesHeader := CreateSalesHeader(GridPerSeries."Contract ID", GridPerSeries."Tenant No.", GridPerSeries."Property Classification");

                customercard.SetRange("No.", NewSalesHeader."Sell-to Customer No.");
                if customercard.FindFirst() then
                    if NewSalesHeader."Property Classification" <> '' then begin
                        customercard.Validate("Gen. Bus. Posting Group", NewSalesHeader."Property Classification");
                        customercard.Validate("Customer Posting Group", NewSalesHeader."Property Classification");
                        customercard.Modify();
                    end;

                if NewSalesHeader."Property Classification" <> '' then begin
                    NewSalesHeader.Validate("Gen. Bus. Posting Group", NewSalesHeader."Property Classification");
                    NewSalesHeader.Validate("Customer Posting Group", NewSalesHeader."Property Classification");
                    NewSalesHeader.Modify();
                end;

                // 💡 Pass current series to only fetch matching lines
                createSalesLines(NewSalesHeader, requestcreditnoteapproval, CurrentSeries);
                Createdocument(NewSalesHeader);
                SalesPost.Run(NewSalesHeader);
                Message('✅ Sales Credit Memo created for Payment Series %1 with No. %2', CurrentSeries, NewSalesHeader."No.");
            end;
        end;
    end;

    procedure CreateSalesHeader(pContractID: Integer; pTenantID: Code[50]; pUnitType: Text[50]): Record "Sales Header"
    var
        SalesHeader: Record "Sales Header";
        salesReciveable: Record "Sales & Receivables Setup";
        noseries: Codeunit "No. Series";
    begin
        salesHeader.Init();
        if salesReciveable.FindSet() then
            salesHeader."No." := noseries.GetNextNo(salesReciveable."Credit Memo Nos.", Today, true);

        salesHeader."Document Type" := SalesHeader."Document Type"::"Credit Memo";
        salesHeader.Validate("Sell-to Customer No.", pTenantID);
        salesHeader.Validate("Contract ID", pContractID);
        salesHeader."Document Date" := Today;
        salesHeader."Posting Date" := Today;
        salesHeader."Due Date" := Today;
        salesHeader."Property Classification" := pUnitType;
        salesHeader."Posting No. Series" := salesReciveable."Posted Credit Memo Nos.";
        salesHeader."Approval Status for CreditNote" := SalesHeader."Approval Status for CreditNote"::Approved;

        salesHeader.Insert();
        exit(salesHeader);
    end;

    procedure createSalesLines(
        var salesheader1: Record "Sales Header";
        requestcreditnoteapproval: Record RequestCreditNoteApprovalList;
        paymentSeries: Code[20]
    )
    var
        saleline: Record "Sales Line";
        newSaleslines: Record "Sales Line";
        item: Record Item;
        requestcreditnotegrid: Record "Request Credit Note Grid";
    begin
        requestcreditnotegrid.SetRange("Request No.", requestcreditnoteapproval."Request No.");
        requestcreditnotegrid.SetRange("Contract ID", requestcreditnoteapproval."Contract ID");
        requestcreditnotegrid.SetRange("Payment Series", paymentSeries);
        requestcreditnotegrid.SetFilter("Credit Memo Generated", '=false');

        if requestcreditnotegrid.FindSet() then
            repeat
                saleline.Init();
                saleline."Document Type" := saleline."Document Type"::"Credit Memo";
                saleline.Validate("Document No.", salesheader1."No.");

                // Calculate Line No
                newSaleslines.SetRange("Document No.", salesheader1."No.");
                newSaleslines.SetRange("Document Type", Enum::"Sales Document Type"::"Credit Memo");
                newSaleslines.SetRange("Contract ID", salesheader1."Contract ID");
                newSaleslines.SetCurrentKey("Line No.");
                if newSaleslines.FindLast() then
                    saleline."Line No." := newSaleslines."Line No." + 1000
                else
                    saleline."Line No." := 1000;

                saleline.Validate("Contract ID", salesheader1."Contract ID");
                saleline.Type := saleline.Type::Item;
                saleline.Validate("Sell-to Customer No.", salesheader1."Sell-to Customer No.");

                // Map item by description
                item.SetRange(Description, requestcreditnotegrid.Charges);
                if item.FindFirst() then
                    saleline.Validate("No.", item."No.")
                else
                    Error('No item found with description "%1"', requestcreditnotegrid.Charges);

                saleline.Validate("Quantity (Base)", 1);
                saleline.Validate(Quantity, 1);
                saleline.Validate("Unit Price", Abs(requestcreditnotegrid."Total Reduction"));
                saleline."Contract ID" := requestcreditnotegrid."Contract ID";
                saleline.Insert();

                // Mark grid as processed
                requestcreditnotegrid."Credit Memo Generated" := true;
                requestcreditnotegrid."Credit Note No." := salesheader1."No.";
                requestcreditnotegrid.Modify();
            until requestcreditnotegrid.Next() = 0;
    end;

    procedure Createdocument(var SalesheaderRec: Record "Sales Header")
    var
        InStream: InStream;
        FileName: Text;
        SASUrlBase: Text;
        SASUrlWithFileName: Text;
        UploadResult: Text;
        TempBlob: Codeunit "Temp Blob";
        ValidFormats: List of [Text];
        FileExtension: Text[10];
        FileSize: Decimal;
        ConfigRecord: Record AzureConfiguration;
        ReportID: Integer; // Your report ID
        RecRef: RecordRef;
        FieldRef1: FieldRef;
        FieldRef2: FieldRef;
        OutStream: OutStream;
        SalesHeader1: Record "Sales Header";
        customercard: Record Customer;
        azureBlobUploader: Codeunit "Azure AD Blob Storage";
        folderName: Text;
    begin
        if SalesheaderRec."Approval Status for CreditNote" <> SalesheaderRec."Approval Status for CreditNote"::Approved then
            Error('The Sales Credit Memo cannot be posted because the approval status is not "Approved".');

        if not ConfigRecord.FindFirst() then
            Error('Azure configuration is missing. Please set up the SAS URL in the Azure Configuration table.');
        ValidFormats.Add('.png');
        ValidFormats.Add('.jpg');
        ValidFormats.Add('.jpeg');

        SASUrlBase := ConfigRecord."SAS URL";
        FileExtension := '.pdf';
        ReportID := 50116;
        //  RecRef.Open(DATABASE::"Sales Header"); // Open the table reference
        // RecRef.GetTable(Rec);
        SalesHeader1.Reset();
        SalesHeader1.SetRange("No.", SalesheaderRec."No.");
        SalesHeader1.SetRange("Document Type", SalesheaderRec."Document Type"::"Credit Memo");
        if not SalesHeader1.FindFirst() then
            Error('Sales Credit memo record not found.');

        // Open the correct record in RecRef
        RecRef.GetTable(SalesHeader1);
        // RecRef.GetTable(Rec);
        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);



        TempBlob.CreateInStream(InStream);
        FileName := 'CreditNote' + SalesheaderRec."No." + FileExtension;
        folderName := 'SalesCreditMemoDocuments';
        UploadResult := azureBlobUploader.UploadDocumentToBlob(InStream, FileName, folderName);
        SalesheaderRec."Credit Memo Document" := FileName;
        SalesheaderRec."Credit Memo URL" := UploadResult;
        SalesheaderRec.Modify();


    end;
}
