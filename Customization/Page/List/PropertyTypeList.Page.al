page 50111 "Property Type List"
{
    PageType = List;
    SourceTable = "Property Type";
    ApplicationArea = All;
    Caption = 'Property Type List';
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
                    ToolTip = 'The unique identifier for the property type.';
                }
                field("Classification Name"; Rec."Classification Name")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Classification';
                    TableRelation = "Primary Classification";
                    Lookup = true;
                    ToolTip = 'The primary classification of the property type.';
                }
                field("Property Type"; Rec."Property Type")
                {
                    ApplicationArea = All;
                    Caption = 'Property Type';
                    ToolTip = 'The name of the property type.';
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
                ToolTip = 'Create a new property type.';

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
