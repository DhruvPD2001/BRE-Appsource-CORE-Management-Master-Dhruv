page 50519 "Payment Transaction Data"
{
    PageType = API;
    APIGroup = 'finance';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Payment Transaction API';
    DelayedInsert = true;
    EntityName = 'paymentTransaction';
    EntitySetName = 'paymentTransactions';
    ODataKeyFields = SystemId; // Ensure the SystemId is exposed in the API
    SourceTable = "Payment Transaction";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("ptId"; Rec."PT Id") { }
                field(systemId; Rec.SystemId) { }
                field("tenantId"; Rec."Tenant Id") { }
                field("contractId"; Rec."Contract Id") { }
                field("approvalStatus"; Rec."Approval Status") { }
            }
        }
    }


}