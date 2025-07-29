table 50900 "Primary Item"
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
            Caption = 'Primary Item Type';
        }
    }
    keys
    {
        key(PK; "ID", "Primary Item Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, "Primary Item Type")
        {
        }
    }
}
