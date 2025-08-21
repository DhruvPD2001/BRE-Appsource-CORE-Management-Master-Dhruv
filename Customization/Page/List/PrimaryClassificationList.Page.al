page 50303 "Primary Classification List"
{
    PageType = List;
    SourceTable = "Primary Classification";
    ApplicationArea = All;
    Caption = 'Primary Classification List';
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
                    ToolTip = 'Unique identifier for the primary classification.';
                }
                field("Classification Name"; Rec."Classification Name")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Classification Name';
                    ToolTip = 'Name of the primary classification.';
                }
            }
        }
    }
}
