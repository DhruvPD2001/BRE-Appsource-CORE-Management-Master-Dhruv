table 50500 "DocumentUploadDetails"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "OwnerId"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'OwnerId';
        }

        field(50101; "Document Type"; Enum "Document Type Enum")
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
        }

        field(50105; "View & Download"; Text[20])
        {
            DataClassification = ToBeClassified;
            InitValue = 'View';
        }

        field(50106; "Download"; Text[20])
        {
            DataClassification = ToBeClassified;
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
        key(Key1; "Entry No.", OwnerId)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}