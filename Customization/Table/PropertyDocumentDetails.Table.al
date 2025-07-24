table 50501 "Property Document Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "PropertyID"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PropertyID';
        }
        field(50101; "Document Type"; Enum "Property Document Type Enum")
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
            AutoIncrement = true;
            Caption = 'Entry No';
        }

        field(50105; "View & Download"; Text[220])
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
        key(Key1; "Entry No.", "PropertyID")
        {
            Clustered = true;
        }
    }

}