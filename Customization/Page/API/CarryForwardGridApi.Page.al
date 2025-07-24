namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50730 "Carry Forward Grid Api"
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'carryForwardGridApi';
    DelayedInsert = true;
    EntityName = 'carryforwardgrid';
    EntitySetName = 'carryforwardgrids';
    PageType = API;
    SourceTable = "Carry Forward Grid";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(contractID; Rec."Contract ID")
                {
                    Caption = 'Contract ID';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(newContractID; Rec."New Contract ID")
                {
                    Caption = 'New Contract ID';
                }
                field(securityDeposit; Rec."Security Deposit")
                {
                    Caption = 'Security Deposit';
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
                field(totalAmount; Rec."Total Amount")
                {
                    Caption = 'Total Amount';
                }
            }
        }
    }
}
