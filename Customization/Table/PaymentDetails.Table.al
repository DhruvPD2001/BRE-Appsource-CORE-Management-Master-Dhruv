table 50948 "Payment Details"
{
    DataClassification = ToBeClassified;
    Caption = 'Payment Detais';
    fields
    {
        field(50100; "Item Description"; Text[100])
        {
            Caption = 'Payment Description';
            DataClassification = ToBeClassified;
        }
        field(50101; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(50102; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
        }
        field(50103; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
        }
        field(50104; "Payment Status"; Text[100])
        {
            Caption = 'Payment Status';
            DataClassification = ToBeClassified;
        }
        field(50105; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            DataClassification = ToBeClassified;
        }
        field(50106; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
            DataClassification = ToBeClassified;
        }
        field(50107; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(50108; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Contract ID", "Entry No.")
        {
            Clustered = true;
        }
    }
}