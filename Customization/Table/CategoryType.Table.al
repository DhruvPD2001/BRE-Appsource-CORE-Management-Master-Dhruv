table 50903 "Category Type"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = ID;

    fields
    {


        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(50101; "Primary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Item';
            TableRelation = "Primary Item"."Primary Item Type";
        }
        field(50102; "Category Types"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Category';
        }
    }

    keys
    {
        key(PK; "ID", "Primary Item Type", "Category Types")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; ID, "Primary Item Type", "Category Types")
        {

        }
    }
}
