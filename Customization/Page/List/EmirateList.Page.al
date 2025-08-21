page 50114 "Emirate List"
{
    PageType = List;
    SourceTable = Emirate;
    ApplicationArea = All;
    Caption = 'Emirate List';
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
                }
                field("Sl No."; Rec."Sl No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sl No.';
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country Code';
                    TableRelation = Country;
                    Lookup = true;
                }
                field("Emirate Name"; Rec."Emirate Name")
                {
                    ApplicationArea = All;
                    Caption = 'Emirate Name';
                }
            }
        }
    }
}
