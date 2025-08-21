page 50956 "Vendor Category List"
{
    PageType = List;
    SourceTable = "Vendor Category";
    ApplicationArea = All;
    Caption = 'Vendor Category List';
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
                    ToolTip = 'Specifies the unique identifier for the vendor category.';
                }
                field("Vendor Category Type"; Rec."Vendor Category Type")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Category Name';
                    ToolTip = 'Specifies the name of the vendor category, such as Contractor, Supplier, or Service Provider.';
                }
            }
        }
    }

}
