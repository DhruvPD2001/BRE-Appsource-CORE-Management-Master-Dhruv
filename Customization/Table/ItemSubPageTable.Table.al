table 50506 ItemSubPageTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50500; Id; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(50501; UnitName; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

}