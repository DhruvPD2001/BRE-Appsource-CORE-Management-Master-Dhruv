namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50729 "Additional Charges Sub Api"
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'additionalChargesSubApi';
    DelayedInsert = true;
    EntityName = 'additionalchargessub';
    EntitySetName = 'additionalchargessubs';
    PageType = API;
    SourceTable = "Additional Charges Sub";
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
                    Caption = 'Secondary Item';
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
                field(vat; Rec."VAT %")
                {
                    Caption = 'VAT %';
                }
                field(vatAmount; Rec."VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field(invoiced; Rec.Invoiced)
                {
                    Caption = 'VAT Amount';
                }
                field("invoicedID"; Rec."Invoiced ID")
                {
                    Caption = 'Invoiced ID';
                }
                field("unitType"; Rec."Unit Type")
                {
                    Caption = 'Unit Type';
                }
                field("postedInvoiceID"; Rec."Posted Invoice ID")
                {
                    Caption = 'Posted Invoice ID';
                }
                field("invoiceDocument"; Rec."Invoice Document")
                {
                    Caption = 'Invoice Document';
                }
                field("invoiceDocumentURL"; Rec."Invoice Document URL")
                {
                    Caption = 'Invoice Document URL';
                }
            }
        }
    }
}
