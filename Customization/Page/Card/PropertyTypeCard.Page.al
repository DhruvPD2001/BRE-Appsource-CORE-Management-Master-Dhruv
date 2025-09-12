page 51259 "Property Type Card"
{
    PageType = Card;
    SourceTable = "Property Type";
    ApplicationArea = All;
    Caption = 'Property Type Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Property Type Details';
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the unique identifier for the property type.';
                }
                field("Classification Name"; Rec."Classification Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Enter the classification name.';
                    NotBlank = true;
                }
                field("Property Type"; Rec."Property Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    NotBlank = true;
                    ToolTip = 'Enter the property type.';

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("Classification Name");
        Rec.TestField("Property Type");
    end;
}
