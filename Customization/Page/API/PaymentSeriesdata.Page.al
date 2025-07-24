page 50518 "Payment Series Data"
{
    PageType = API;
    APIGroup = 'finance';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Payment Series API';
    DelayedInsert = true;
    EntityName = 'paymentSeriesdata';
    EntitySetName = 'paymentSeriesdatas';
    ODataKeyFields = SystemId; // Ensure the SystemId is exposed in the API
    SourceTable = "Payment Series Details";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("paymentSeries"; Rec."payment Series") { }
                field(systemId; Rec.SystemId) { }
                field(amount; Rec.Amount) { }
                field("dueDate"; Rec."Due Date") { }
                field("paymentMode"; Rec."Payment Mode") { }
                field("chequeNumber"; Rec."Cheque Number") { }
                field("depositeBank"; Rec."Deposite Bank") { }
                field("depositeStatus"; Rec."Deposite Status") { }
                field("paymentStatus"; Rec."Payment Status") { }
                field("chequeStatus"; Rec."Cheque Status") { }
                field("oldCheque"; Rec."Old Cheque") { }
                field(view; Rec.View) { }
                field("viewDocumentURL"; Rec."View Document URL") { }
                field("approvalStatus"; Rec."Approval Status") { }
                field("paymentTransactionId"; Rec."Payment Transaction Id") { }
                field("contractId"; Rec."Contract Id") { }
                field("tenantId"; Rec."Tenant Id") { }


            }
        }
    }

}