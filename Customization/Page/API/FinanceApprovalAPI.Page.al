page 50512 "FinanceApprovalAPI"
{
    APIGroup = 'finance';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'PDC Approval API';
    DelayedInsert = true;
    EntityName = 'pdcApproval';
    EntitySetName = 'pdcApprovals';
    PageType = API;
    ODataKeyFields = SystemId; // Ensure the SystemId is exposed in the API
    SourceTable = "PDC Approval";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.Id) { }
                field(systemId; Rec.SystemId) { }
                field(status; Rec.Status) { }
                field("pdcId"; Rec."PDC Id") { }
                field(tenantId; Rec.Tenant_Id) { }
                field(contractId; Rec.Contract_Id) { }
                field(checkNo; Rec.Check_No) { }
                field(depositeBank; Rec.Deposite_Bank) { }
                field(totalAmount; Rec.Total_Amount) { }
                field(dueDate; Rec.Due_Date) { }
                field(view; Rec.View) { }

            }
        }
    }

}