page 50523 "COA Setup List"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "COA Setup Line";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Item; Rec."Secondary Item")
                {
                    ApplicationArea = All;
                    ToolTip = 'Secondary Item';
                }
                field(Residential; Rec.Residential) { ApplicationArea = All; ToolTip = 'Residential Property'; }
                field(Commercial; Rec.Commercial) { ApplicationArea = All; ToolTip = 'Commercial Property'; }
                field("Residential-Unearned"; Rec."Residential-Unearned") { ApplicationArea = All; ToolTip = 'Residential-Unearned'; }
                field("Commercial-Unearned"; Rec."Commercial-Unearned") { ApplicationArea = All; ToolTip = 'Commercial-Unearned'; }

            }
        }
    }
}