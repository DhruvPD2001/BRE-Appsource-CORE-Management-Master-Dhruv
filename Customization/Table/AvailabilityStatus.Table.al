table 50304 "Availability Status"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "ID";

    fields
    {
        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true; // Automatically increment the ID
            Editable = false; // Make it read-only for the user
        }
        field(50101; "Status"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Status Name';

        }
    }

    keys
    {
        key(PK; "ID", "Status")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, "Status")
        {

        }
    }



}
