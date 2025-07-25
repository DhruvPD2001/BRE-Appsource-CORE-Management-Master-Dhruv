table 50301 "Primary Classification"
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
            Caption = 'Primary Classification Name';
        }
    }
    keys
    {
        key(PK; "ID", "Classification Name")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, "Classification Name")
        {
        }
    }
}
