namespace PropertyManagement.PropertyManagement;

page 50708 paymentSchedule1
{
    APIGroup = 'tenants';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'paymentSchedule1';
    DelayedInsert = true;
    EntityName = 'paymentSchedulef';
    EntitySetName = 'paymentSchedulefs';
    PageType = API;
    SourceTable = "Payment Schedule";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(psId; Rec."Contract Id")
                {
                    Caption = 'Contract Id';
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
            }
        }
    }
}
