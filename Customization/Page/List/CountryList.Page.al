page 50112 "Country List"
{
    PageType = List;
    SourceTable = Country;
    ApplicationArea = All;
    Caption = 'Country List';
    UsageCategory = Lists;
    CardPageId = 51255;

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
                    ToolTip = 'The unique identifier for the country.';
                }
                field("Sl No."; Rec."Sl No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sl No.';
                    ToolTip = 'The serial number of the country.';
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country Code';
                    ToolTip = 'The unique code assigned to the country.';
                }
                field("Country Name"; Rec."Country Name")
                {
                    ApplicationArea = All;
                    Caption = 'Country Name';
                    ToolTip = 'The name of the country.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(New)
            {
                ApplicationArea = All;
                Caption = 'New';
                Image = New;
                ToolTip = 'Create a new country.';
                trigger OnAction()
                begin
                    Rec.Init();
                    Rec.Insert(true);
                    CurrPage.Update();
                end;
            }
        }

        area(Promoted)
        {
            actionref(new_; New) { }
        }
    }
}
