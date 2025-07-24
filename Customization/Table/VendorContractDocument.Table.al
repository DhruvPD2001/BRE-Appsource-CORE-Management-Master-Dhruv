table 50927 "Vendor Contract Document"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor ID';
            Editable = false;
        }
        field(50101; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(50102; "Payment Status"; Enum "Payment Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Status';
        }
        field(50103; "Invoice ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice ID';
        }
        field(50104; "Invoice Document Upload"; Text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice Document Upload';
            InitValue = 'Invoice Upload';
        }
        field(50105; "Receipt Document Upload"; Text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipt Document Upload';
            InitValue = 'Receipt Upload';
        }
        field(50106; "Receipt ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipt ID';
        }
        field(50107; "Invoice Document View"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice Document View';
            InitValue = 'Invoice View';
        }
        field(50108; "Receipt Document View"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipt Document View';
            InitValue = 'Receipt View';
        }
        field(50109; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            Editable = false;
            AutoIncrement = true;
        }
        field(50110; "Invoice Document URL"; Text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice Document URL';
        }
        field(50111; "Receipt Document URL"; Text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipt Document URL';
        }
    }
    keys
    {
        key(PK; "Entry No.", "Vendor ID")
        {
            Clustered = true;
        }
    }
}
