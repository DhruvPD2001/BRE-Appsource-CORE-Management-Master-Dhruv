table 50908 "Approval Final Calculation"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "ID";

    fields
    {
        field(50101; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;
        }

        field(50105; "FC ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'FC ID';
            Editable = false;
        }
        field(50102; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,Approved;
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

        field(50114; "Contract Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount';
        }
        field(50115; "Link"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Calculation Link';
            Editable = false;

        }

    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = false;
        }
    }



}

