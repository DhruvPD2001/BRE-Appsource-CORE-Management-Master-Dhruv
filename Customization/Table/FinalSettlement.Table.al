table 50922 "FinalSettlement"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(50100; "FC ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Receivable FC ID';
        }
        field(50101; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Receivable Contract ID';
        }

        field(50102; "Receivable from the Tenant"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Receivable from the Tenant';
        }

        field(50103; "Payment Processed"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Processed';
        }
        field(50104; "Balance Receivable"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Balance Receivable';
        }

        field(50105; "PaymentStatus"; Option)
        {
            OptionMembers = "Pending","Received";
            Caption = 'Payment Status';
        }


        field(50106; "Receivable Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Amount';
        }
        field(50107; "Receivable Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }
        field(50108; "Receivable Payment mode"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment mode';
            TableRelation = "Payment Type"."Payment Method";
        }
        field(50109; "Receivable Payment Status"; Enum "Payment Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Status';

            trigger OnValidate()
            var
                paymentmode2Grid: Record FinalSettlement;
                TempBlob: Codeunit "Temp Blob";
                Email: Codeunit "FS_Receivable Payment Receipt";
                FinalSettlementPosting: Codeunit "Final Settlement Posting Mgt.";
                azureBlobUploader: Codeunit "Azure AD Blob Storage";
                RecRef: RecordRef;
                fileName: Text[250];
                uploadResult: Text;
                folderName: Text[250];
                inStream: InStream;
                ReportID: Integer;
                OutStream: OutStream;
            begin
                if Rec."Receivable Payment Status" = Enum::"Payment Status"::Received then begin
                    FinalSettlementPosting.PostFinalSettlementAmount(Rec);
                    Email.SendEmail(Rec);
                    ReportID := 50114;
                    paymentmode2Grid.Reset();
                    paymentmode2Grid.SetRange("Tenant ID", Rec."Tenant ID");
                    paymentmode2Grid.SetRange("Contract ID", Rec."Contract ID");
                    if not paymentmode2Grid.FindFirst() then
                        Error('Not avavilable');
                    RecRef.GetTable(paymentmode2Grid);
                    RecRef.GetTable(Rec);
                    TempBlob.CreateOutStream(OutStream);
                    Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
                    TempBlob.CreateInStream(inStream);
                    fileName := 'Receipt_' + Format(Rec."Contract ID") + Format(Rec."FC ID") + '.pdf';
                    folderName := 'Payment Receipt';
                    uploadResult := azureBlobUploader.UploadDocumentToBlob(inStream, fileName, folderName);
                    if fileName <> '' then begin
                        Rec."Payment Receipt" := fileName;
                        Rec."Payment Receipt document URL" := CopyStr(uploadResult, 1, StrLen(uploadResult));
                        Rec.Modify();
                        Message('File uploaded successfully: %1', fileName);
                    end;
                    Rec.Modify();

                end
            end;
        }

        field(50110; "Receivable Cheque No."; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque No.';
        }

        field(50111; "Deposit Bank"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin

                if "Deposit Bank" <> '' then
                    if BankAccountRec.Get("Deposit Bank") then
                        "Deposit Bank" := BankAccountRec."Name";
            end;
        }

        field(50112; "Deposit Status"; Option)
        {
            Caption = 'Deposit Status';
            OptionMembers = "-","N","Y";
        }

        field(50113; "Payment Receipt"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Receipt';
            Editable = false;

        }
        field(50114; "Payment Receipt document URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Receipt Document URL';
        }
        field(50117; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Receivable Tenant ID';
        }
        field(50120; "Tenant Email"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Email';
        }
        field(50122; "Tenant Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Name';
        }
        field(50118; "Invoiced"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoiced';
        }
        field(50119; "Invoice ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice ID';
        }
        field(50121; "View Reciept document URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice ID';
        }
    }
    keys
    {
        key(PK; "FC ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if Rec."Receivable Payment Mode" = 'Cheque' then
            if DelChr(Rec."Receivable Cheque No.", '=', ' ') = '' then
                Error('Cheque Number cannot be blank when Payment Mode is Cheque.');
    end;

}

