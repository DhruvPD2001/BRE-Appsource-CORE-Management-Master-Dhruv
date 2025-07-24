namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50727 "Revenue Calculate Sub Api"
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'revenueCalculateSubApi';
    DelayedInsert = true;
    EntityName = 'revenuecalculatesub';
    EntitySetName = 'revenuecalculatesubs';
    PageType = API;
    SourceTable = "Revenue Calculate Sub";
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
                field(installmentEndDate; Rec."Installment End Date")
                {
                    Caption = 'Installment End Date';
                }
                field(installmentStartDate; Rec."Installment Start Date")
                {
                    Caption = 'Installment Start Date';
                }
                field(rsID; Rec."RS ID")
                {
                    Caption = 'RS ID';
                }
                field(secondaryItemType; Rec."Secondary Item Type")
                {
                    Caption = 'Secondary Item Type';
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
