table 50114 "Carry Forward Grid"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
            Editable = false;
        }
        field(50101; "Security Deposit"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Security Deposit';
            Editable = false;
        }
        field(50102; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Amount';
            Editable = false;
        }
        field(50103; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(50104; "New Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Entry No.", "Contract ID")
        {
            Clustered = true;
        }
    }
}