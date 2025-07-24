table 50302 "Secondary Classification"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = ID;

    fields
    {
        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true; // Automatically increment the ID
            Editable = false; // Make it read-only for the user
        }
        field(50101; "Classification Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Classification';
            TableRelation = "Primary Classification"."Classification Name";

            // This will store the ID of the Primary Classification for lookup
        }
        field(50102; "Property Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Type';
        }
    }

    keys
    {
        key(PK; "ID", "Property Type", "Classification Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; ID, "Classification Name", "Property Type")
        {

        }
    }
}
