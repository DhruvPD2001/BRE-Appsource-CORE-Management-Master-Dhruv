namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50728 "Other Payment Calculate"
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'otherPaymentCalculate';
    DelayedInsert = true;
    EntityName = 'otherpaymentcalculate';
    EntitySetName = 'otherpaymentcalculates';
    PageType = API;
    SourceTable = "Other Payment Calculate Sub";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

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
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field(contractID; Rec."Contract ID")
                {
                    Caption = 'Contract ID';
                }
                field(endDate; Rec."End Date")
                {
                    Caption = 'End Date';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(secondaryItemType; Rec."Secondary Item Type")
                {
                    Caption = 'Secondary Item Type';
                }
                field(startDate; Rec."Start Date")
                {
                    Caption = 'Start Date';
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
                field(totalAmount; Rec."Total Amount")
                {
                    Caption = 'Total Amount';
                }
                field(totalAmountIncludingVAT; Rec."Total Amount Including VAT")
                {
                    Caption = 'Total Amount Including VAT';
                }
                field(totalVATAmount; Rec."Total VAT Amount")
                {
                    Caption = 'Total VAT Amount';
                }
                field(vatAmount; Rec."VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
            }
        }
    }
}
