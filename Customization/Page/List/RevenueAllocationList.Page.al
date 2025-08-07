page 50124 "Revenue Allocation List"
{
    PageType = List;
    SourceTable = "Revenue Allocation Details";
    ApplicationArea = All;
    Caption = 'Revenue Allocation List';
    UsageCategory = Lists;
    CardPageId = 50122;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                    ToolTip = 'The unique identifier for the revenue allocation entry.';
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                    Caption = 'Month';
                    ToolTip = 'The month for which the revenue allocation is applicable.';
                }
                field("Financial Year"; Rec."Financial Year")
                {
                    ApplicationArea = All;
                    Caption = 'Financial Year';
                    ToolTip = 'The financial year associated with the revenue allocation.';
                }
            }
        }
    }
}
