namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50723 finalrevenuecal
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'finalrevenuecal';
    DelayedInsert = true;
    EntityName = 'finalrevenuecalculationgrid';
    EntitySetName = 'finalrevenuecalculationgrids';
    PageType = API;
    SourceTable = "Final Revenue Calculation Grid";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(actualContractTenure; Rec."Actual Contract Tenure")
                {
                    Caption = 'Actual Contract Tenure';
                }
                field(annualRentAmountTermiYear; Rec."Annual Rent Amount TermiYear")
                {
                    Caption = 'Annual Rent Amount of Termination Year';
                }
                field(contractID; Rec."Contract ID")
                {
                    Caption = 'Contract ID';
                }
                field(contractYearTerminationDate; Rec."ContractYear(Termination Date)")
                {
                    Caption = 'Contract Year On Termination Date';
                }
                field(differenceAmount; Rec."Difference Amount")
                {
                    Caption = 'Difference Amount';
                }
                field(differenceAmountIncl; Rec."Difference Amount Incl.")
                {
                    Caption = 'Difference Amount Incl.';
                }
                field(differenceVAT; Rec."Difference VAT")
                {
                    Caption = 'Difference VAT';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(originalAmount; Rec."Original Amount")
                {
                    Caption = 'Amount';
                }
                field(originalAmountIncl; Rec."Original Amount Incl.")
                {
                    Caption = 'Amount incl.';
                }
                field(originalVAT; Rec."Original VAT")
                {
                    Caption = 'VAT';
                }
                field(perDayRent; Rec."Per Day Rent")
                {
                    Caption = 'Per Day Rent';
                }
                field(revenueDescription; Rec."Revenue Description")
                {
                    Caption = 'Revenue Description';
                }
                field(revisedAmount; Rec."Revised Amount")
                {
                    Caption = 'Revised Amount';
                }
                field(revisedAmountIncl; Rec."Revised Amount Incl.")
                {
                    Caption = 'Revised Amount Incl.';
                }
                field(revisedVAT; Rec."Revised VAT")
                {
                    Caption = 'Revised VAT';
                }
                field(revisedVAT1; Rec."Revised VAT %")
                {
                    Caption = 'Revised VAT %';
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
                field(totalDifferenceAmount; Rec."Total Difference Amount")
                {
                    Caption = 'Total Difference Amount';
                }
                field(totalDifferenceVAT; Rec."Total Difference VAT")
                {
                    Caption = 'Total Difference VAT';
                }
                field(totalDifferenceAmountInclVAT; Rec."Total DifferenceAmountIncl.VAT")
                {
                    Caption = 'Total Difference Amount Incl. VAT"';
                }
                field(totalNoOfDays; Rec."Total No. Of Days")
                {
                    Caption = 'Total No. Of Days(Termination Year)';
                }
                field(totalOrgininalAmountInclVAT; Rec."Total Orgininal AmountIncl.VAT")
                {
                    Caption = 'Total Orgininal Amount Incl. VAT';
                }
                field(totalOriginalAmount; Rec."Total Original Amount")
                {
                    Caption = 'Total Original Amount';
                }
                field(totalOriginalVAT; Rec."Total Original VAT")
                {
                    Caption = 'Total Original VAT';
                }
                field(totalRevisedAmount; Rec."Total Revised Amount")
                {
                    Caption = 'Total Revised Amount';
                }
                field(totalRevisedAmountInclVAT; Rec."Total Revised AmountIncl.VAT")
                {
                    Caption = 'Total Revised Amount Incl. VAT';
                }
                field(totalRevisedVAT; Rec."Total Revised VAT")
                {
                    Caption = 'Total Revised VAT';
                }
            }
        }
    }
}
