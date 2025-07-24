pageextension 51252 "Item Templ. Card Ext" extends "Item Templ. Card"
{
    layout
    {
        addafter("No. Series")
        {
            field("Item Type"; Rec."Module Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the module type for the item template.';
            }
            field(Types; Rec.Types)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the type of item template.';
            }
            field("Item type template"; Rec."Item type template")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the item type template.';
            }
        }
    }
}