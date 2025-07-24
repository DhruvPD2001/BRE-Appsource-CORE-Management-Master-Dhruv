table 50930 "Vendor Category"
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
        field(50101; "Vendor Category Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Category Type';
        }
    }
    keys
    {
        key(PK; "ID", "Vendor Category Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, "Vendor Category Type")
        {
        }
    }
}
