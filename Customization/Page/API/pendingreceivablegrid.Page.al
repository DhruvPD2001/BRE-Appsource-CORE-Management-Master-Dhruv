namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50725 pendingreceivablegrid
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'pendingreceivablegrid';
    DelayedInsert = true;
    EntityName = 'pendingreceviablegrid';
    EntitySetName = 'pendingreceviablegrids';
    PageType = API;
    SourceTable = "Pending Receviable Grid";
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
                field(differenceAmount; Rec.DifferenceAmount)
                {
                    Caption = 'Difference Amount';
                }
                field(differenceAmountInclVAT; Rec.DifferenceAmountInclVAT)
                {
                    Caption = 'Difference Amount Incl. VAT';
                }
                field(differenceVAT; Rec.DifferenceVAT)
                {
                    Caption = 'Difference VAT';
                }
                field(entryNo; Rec."Entry No")
                {
                    Caption = 'Entry No';
                }
                field(receiptsAmount; Rec.ReceiptsAmount)
                {
                    Caption = 'Receipts Amount';
                }
                field(receiptsAmountInclVAT; Rec.ReceiptsAmountInclVAT)
                {
                    Caption = 'Receipts Amount Incl. VAT';
                }
                field(receiptsVAT; Rec.ReceiptsVAT)
                {
                    Caption = 'Receipts VAT';
                }
                field(revenueDescription; Rec.RevenueDescription)
                {
                    Caption = 'Revenue Description';
                }
                field(revisedAmount; Rec.RevisedAmount)
                {
                    Caption = 'Revised Amount';
                }
                field(revisedAmountInclVAT; Rec.RevisedAmountInclVAT)
                {
                    Caption = 'Revised Amount Incl. VAT';
                }
                field(revisedVAT; Rec.RevisedVAT)
                {
                    Caption = 'Revised VAT';
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
                field(terminationDate; Rec."Termination Date")
                {
                    Caption = 'Termination Date';
                }
            }
        }
    }
}
