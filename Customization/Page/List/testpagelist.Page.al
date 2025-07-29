page 50712 "testpagelist"
{
    PageType = List;
    SourceTable = "Company Data";
    ApplicationArea = All;
    Caption = 'Company Data';
    CardPageId = 50701;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Company ID"; Rec."Company ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Your Company ID';
                }

                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Your Company Name';
                }

                field("Company Logo"; Rec."Company Logo")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Your Company logo';
                }
                field("Tenant id"; Rec."Tenant id")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Tenant ID';
                }
                field("Environment Name"; Rec."Environment Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Environment Name';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(UploadLogo)
            {
                ToolTip = 'When you can click on the button then logo will be uploaded';
                Image = Apply;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    MESSAGE('Logo uploaded successfully.');
                end;
            }
        }
    }
}
