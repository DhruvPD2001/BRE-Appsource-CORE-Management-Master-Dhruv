namespace PropertyManagement.PropertyManagement;

page 50707 paymentdata
{
    APIGroup = 'payment';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'paymentdata';
    DelayedInsert = true;
    EntityName = 'paymentData';
    EntitySetName = 'paymentData';
    PageType = API;
    SourceTable = "Payment Mode2";
    ODataKeyFields = SystemId;

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
                field(amountIncludingVAT; Format(Rec."Amount Including VAT", 0, '<Integer><Decimals,3>'))
                {
                    Caption = 'Amount Including VAT';
                }
                field(chequeNumber; Rec."Cheque Number")
                {
                    Caption = 'Cheque Number';
                }
                field(depositBank; Rec."Deposit Bank")
                {
                    Caption = 'Deposit Bank';
                }
                field(depositStatus; Rec."Deposit Status")
                {
                    Caption = 'Deposit Status';
                }
                field(dueDate2; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(paymentMode; Rec."Payment Mode")
                {
                    Caption = 'Payment Mode';
                }
                field(paymentSeries; Rec."Payment Series")
                {
                    Caption = 'Payment Series';
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
                field(vatAmount; Rec."VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field("contractID"; Rec."Contract ID")
                {
                    Caption = 'Contract id';
                }
                field("paymentStatus"; Rec."Payment Status")
                {
                    Caption = 'Payment Status';
                }
                field("chequeStatus"; Rec."Cheque Status")
                {
                    Caption = 'Cheque Status';
                }
                field("invoice"; Rec."Invoice #")
                {
                    Caption = 'Invoice';
                }
                field("receipt"; Rec."Receipt #")
                {
                    Caption = 'Receipt';
                }
                field("oldCheque"; Rec."Old Cheque #")
                {
                    Caption = 'Old Cheque';
                }
                field("uploadCheque"; Rec."Upload Cheque")
                {
                    Caption = 'Upload Cheque';
                }
                field("download"; Rec.Download)
                {
                    Caption = 'Download';
                }
                field(view; Rec.View)
                {
                    Caption = 'View';
                }
                field("viewRevenueDetails"; Rec."View Revenue Details")
                {
                    Caption = 'View Revenue Details';
                }
                field("viewDocumentURL"; Rec."View Document URL")
                {
                    Caption = 'View Document URL';
                }
                field("entryNo"; Rec."Entry No.")
                {
                    Caption = 'Entry No';
                }
                field("approveDeclineStatus"; Rec."Approve/Decline Status")
                {
                    Caption = 'Approve/Decline Status';
                }
                field("tenantEmail"; Rec."Tenant Email")
                {
                    Caption = 'Tenant Email';
                }
                field("tenantName"; Rec."Tenant Name")
                {
                    Caption = 'Tenant Name';
                }
                field("viewInvoice"; Rec."View Invoice")
                {
                    Caption = 'View Invoice';
                }
                field("viewRecieptdocumentURL"; Rec."View Reciept document URL")
                {
                    Caption = 'View Reciept document URL';
                }
                field("paymentReceivedDate"; Rec."Payment Received Date")
                {
                    Caption = 'Payment Received Date';
                }

                field("paymentReminder"; Rec."Payment Reminder")
                {
                    Caption = 'Payment Reminder';
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
