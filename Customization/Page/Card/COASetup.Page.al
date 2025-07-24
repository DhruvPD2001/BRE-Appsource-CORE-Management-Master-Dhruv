page 50524 "COA Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "COA Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Residential Rent"; Rec."Residential Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for residential rent.';
                }
                field("Commercial Rent"; Rec."Commercial Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for commercial rent.';
                }
                field("Residential Unearned Rent"; Rec."Residential Unearned Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for unearned residential rent.';
                }
                field("Commercial Unearned Rent"; Rec."Commercial Unearned Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for unearned commercial rent.';
                }

            }
            part(COASetupLines; "COA Setup List")
            {
                ApplicationArea = All;
                Caption = 'COA Setup Lines';
                SubPageLink = "Primary Key" = field("Primary Key");
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}