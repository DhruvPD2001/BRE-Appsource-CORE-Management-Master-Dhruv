table 50507 "PDC Transaction"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "PDC ID";
    fields
    {
        field(50501; "PDC ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50502; "Tenant Id"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }

        field(50509; "Tenant Name Display"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Tenant Id"))); // Displays Customer Name
        }

        field(50504; "Cheque Number"; Text[100])
        {
            DataClassification = CustomerContent;

        }
        field(50505; "Cheque Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50506; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50507; "Cheque Status"; Enum "PDC Status Type Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50508; "Contract ID"; Integer)
        {
            TableRelation = "Tenancy Contract";
        }

        field(50510; "Reason"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50511; "Old Cheque#"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50512; "Bank Name"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin
                if "Bank Name" <> '' then
                    if BankAccountRec.Get("Bank Name") then
                        "Bank Name" := BankAccountRec."Name";
            end;
        }

        field(50513; "Approval Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
        }

        field(50517; "View Document URL"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(50514; View; text[250])
        {
            DataClassification = ToBeClassified;
            InitValue = 'View Document';
        }

        field(50515; Selected; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50516; "payment Series"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "PDC ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";
        PDCReceivedCashReceiptJournal: Codeunit 50514;

    begin
        if "PDC ID" = '' then
            "PDC ID" := NoSeriesMgt.GetNextNo('PDCTRANID', Today(), true);
        PDCReceivedCashReceiptJournal.ProcessPDCTransaction(Rec);
    end;
}