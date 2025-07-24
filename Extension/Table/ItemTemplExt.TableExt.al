tableextension 51251 "Item Templ. Ext" extends "Item Templ."
{
    fields
    {
        field(50140; "Module Type"; Enum "Module Enum")
        {
            Caption = 'Module Type';
            DataClassification = ToBeClassified;
        }
        field(50142; "Types"; Enum "Item Template Enum")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(50144; "Item type template"; Enum "Item Type Template Enum")
        {
            Caption = 'Item type template';
            DataClassification = ToBeClassified;
        }
    }
}