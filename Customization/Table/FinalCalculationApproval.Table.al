table 50705 "FinalCalculationApproval"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = SystemId, "ID";

    fields
    {
        field(50101; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;

        }
        field(50102; Status; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50107; "Tenant ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }

        field(50104; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }

        field(50111; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';
        }

        field(50103; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';
        }
        field(50109; "Termination Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Termination Date';
        }

        field(50114; "Contract Amount"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount';
        }

    }
    keys
    {
        key(PrimaryKey; "ID")
        {
            Clustered = false;
        }
        key(PK; SystemId)
        {
            Clustered = true;
        }
    }
}