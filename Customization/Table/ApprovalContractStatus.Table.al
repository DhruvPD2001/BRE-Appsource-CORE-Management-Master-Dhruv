table 50311 "Approval Contract Status"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = SystemId, "ID";

    fields
    {
        field(50101; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(50102; "Status"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(50103; "Lease ID"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lease Manager';
        }
        field(50104; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(50105; "Renewal Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal Contract ID';
        }
        field(50106; "Tenancy Contract Status"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenancy Contract Status';
        }
    }
    keys
    {
        key(PrimaryKey; "ID")
        {
            Clustered = false;
        }
        key(PK; SystemId)
        {
            Clustered = true;
        }
    }
}

