namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50716 OnlinePaymentApproval
{
    APIGroup = 'payment';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'onlinePaymentApproval';
    DelayedInsert = true;
    EntityName = 'onlinePaymentApproval';
    EntitySetName = 'onlinePaymentApprovals';
    PageType = API;
    SourceTable = OnlinePaymentApproval;

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
                field(paymentSeries; Rec."Payment Series")
                {
                    Caption = 'Payment Series';
                }
                field("paymenttransactionID"; Rec."Payment transaction ID")
                {
                    Caption = 'Payment transaction ID';
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
                field("tenantName"; Rec."Tenant Name")
                {
                    Caption = 'Tenant Name';
                }
                field(totalAmount; Rec."Total Amount")
                {
                    Caption = 'Amount with vat';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
            }
        }
    }
}
