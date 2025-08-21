page 50310 "Owner Profile List"
{
    PageType = List;
    SourceTable = "Owner Profile";
    ApplicationArea = All;
    Caption = 'Owner Profiles';
    UsageCategory = Lists;
    CardPageId = 50309;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Owner ID"; rec."Owner ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the owner profile.';
                }
                field("Full Name"; rec."Full Name")
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    ToolTip = 'Full name of the owner.';
                }
                field("Nationality"; rec."Nationality")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nationality of the owner.';

                }
                field("Phone Number"; rec."Phone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Contact phone number of the owner.';
                }
                field("Email Address"; rec."Email Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Email address of the owner.';
                }
                field("Status"; rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Current status of the owner profile, such as Active or Inactive.';
                }

                field("Ejari Registration Number"; Rec."Ejari Registration Number")
                {
                    ApplicationArea = All;
                    Caption = 'Ejari Reg. No.';
                }
                field("RERA Owner ID"; Rec."RERA Owner ID")
                {
                    ApplicationArea = All;
                    Caption = 'RERA Owner ID';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
#pragma warning disable AW0005
            action(NewOwner)
#pragma warning restore AW0005
            {
                Caption = 'New Owner';
                ApplicationArea = All;
                ToolTip = 'Create a new owner profile.';
                trigger OnAction()
                begin
                    Page.RunModal(Page::"Owner Profile Card");
                end;
            }
        }
    }
}
