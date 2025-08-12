page 50983 "RevenueAllocationApproval List"
{
    PageType = List;
    SourceTable = "Revenue Allocation Approval";
    ApplicationArea = All;
    Caption = 'Revenue Allocation Approval List';
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                    ToolTip = 'Specifies the current status of the revenue allocation approval.';
                }
                field("RA_ID"; Rec."RA_ID")
                {
                    ApplicationArea = All;
                    Caption = 'RA_ID';
                    Editable = false;
                    ToolTip = 'Specifies the unique identifier for the revenue allocation approval.';
                }
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                    Editable = false;
                    DrillDown = true;
                    ToolTip = 'Specifies the unique identifier for the revenue allocation approval record.';

                    trigger OnDrillDown()
                    var
                        revenueallocation: Record "Revenue Allocation Details";
                    begin
                        revenueallocation.SetRange("No.", Rec."ID");
                        if revenueallocation.FindSet() then
                            PAGE.RunModal(PAGE::"Revenue Allocation Card", revenueallocation)
                        else
                            Message('No Revenue Allocation found using FindFirst either.');
                    end;
                }
                field("Financial Year"; Rec."Financial Year")
                {
                    ApplicationArea = All;
                    Caption = 'Financial Year';
                    Editable = false;
                    ToolTip = 'Specifies the financial year for which the revenue allocation approval is applicable.';
                }
                field("Month"; Rec."Month")
                {
                    ApplicationArea = All;
                    Caption = 'Month';
                    Editable = false;
                    ToolTip = 'Specifies the month for which the revenue allocation approval is applicable.';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Visible = IsFinanceManager;
                ToolTip = 'Approve the selected revenue allocation entry.';

                trigger OnAction()
                var
                    revenueallocation: Record "Revenue Allocation Details";
                    RevenueAllocationPosting: Codeunit "Revenue Allocation Posting";
                begin
                    if Rec.Status = Rec.Status::Approved then
                        Error('This entry is already approved');

                    if Confirm('Do you want to approve this entry?') then begin
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();

                        if revenueallocation.Get(Rec."ID") then begin
                            revenueallocation.Status := revenueallocation.Status::Approve;
                            revenueallocation.Modify();

                            RevenueAllocationPosting.PostRevenueAllocation(revenueallocation);
                        end;

                        Message('Entry has been approved successfully!');
                    end;
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Cancel;
                Visible = IsFinanceManager;
                ToolTip = 'Reject the selected revenue allocation entry.';


                trigger OnAction()
                var
                    revenueallocation: Record "Revenue Allocation Details";
                begin
                    if Rec.Status = Rec.Status::Reject then
                        Error('This entry is already rejected');
                    Rec.Status := Rec.Status::Reject;
                    Rec.Modify();

                    if revenueallocation.Get(Rec."ID") then begin
                        revenueallocation.Status := revenueallocation.Status::Reject;
                        revenueallocation.Modify();
                    end;

                    Message('Entry has been rejected successfully!');
                end;
            }
        }

        area(Promoted)
        {
            actionref(Approve_; Approve) { }
            actionref(Reject_; Reject) { }
        }
    }

    trigger OnOpenPage()
    begin
        IsFinanceManager := VisibleApproveAction();
    end;

    procedure VisibleApproveAction(): Boolean
    var
        UserPersonalization: Record "User Personalization";
    begin

        if UserPersonalization.Get(UserSecurityId()) then
            case UserPersonalization."Profile ID" of
                'PROPERTY MANAGER':
                    exit(false);
                'LEASE_MANAGER':
                    exit(false);
                'finance manager':
                    exit(true);
            end;


        exit(false);
    end;

    var
        IsFinanceManager: Boolean;

}
