table 50514 "COA Setup Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50500; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50501; "Primary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
            Caption = 'Primary Key';
        }
        field(50502; "Secondary Item"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item where("Item Type Template" = const("Item Type Template Enum"::"Secondary Item"));

            trigger onValidate()
            begin
                PopulateItemDescription(Rec."Secondary Item");
            end;
        }
        field(50503; Residential; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50504; Commercial; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50505; "Residential-Unearned"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50506; "Commercial-Unearned"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure PopulateItemDescription(pItemNo: Text[100])
    var
        item: Record Item;
    begin
        if item.Get(pItemNo) then
            Rec."Secondary Item" := item.Description
        else
            Rec."Secondary Item" := '';
    end;
}