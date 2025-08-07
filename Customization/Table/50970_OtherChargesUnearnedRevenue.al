table 50970 "Other Charges UnearnedRevenue"
{

    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "No."; Integer)
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
                // Check if a record with the selected Secondary Item Type exists
                SecondaryItemRec.SetRange("No.", Rec."Item Type");
                if SecondaryItemRec.FindFirst() then
                    "Item Type" := SecondaryItemRec.Description;
            end;
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
