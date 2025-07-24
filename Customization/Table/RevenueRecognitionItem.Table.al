table 50961 "Revenue Recognition Item"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "RR_No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
            Editable = false;
        }
        field(50101; "Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Type';
            TableRelation = Item WHERE("Item type template" = const("Item Type Template Enum"::"Secondary Item"), "Charges Status" = CONST("Regular Charges"));
            trigger OnValidate()
            var
                SecondaryItemRec: Record Item;
            begin
                SecondaryItemRec.SetRange("No.", Rec."Item Type");
                if SecondaryItemRec.FindFirst() then
                    "Item Type" := SecondaryItemRec.Description;
            end;
        }
        field(50102; "Link"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Link';
        }
        field(50103; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
}
