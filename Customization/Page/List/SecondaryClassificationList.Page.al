page 50304 "Secondary Classification List"
{
    PageType = List;
    SourceTable = "Secondary Classification";
    ApplicationArea = All;
    Caption = 'Unit Type List';
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
                    ToolTip = 'Unique identifier for the secondary classification.';
                }
                field("Classification Name"; Rec."Classification Name")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Classification';
                    TableRelation = "Primary Classification";
                    // Display the Primary Classification description
                    Lookup = true; // Enable lookup to Primary Classification
                    ToolTip = 'Name of the primary classification associated with the secondary classification.';
                }
                field("Property Type"; Rec."Property Type")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Type';
                    ToolTip = 'Type of property associated with the secondary classification.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
#pragma warning disable AW0005
#pragma warning disable AW0011
            action(New)
#pragma warning restore AW0011
#pragma warning restore AW0005
            {
                ApplicationArea = All;
                Caption = 'New';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Create a new secondary classification.';
                trigger OnAction()
                begin
                    Rec.Init();
                    Rec.Insert(true);
                    CurrPage.Update();
                end;
            }
        }
    }

}
