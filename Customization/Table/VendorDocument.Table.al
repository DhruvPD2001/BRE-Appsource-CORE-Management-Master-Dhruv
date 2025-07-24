table 50950 "Vendor Document"
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
        field(50101; "Document Type"; Option)
        {
            OptionMembers = " ","ID Proof","Adress Proof","VAT Registration","Real-Estate Agency Registration","Other Registration";
            Caption = 'Document Type';
        }
        field(50102; "Document No."; Code[100])
        {
            Caption = 'Document No.';
        }
        field(50103; "Document Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Name';
        }
        field(50104; "Document Upload"; Text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Upload';
            InitValue = 'Upload';
        }
        field(50107; "Document View"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document View';
            InitValue = 'View';
        }
        field(50109; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            Editable = false;
            AutoIncrement = true;
        }
        field(50110; "Document URL"; Text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document URL';
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
