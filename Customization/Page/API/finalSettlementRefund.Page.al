namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50734 finalSettlementRefund
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestste';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'finalSettlementRefund';
    DelayedInsert = true;
    EntityName = 'finalSettlementRefund';
    EntitySetName = 'finalSettlementRefunds';
    PageType = API;
    SourceTable = FinalSettlementRefund;
    DeleteAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(balanceRefundable; Rec."Balance Refundable")
                {
                    Caption = 'Balance Refundable';
                }
                field(contractID; Rec."Contract ID")
                {
                    Caption = 'Refund Contract ID';
                }
                field(fcID; Rec."FC ID")
                {
                    Caption = 'Refund FC ID';
                }
                field(netRefundToTheTenant; Rec."Net Refund to the Tenant")
                {
                    Caption = 'Net Refund to the Tenant';
                }
                field(payReceiptProofDocumentURL; Rec."Pay Receipt/Proof document URL")
                {
                    Caption = 'Payment Receipt/Proof document URL';
                }
                field(paymentReceiptProof; Rec."Payment Receipt/Proof")
                {
                    Caption = 'Payment Receipt/Proof';
                }
                field(refundChequeNo; Rec."Refund Cheque No.")
                {
                    Caption = 'Cheque No.';
                }
                field(refundDueDate; Rec."Refund Due Date")
                {
                    Caption = 'Due Date';
                }
                field(refundPaymentStatus; Rec."Refund Payment Status")
                {
                    Caption = 'Payment Status';
                }
                field(refundPaymentMode; Rec."Refund Payment mode")
                {
                    Caption = 'Payment mode';
                }
                field(refundProcessed; Rec."Refund Processed")
                {
                    Caption = 'Refund Processed';
                }
                field(refundStatus; Rec."Refund Status")
                {
                    Caption = 'Refund Status';
                }
                field(refundTotalAmount; Rec."Refund Total Amount")
                {
                    Caption = 'Total Amount';
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
                    Caption = 'Refund Tenant ID';
                }
            }
        }
    }
}
