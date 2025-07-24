namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 50726 RentCalculate
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'rentCalculate';
    DelayedInsert = true;
    EntityName = 'rentcalculatesub';
    EntitySetName = 'rentcalculatesubs';
    PageType = API;
    SourceTable = "Rent Calculate Sub";
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
                field(finalAnnualAmount; Rec."Final Annual Amount")
                {
                    Caption = 'Final Annual Amount';
                }
                field(numberOfDays; Rec."Number of Days")
                {
                    Caption = 'Number of Days';
                }
                field(perDayRent; Rec."Per Day Rent")
                {
                    Caption = 'Per Day Rent';
                }
                field(periodEndDate; Rec."Period End Date")
                {
                    Caption = 'End Date';
                }
                field(periodStartDate; Rec."Period Start Date")
                {
                    Caption = 'Start Date';
                }
                field(rcID; Rec."RC ID")
                {
                    Caption = 'RC ID';
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
                field(tenantId; Rec."Tenant Id")
                {
                    Caption = 'Tenant ID';
                }
                field(totalFinalAnnualAmount; Rec."Total Final Annual Amount")
                {
                    Caption = 'Total Final Annual Amount';
                }
                field(totalNumberOfDays; Rec."Total Number of Days")
                {
                    Caption = 'Total Number of Days';
                }
                field(year; Rec.Year)
                {
                    Caption = 'Year';
                }
            }
        }
    }
}
