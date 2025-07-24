namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50736 "Credit Note Approval"
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'creditNoteApproval';
    DelayedInsert = true;
    EntityName = 'creditNoteApproval';
    EntitySetName = 'creditNoteApprovals';
    PageType = API;
    SourceTable = "Credit Note Approval";
    DeleteAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(creditnoteamount; Rec."Credit Note Amount")
                {
                    Caption = 'Credit Note Amount';
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
                field(fcID; Rec."FC ID")
                {
                    Caption = 'FC ID';
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
                field(tenantID; Rec."Tenant ID")
                {
                    Caption = 'Tenant ID';
                }
                field(tenantName; Rec."Tenant Name")
                {
                    Caption = 'Tenant Name';
                }
            }
        }
    }
}
