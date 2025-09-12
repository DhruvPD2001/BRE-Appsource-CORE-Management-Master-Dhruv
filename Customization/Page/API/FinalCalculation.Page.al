namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50722 "Final Calculation"
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'finalCalculation';
    DelayedInsert = true;
    EntityName = 'finalcalculation';
    EntitySetName = 'finalcalculations';
    PageType = API;
    SourceTable = "Final Calculation";
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
                field(adjustmentSecurityDeposit; Rec."Adjustment Security Deposit")
                {
                    Caption = 'Adjustment Security Deposit';
                }
                field(amountRefundable; Rec."Amount Refundable")
                {
                    Caption = 'Amount Refundable To The Tenant';
                }
                field(annualRentAmountTermiYear; Rec."Annual Rent Amount TermiYear")
                {
                    Caption = 'Annual Rent Amount of Termination Year';
                }
                field(chillerDeposit; Rec."Chiller Deposit")
                {
                    Caption = 'Chiller Deposit';
                }
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
                field(contractYearTerminationDate; Rec."ContractYear(Termination Date)")
                {
                    Caption = 'Contract Year On Termination Date';
                }
                field(fcID; Rec."FC ID")
                {
                    Caption = 'FC ID';
                }
                field(intimationDate; Rec."Intimation Date")
                {
                    Caption = 'Intimation Date';
                }
                field(netBalance; Rec."Net Balance")
                {
                    Caption = 'Net Balance';
                }
                field(netReceivableFromTheTenant; Rec."Net Receivable From The Tenant")
                {
                    Caption = 'Net Receivable From The Tenant';
                }
                field(originalContractTenure; Rec."Original Contract Tenure")
                {
                    Caption = 'Original Contract Tenure';
                }
                field(otherDeposit; Rec."Other Deposit")
                {
                    Caption = 'Other Deposit';
                }
                field(perDayRent; Rec."Per Day Rent")
                {
                    Caption = 'Per Day Rent(Termination Year)';
                }
                field(securityDeposit; Rec."Security Deposit")
                {
                    Caption = 'Security Deposit';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(summeryNetBalance; Rec."Summery Net Balance")
                {
                    Caption = 'Net Balance';
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
                field(terminationDate; Rec."Termination Date")
                {
                    Caption = 'Termination Date';
                }
                field(totalClaim; Rec."Total Claim")
                {
                    Caption = 'Total Claim';
                }
                field(totalNoOfDays; Rec."Total No. Of Days")
                {
                    Caption = 'Total No. Of Days(Termination Year)';
                }
                field(totalRefund; Rec."Total Refund")
                {
                    Caption = 'Total Refund';
                }
                field(totalRefundableDeposit; Rec."Total Refundable Deposit")
                {
                    Caption = 'Total Refundable Deposit';
                }
                field(unitType; Rec."Unit Type")
                {
                    Caption = 'Unit Type';
                }
                field("finalCalculationDocument"; Rec."Final Calculation Document")
                {
                    Caption = 'Unit Type';
                }
                field("terminationStatus"; Rec."Termination Status")
                {
                    Caption = 'Termination Status';
                }
                field("finalCalculationURL"; Rec."Final Calculation URL")
                {
                    Caption = 'Final Calculation URL';
                }
                field("creditNoteDocument"; Rec."Credit Note Document")
                {
                    Caption = 'Credit Note Document';
                }
                field("creditNoteURL"; Rec."Credit Note URL")
                {
                    Caption = 'Credit Note URL';
                }
                field("updatedPayments"; Rec."Updated Payments")
                {
                    Caption = 'Updated Payments';
                }
                field("finalPayments"; Rec."Final Payments")
                {
                    Caption = 'Final Payments';
                }
            }
        }
    }
}
