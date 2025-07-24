namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50720 ContractEndApprovalProcess
{
    APIGroup = 'payment';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'contractEndApprovalProcess';
    DelayedInsert = true;
    EntityName = 'contractendapproval';
    EntitySetName = 'contractendapprovals';
    PageType = API;
    ODataKeyFields = SystemId;
    SourceTable = ContractEndProcessApproval;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(contractId; Rec."Contract Id")
                {
                    Caption = 'Contract Id';
                }
                field(propertyMStatus; Rec."Property_M Status")
                {
                    Caption = 'Property Manager Status';
                }
                field(endDate; Rec."End Date")
                {
                    Caption = 'Contract End Date';
                }
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(tenantEmail; Rec."Tenant Email")
                {
                    Caption = 'Requested Date';
                }
                field(startDate; Rec."Start Date")
                {
                    Caption = 'Contract Start Date';
                }
                field(leaseMStatus; Rec."Lease_M Status")
                {
                    Caption = 'Lease Manager Status';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(tenantId; Rec."Tenant Id")
                {
                    Caption = 'Tenant Id';
                }
                field(tenantName; Rec."Tenant Name")
                {
                    Caption = 'Tenant Name';
                }
                field("leaseManagerRemark"; Rec."Lease Manager Remark")
                {
                    Caption = 'Lease Manager Remark';
                }
                field("propertyManagerRemark"; Rec."Property Manager Remark")
                {
                    Caption = 'Property Manager Remark';
                }
                field("value"; Rec."Value")
                {
                    Caption = 'Value';
                }

                field("renewalNotificationtoTenant"; Rec."Renewal Notification to Tenant")
                {
                    Caption = 'Renewal Notification to Tenant';
                }
            }
        }
    }
}
