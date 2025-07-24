table 50952 "Brokerage Calculation"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "Owner ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner ID';
            TableRelation = "Owner Profile"."Owner ID";
        }
        field(50101; "Property ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property ID';
            TableRelation = "Property Registration"."Property ID";
        }
        field(50102; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }
        field(50103; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }
        field(50104; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            AutoIncrement = true;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
        key(Secondary; "Owner ID", "Property ID")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Property ID", "Owner ID")
        {
        }
    }
}
