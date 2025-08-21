page 50960 "Calculation Type List"
{
    PageType = List;
    SourceTable = "Calculation Type";
    ApplicationArea = All;
    Caption = 'Calculation Type List';
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
                    ToolTip = 'Specifies the unique identifier for the calculation type.';
                }
                field("Calculation Type"; Rec."Calculation Type")
                {
                    ApplicationArea = All;
                    Caption = 'Calculation Type';
                    ToolTip = 'Specifies the name of the calculation type used for various calculations in the system.';
                }
            }
        }
    }

}
