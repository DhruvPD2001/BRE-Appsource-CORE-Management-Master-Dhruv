page 50116 "Community List"
{
    PageType = List;
    SourceTable = Community;
    ApplicationArea = All;
    Caption = 'Community List';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                    ToolTip = 'The unique identifier for the community.';
                }
                field("Sl No."; Rec."Sl No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sl No.';
                    ToolTip = 'The serial number of the community.';
                }
                field("Emirate Name"; Rec."Emirate Name")
                {
                    ApplicationArea = All;
                    Caption = 'Emirate Name';
                    TableRelation = Emirate;
                    Lookup = true;
                    ToolTip = 'The name of the emirate where the community is located.';
                }
                field("Community Code"; Rec."Community Code")
                {
                    ApplicationArea = All;
                    Caption = 'Community Code';
                    ToolTip = 'The unique code assigned to the community.';
                }
                field("Community Name"; Rec."Community Name")
                {
                    ApplicationArea = All;
                    Caption = 'Community Name';
                    ToolTip = 'The name of the community.';
                }
            }
        }
    }
}
