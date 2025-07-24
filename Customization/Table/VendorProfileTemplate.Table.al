table 53759 "Vendor Profile Template"
{
    Caption = 'Vendor Profile Template';
    TableType = Normal;
    DataClassification = ToBeClassified;
    fields
    {
        field(53100; Code; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53101; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53102; Module; Enum "Module Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(53103; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}