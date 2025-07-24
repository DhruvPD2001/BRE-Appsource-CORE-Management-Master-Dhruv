table 50504 "Unit Document Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "UnitID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'UnitID';
        }
        field(50101; "Document Type"; Enum "Unit Document Type Enum")
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Type';
        }
        field(50102; "Document Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Name';
        }
        field(50103; "Upload Document"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Upload Document';
        }
        field(50104; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(50105; "View & Download"; Text[20])
        {
            DataClassification = ToBeClassified;

            InitValue = 'View';
        }
        field(50106; "Download"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Download';
            InitValue = 'Download';
        }

        field(50107; "View Document URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Document URL';
        }

    }

    keys
    {
        key(Key1; UnitID, "Entry No.")
        {
            Clustered = true;
        }
    }

}