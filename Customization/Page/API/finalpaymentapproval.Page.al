namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50733 finalpaymentapproval
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestste';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'finalpaymentapproval';
    DelayedInsert = true;
    EntityName = 'finalPaymentApproval';
    EntitySetName = 'finalPaymentApprovals';
    PageType = API;
    SourceTable = finalPaymentApproval;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(contractID; Rec."Contract ID")
                {
                    Caption = 'Contract ID';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(paymentDate; Rec."Payment Date")
                {
                    Caption = 'Payment Date';
                }
                field(paymentMode; Rec."Payment Mode")
                {
                    Caption = 'Payment Mode';
                }
                field(paymentTransactionID; Rec."Payment transaction ID")
                {
                    Caption = 'Payment transaction ID';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
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
                field(tenantID; Rec."Tenant ID")
                {
                    Caption = 'Tenant ID';
                }
                field(tenantName; Rec."Tenant Name")
                {
                    Caption = 'Tenant Name';
                }
                field(totalAmount; Rec."Total Amount")
                {
                    Caption = 'Total Amount';
                }
            }
        }
    }
}
