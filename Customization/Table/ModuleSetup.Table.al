table 50505 "Module Setup"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(50501; "Module Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50502; "Is Active"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50504; "Extension Name"; Code[50])
        {
            Caption = 'Extension Name';
        }

        field(50505; "Business Unit Code"; Code[20])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit".Code;
        }
    }

    keys
    {
        key(Key1; "Module Name")
        {
            Clustered = true;
        }
    }
}