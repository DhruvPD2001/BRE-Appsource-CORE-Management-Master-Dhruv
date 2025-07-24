namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50740 finalcalculationrefundapproval
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'finalcalculationRefundapprova';
    DelayedInsert = true;
    EntityName = 'fcRefundApproval';
    EntitySetName = 'fcRefundApprovals';
    PageType = API;
    SourceTable = finalcalculation_refunApproval;
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(accountHolderName; Rec."Account Holder Name")
                {
                    Caption = 'Account Holder Name';
                }
                field(accountNumber; Rec."Account Number")
                {
                    Caption = 'Account Number';
                }
                field(bankName; Rec."Bank Name")
                {
                    Caption = 'Bank Name';
                }
                field(branchAddress; Rec."Branch Address")
                {
                    Caption = 'Branch Name';
                }
                field(contractID; Rec."Contract ID")
                {
                    Caption = 'Contract ID';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(ibanNumber; Rec."IBAN number")
                {
                    Caption = 'IBAN number';
                }
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(swiftCode; Rec."Swift Code")
                {
                    Caption = 'Swift Code';
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
                field(totalAmount; Rec."Total Amount")
                {
                    Caption = 'Total Amount';
                }
                field("requestDate"; Rec."Request Date")
                {
                    Caption = 'Request Date';
                }
                field(fcID; Rec.fcID)
                {
                    Caption = 'fcID';
                }
            }
        }
    }
}
