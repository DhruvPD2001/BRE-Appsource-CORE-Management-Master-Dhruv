namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50735 creditnote
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'creditnote';
    DelayedInsert = true;
    EntityName = 'creditNote';
    EntitySetName = 'creditNotes';
    PageType = API;
    SourceTable = "Credit Note";
    DeleteAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(contractAmount; Rec."Contract Amount")
                {
                    Caption = 'Contract Amount';
                }
                field(contractEndDate; Rec."Contract End Date")
                {
                    Caption = 'Contract End Date';
                }
                field(contractID; Rec."Contract ID")
                {
                    Caption = 'Contract ID';
                }
                field(contractStartDate; Rec."Contract Start Date")
                {
                    Caption = 'Contract Start Date';
                }
                field(creditNoteType; Rec."Credit Note Type")
                {
                    Caption = 'Credit Note Type';
                }
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
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
                field(tenantEmail; Rec."Tenant Email")
                {
                    Caption = 'Tenant Email';
                }
                field(tenantID; Rec."Tenant ID")
                {
                    Caption = 'Tenant ID';
                }
                field(tenantName; Rec."Tenant Name")
                {
                    Caption = 'Tenant Name';
                }
                field(unitType; Rec."Unit Type")
                {
                    Caption = 'Unit Type';
                }
                field("creditNoteDocument"; Rec."Credit Note Document")
                {
                    Caption = 'Credit Note Document';
                }
                field("creditNoteURL"; Rec."Credit Note URL")
                {
                    Caption = 'Credit Note URL';
                }
                field("fcID"; Rec."FC ID")
                {
                    Caption = 'FC ID';
                }
                field("creditNoteNo"; Rec."Credit Note No.")
                {
                    Caption = 'Credit Note No.';
                }
                field("reasonforRejection"; Rec."Reason for Rejection")
                {
                    Caption = 'Reason for Rejection';
                }
            }
        }
    }
}
