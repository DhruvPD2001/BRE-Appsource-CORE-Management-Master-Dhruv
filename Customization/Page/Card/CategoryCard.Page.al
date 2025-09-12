page 50905 "Category Card"
{
    PageType = Card;
    SourceTable = "Category Type";
    ApplicationArea = All;
    Caption = 'Category Type';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Category Type Details';
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the unique identifier for the category type.';
                }
                field("Primary Item Type"; Rec."Primary Item Type")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Item Type';
                    ToolTip = 'Select the associated Primary Item Type.';
                    ShowMandatory = true;
                    NotBlank = true;

                }
                field("Category Types"; Rec."Category Types")
                {
                    ApplicationArea = All;
                    Caption = 'Category Types';
                    ToolTip = 'Enter the Category Types.';
                    ShowMandatory = true;
                    NotBlank = true;
                }
            }
        }
    }


}
