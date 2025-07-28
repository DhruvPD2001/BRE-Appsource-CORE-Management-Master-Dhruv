codeunit 50515 "Create Sales Credit Memo"
{
    Subtype = Normal;
    trigger OnRun()
    begin
    end;

    procedure CreateSalesCreditMemo(creditMemoRec: Record "Credit Note Approval")
    var
        NewSalesHeader: Record "Sales Header";
        Customer: Record Customer;
        contractrec: Record "Tenancy Contract";
        SalesPost: Codeunit "Sales-Post";
    begin
        Customer.SetRange("No.", creditMemoRec."Tenant ID");
        if not Customer.FindFirst() then
            Error('Customer not found for the given Sales Credit Memo.');
        contractrec.SetRange("Contract ID", creditMemoRec."Contract ID");
        if not contractrec.FindFirst() then
            Error('Contract not found for the given Sales Credit Memo.');
        NewSalesHeader := CreateSalesHeader(creditMemoRec."Contract ID", creditMemoRec."Tenant ID", contractrec."Property Classification");
        Customer.SetRange("No.", NewSalesHeader."Sell-to Customer No.");
        if Customer.FindSet() then
            if NewSalesHeader."Property Classification" <> '' then begin
                Customer.Validate("Gen. Bus. Posting Group", NewSalesHeader."Property Classification");
                Customer.Validate("Customer Posting Group", NewSalesHeader."Property Classification");
                Customer.Modify();
            end;
        if NewSalesHeader."Property Classification" <> '' then begin
            NewSalesHeader.Validate("Gen. Bus. Posting Group", NewSalesHeader."Property Classification");
            NewSalesHeader.Validate("Customer Posting Group", NewSalesHeader."Property Classification");
            NewSalesHeader.Modify();
        end;
        Saleslinecreate(NewSalesHeader, creditMemoRec);
        SalesPost.Run(NewSalesHeader);
        Message('Sales Credit Memo created successfully with No. %1', NewSalesHeader."No.");
    end;

    procedure CreateSalesHeader(pContractID: Integer; pTenantID: Code[50]; pUnitType: Text[50]): Record "Sales Header";
    var
        SalesHeader: Record "Sales Header";
        salesReciveable: Record "Sales & Receivables Setup";
        noseries: Codeunit "No. Series";
    begin
        salesHeader.Init();
        if salesReciveable.FindFirst() then
            salesHeader."No." := noseries.GetNextNo(salesReciveable."Credit Memo Nos.", Today, true);
        salesHeader."Document Type" := SalesHeader."Document Type"::"Credit Memo";
        salesHeader.Validate("Sell-to Customer No.", pTenantID);
        salesHeader."Document Date" := Today;
        salesHeader.Validate("Contract ID", pcontractid);
        salesHeader."Posting Date" := Today;
        salesHeader."Due Date" := Today;
        salesHeader."Property Classification" := pUnitType;
        SalesHeader."Posting No. Series" := salesReciveable."Posted Credit Memo Nos.";
        SalesHeader."Approval Status for CreditNote" := SalesHeader."Approval Status for CreditNote"::Approved;
        SalesHeader."Terminated Credit Note" := true;
        salesHeader.Insert();
        exit(salesHeader);
    end;

    procedure Saleslinecreate(salesheader1: Record "Sales Header"; additionalchargessub: Record "Credit Note approval");
    var
        saleline: Record "Sales Line";
        newSaleslines: Record "Sales Line";
        item: Record Item;
        BillingCalculationCNRec: Record "Billing Calculation CN";
        GenPostingSetup: Record "General Posting Setup";
    begin
        BillingCalculationCNRec.SetRange("Credit Note ID", additionalchargessub.ID);
        BillingCalculationCNRec.SetRange("Contract ID", additionalchargessub."Contract ID");
        BillingCalculationCNRec.SetRange("Tenant ID", additionalchargessub."Tenant ID");
        if BillingCalculationCNRec.FindSet() then
            repeat
                saleline.Init();
                saleline."Document Type" := saleline."Document Type"::"Credit Memo";
                newSaleslines.SetRange("Document No.", salesheader1."No.");
                newSaleslines.SetRange("Document Type", Enum::"Sales Document Type"::"Credit Memo");
                newSaleslines.SetCurrentKey("Line No.");
                if newSaleslines.FindLast() then
                    saleline."Line No." := newSaleslines."Line No." + 1000
                else
                    saleline."Line No." := 1000;
                saleline."Document No." := salesheader1."No.";
                saleline.Type := saleline.Type::"G/L Account";
                saleline."Sell-to Customer No." := salesheader1."Sell-to Customer No.";
                item.SetRange(Description, BillingCalculationCNRec.Item);
                if item.FindFirst() then begin
                    GenPostingSetup.SetRange("Gen. Prod. Posting Group", item."Gen. Prod. Posting Group");
                    GenPostingSetup.SetRange("Gen. Bus. Posting Group", salesheader1."Gen. Bus. Posting Group");
                    if GenPostingSetup.FindFirst() then
                        saleline.Validate("No.", GenPostingSetup."Sales Account");
                end;
                saleline.Validate("Quantity (Base)", 1);
                saleline.Validate(Quantity, 1);
                saleline.Validate("Unit Price", Abs(BillingCalculationCNRec.Amount));
                saleline.Insert();
            until BillingCalculationCNRec.Next() = 0;
    end;
}