page 51257 "Community Card"
{
    PageType = Card;
    SourceTable = Community;
    ApplicationArea = All;
    Caption = 'Community Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Community Details';
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the community.';
                }
                field("Sl No."; Rec."Sl No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the serial number for the community.';
                }
                field("Community Name"; Rec."Community Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the community.';
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Emirate Name"; Rec."Emirate Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the emirate associated with the community.';
                    ShowMandatory = true;
                    NotBlank = true;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Community Code"; Rec."Community Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the community.';
                }

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("Community Name");
        Rec.TestField("Emirate Name");
    end;
}
