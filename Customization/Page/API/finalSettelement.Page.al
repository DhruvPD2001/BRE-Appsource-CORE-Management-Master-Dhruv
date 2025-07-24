namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50731 finalSettelement
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'finalSettelement';
    DelayedInsert = true;
    EntityName = 'finalSettlement';
    EntitySetName = 'finalSettlements';
    PageType = API;
    SourceTable = FinalSettlement;
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(contractId; Rec."Contract ID")
                {
                    Caption = 'Contract ID';
                }
                field(receivablecontractId; Rec."Contract ID")
                {
                    Caption = 'Receivable Contract ID';
                }
                field(depositBank; Rec."Deposit Bank")
                {
                    Caption = 'Deposit Bank';
                }
                field(depositStatus; Rec."Deposit Status")
                {
                    Caption = 'Deposit Status';
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
                field(receivabletenantID; Rec."Tenant ID")
                {
                    Caption = 'Receivable Tenant ID';
                }

                field("receivableTotalAmount"; Rec."Receivable Total Amount")
                {
                    Caption = 'Receivable Total Amount';
                }
                field("receivableDueDate"; Rec."Receivable Due Date")
                {
                    Caption = 'Receivable Due Date';
                }
                field("receivablePaymentmode"; Rec."Receivable Payment mode")
                {
                    Caption = 'Receivable Payment mode';
                }
                field("receivablePaymentStatus"; Rec."Receivable Payment Status")
                {
                    Caption = 'Receivable Payment Status';
                }
                field("receivableChequeNo"; Rec."Receivable Cheque No.")
                {
                    Caption = 'Receivable Cheque No.';
                }
                field("receivablefromtheTenant"; Rec."Receivable from the Tenant")
                {
                    Caption = 'Receivable from the Tenant';
                }
                field("paymentProcessed"; Rec."Payment Processed")
                {
                    Caption = 'Payment Processed';
                }
                field("balanceReceivable"; Rec."Balance Receivable")
                {
                    Caption = 'Balance Receivable';
                }
                field(paymentStatusmode; Rec.PaymentStatus)
                {
                    Caption = 'Payment Status mode';
                }
                field("paymentreceipt"; Rec."Payment Receipt")
                {
                    Caption = 'Payment Receipt';
                }
                field("paymentreceiptdocumentuRL"; Rec."Payment Receipt document URL")
                {
                    Caption = 'Payment Receipt document URL';
                }

            }
        }
    }
}
