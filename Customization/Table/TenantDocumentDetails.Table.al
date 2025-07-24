table 50502 "Tenant Document Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'TenantID';
        }
        field(50101; "Document Type"; Enum "Tenant Document Type Enum")
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
            Caption = 'Entry No';
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
        field(50107; "Tenant Screening"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50108; "View Document URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Document URL';
        }
    }

    keys
    {
        key(Key1; No, "Entry No.")
        {
            Clustered = true;
        }
    }
}