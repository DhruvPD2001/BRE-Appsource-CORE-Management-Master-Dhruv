page 50901 "Primary Item List"
{
    PageType = List;
    SourceTable = "Primary Item";
    ApplicationArea = All;
    Caption = 'Primary Item List';
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
                    ToolTip = 'Specifies the unique identifier for the primary item.';
                }
                field("Primary Item Type"; Rec."Primary Item Type")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Item Name';
                    ToolTip = 'Specifies the name of the primary item.';
                }
            }
        }
    }

}
