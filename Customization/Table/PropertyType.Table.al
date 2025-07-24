table 50101 "Property Type"
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
        field(50101; "Classification Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Classification';
            TableRelation = "Primary Classification"."Classification Name";
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
