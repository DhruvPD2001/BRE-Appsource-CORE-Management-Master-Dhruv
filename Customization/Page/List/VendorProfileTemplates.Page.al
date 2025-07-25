page 53761 "Vendor Profile Templates"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Vendor Profile Template";
    CardPageId = "Vendor Profile Template";

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the vendor profile template.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the vendor profile template.';
                }
            }
        }
    }
}