page 51258 "Primary Classification Card"
{
    PageType = Card;
    SourceTable = "Primary Classification";
    ApplicationArea = All;
    Caption = 'Primary Classification Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Primary Classification Details';
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the unique identifier for the primary classification.';
                }
                field("Classification Name"; Rec."Classification Name")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Classification Name';
                    ShowMandatory = true;
                    NotBlank = true;
                    ToolTip = 'Enter the primary classification name.';

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
            }
        }

    }


}



