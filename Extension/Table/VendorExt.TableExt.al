tableextension 50301 "Vendor Ext" extends Vendor
{
    fields
    {
        field(50114; "Country"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country';
            TableRelation = Country."Country Code";
            trigger OnValidate()
            begin
                Emirate := Emirate::" ";
                "Community" := '';
            end;
        }
        field(50115; "Emirate"; Enum Emirates)
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirate';
            TableRelation = Emirate."Emirate Name"
                 where("Country Code" = field(Country));
            trigger OnValidate()
            begin
                "Community" := '';
            end;
        }
        field(50116; "Community"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Community';
            TableRelation = Community."Community Name"
                 where("Emirate Name" = field(Emirate));
        }
        field(50100; "Vendor Category"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Category';
            TableRelation = "Vendor Category"."Vendor Category Type";
        }
    }
}
