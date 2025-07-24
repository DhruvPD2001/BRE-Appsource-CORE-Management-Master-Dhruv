namespace PropertyManagement.PropertyManagement;

page 50709 paymentSchedule2
{
    APIGroup = 'tenants';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'paymentSchedule2';
    DelayedInsert = true;
    EntityName = 'paymentSchedules';
    EntitySetName = 'paymentScheduless';
    PageType = API;
    SourceTable = "Payment Schedule2";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(installmentEndDate; Rec."Installment End Date")
                {
                    Caption = 'Installment End Date';
                }
                field(installmentNo; Rec."Installment No.")
                {
                    Caption = 'Installment No.';
                }
                field(installmentStartDate; Rec."Installment Start Date")
                {
                    Caption = 'Installment Start Date';
                }
                field(secondaryItemType; Rec."Secondary Item Type")
                {
                    Caption = 'Secondary Item Type';
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
                field(vatAmount; Rec."VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field("contractID"; Rec."Contract ID")
                {
                    Caption = 'Contract ID';
                }
                field("paymentStatus"; Rec."Payment Status")
                {
                    Caption = 'Payment Status';
                }
                field("contractStatus"; Rec."Contract Status")
                {
                    Caption = 'Contract Status';
                }
                field("invoiceID"; Rec."Invoice ID")
                {
                    Caption = 'Invoice ID';
                }
                field("overdueInvoice"; Rec."Overdue Invoice")
                {
                    Caption = 'Overdue Invoice';
                }
                field("paymentRecievedDate"; Rec."Payment Recieved Date")
                {
                    Caption = 'Payment Recieved Date';
                }
                field("paymentMode"; Rec."Payment Mode")
                {
                    Caption = 'Payment Mode';
                }
                field("chequeNumber"; Rec."Cheque Number")
                {
                    Caption = 'Cheque Number';
                }
                field("contractstartdate"; Rec."Contract start date")
                {
                    Caption = 'Contract start date';
                }
                field("propertyID"; Rec."Property ID")
                {
                    Caption = 'Property ID';
                }
                field("noofDays"; Rec."No of Days")
                {
                    Caption = 'No of Days';
                }
                field("creditNoteNo"; Rec."Credit Note No.")
                {
                    Caption = 'Credit Note No.';
                }
                field("creditNoteAmount"; Rec."Credit Note Amount")
                {
                    Caption = 'Credit Note Amount';
                }
                field("finalRentAmount"; Rec."Final Rent Amount")
                {
                    Caption = 'Final Rent Amount';
                }

            }
        }
    }
}
