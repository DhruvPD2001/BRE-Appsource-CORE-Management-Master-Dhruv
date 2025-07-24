namespace PropertyManagement.PropertyManagement;

page 50714 "Payment Type"
{
    APIGroup = 'payment';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'paymentType';
    DelayedInsert = true;
    EntityName = 'paymentType';
    EntitySetName = 'paymentTypes';
    PageType = API;
    SourceTable = "Payment Type";
    ODataKeyFields = SystemId;
    ModifyAllowed = true;
    DeleteAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(paymentID; Rec."Payment ID")
                {
                    Caption = 'Payment ID';
                }
                field(paymentMethod; Rec."Payment Method")
                {
                    Caption = 'Payment Method';
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
            }
        }
    }
}
