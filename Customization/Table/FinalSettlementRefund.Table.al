table 50923 "FinalSettlementRefund"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "FC ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Refund FC ID';
        }
        field(50101; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Refund Contract ID';
        }
        field(50102; "Net Refund to the Tenant"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Net Refund to the Tenant';
        }
        field(50103; "Refund Processed"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Refund Processed';
        }
        field(50104; "Balance Refundable"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Balance Refundable';
        }
        field(50105; "Refund Status"; Option)
        {
            OptionMembers = "Pending","Paid";
            Caption = 'Refund Status';
        }
        field(50106; "Refund Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Amount';
        }
        field(50107; "Refund Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }
        field(50108; "Refund Payment mode"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment mode';
            TableRelation = "Payment Type"."Payment Method";
        }
        field(50109; "Refund Payment Status"; Option)
        {
            OptionMembers = "Scheduled","Due","Overdue","Paid","Cancelled";
            Caption = 'Payment Status';
        }
        field(50110; "Refund Cheque No."; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque No.';
        }
        field(50111; "Payment Receipt/Proof"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Receipt/Proof';
            InitValue = 'View';
        }
        field(50112; "Pay Receipt/Proof document URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Receipt/Proof document URL';
        }
        field(50119; "Deposit Bank"; Code[100])
        {
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
        field(50114; "Tenant ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Refund Tenant ID';
        }
        field(50115; "Adjust Security Deposit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50116; "Adjust Chiller Deposit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50117; "Adjust other deposit"; Decimal)
        {
            DataClassification = ToBeClassified;
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
        if Rec."Refund Payment Mode" = 'Cheque' then
            if DelChr(Rec."Refund Cheque No.", '=', ' ') = '' then
                Error('Cheque Number cannot be blank when Payment Mode is Cheque.');
    end;
}
