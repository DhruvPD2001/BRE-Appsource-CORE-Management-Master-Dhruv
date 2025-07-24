namespace PropertyManagement.PropertyManagement;

page 50704 LeaseProposal
{
    APIGroup = 'tenants';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'leaseProposal';
    DelayedInsert = true;
    EntityName = 'leasecontract';
    EntitySetName = 'leasecontracts';
    ODataKeyFields = SystemId;
    PageType = API;
    DeleteAllowed = true;
    ModifyAllowed = true;
    SourceTable = "Lease Proposal Details";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(annualRentAmount; Rec."Annual Rent Amount")
                {
                    Caption = 'Rent Amount ';
                }
                field(baseUnitOfMeasure; Rec."Base Unit of Measure")
                {
                    Caption = 'Base Unit of Measure';
                }
                field(chillerDepositAmount; Rec."Chiller Deposit Amount")
                {
                    Caption = 'Chiller Deposit Amount';
                }
                field(earlyTerminationConditions; Rec."Early Termination Conditions")
                {
                    Caption = 'Early Termination Conditions';
                }
                field(ejariProcessingFees; Rec."Ejari Processing Fees")
                {
                    Caption = 'Ejari Processing Fees';
                }
                field(electricityDepositAmount; Rec."Electricity Deposit Amount")
                {
                    Caption = 'Electricity Deposit Amount';
                }
                field(emiratesID; Rec."Emirates ID")
                {
                    Caption = 'Emirates ID';
                }
                field(facilitiesAmenities; Rec."Facilities/Amenities")
                {
                    Caption = 'Facilities/Amenities';
                }
                field(insuranceRequirements; Rec."Insurance Requirements")
                {
                    Caption = 'Insurance Requirements';
                }
                field(leaseDuration; Rec."Lease Duration")
                {
                    Caption = 'Lease Duration';
                }
                field(leaseEndDate; Rec."Lease End Date")
                {
                    Caption = 'Lease End Date';
                }
                field(leaseStartDate; Rec."Lease Start Date")
                {
                    Caption = 'Lease Start Date';
                }
                field(legalJurisdiction; Rec."Legal Jurisdiction")
                {
                    Caption = 'Legal Jurisdiction (e.g., Dubai Courts)';
                }
                field(legalRepresentative; Rec."Legal Representative")
                {
                    Caption = 'Legal Representative';
                }
                field(maintenanceResponsibilities; Rec."Maintenance Responsibilities")
                {
                    Caption = 'Maintenance Responsibilities';
                }
                field(mergeUnitID; Rec."Merge Unit ID")
                {
                    Caption = 'Merge Unit ID';
                }
                field(otherFees; Rec."Other Fees")
                {
                    Caption = 'Other Fees ';
                }
                field(paymentFrequency; Rec."Payment Frequency")
                {
                    Caption = 'Payment Frequency';
                }
                field(paymentMethod; Rec."Payment Method")
                {
                    Caption = 'Payment Method';
                }
                field(praposalTypeSelected; Rec."Praposal Type Selected")
                {
                    Caption = 'Praposal Type Selected';
                }
                field(propertyID; Rec."Property ID")
                {
                    Caption = 'Property ID';
                }
                field(propertyName; Rec."Property Name")
                {
                    Caption = 'Property Name';
                }
                field(proposalID; Rec."Proposal ID")
                {
                    Caption = 'Proposal ID';
                }
                field(proposalStatus; Rec."Proposal Status")
                {
                    Caption = 'Proposal Status';
                }
                field(refundConditions; Rec."Refund Conditions")
                {
                    Caption = 'Refund Conditions';
                }
                field(renewalAmount; Rec."Renewal Amount")
                {
                    Caption = 'Renewal Amount';
                }
                field(rentAmount; Rec."Rent Amount")
                {
                    Caption = 'Annual Rent Amount';
                }
                field(rentEscalationClause; Rec."Rent Escalation Clause")
                {
                    Caption = 'Rent Escalation Clause';
                }
                field(reraFees; Rec."Rera Fees")
                {
                    Caption = 'Rera Fees';
                }
                field(restrictions; Rec.Restrictions)
                {
                    Caption = 'Restrictions';
                }
                field(securityDepositAmount; Rec."Security Deposit Amount")
                {
                    Caption = 'Security Deposit Amount';
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
                field(tenantContactEmail; Rec."Tenant Contact Email")
                {
                    Caption = 'Tenant Contact Email';
                }
                field(tenantContactPhone; Rec."Tenant Contact Phone")
                {
                    Caption = 'Tenant Contact Phone';
                }
                field(tenantFullName; Rec."Tenant Full Name")
                {
                    Caption = 'Tenant Full Name';
                }
                field(tenantID; Rec."Tenant ID")
                {
                    Caption = 'Tenant ID';
                }
                field(tradeLicense; Rec."Trade License")
                {
                    Caption = 'Trade License';
                }
                field(unitAddress; Rec."Unit Address")
                {
                    Caption = 'Unit Address';
                }
                field(unitIds; Rec."Unit ID")
                {
                    Caption = 'Single Unit ID';
                }
                field(unitName; Rec."Unit Name")
                {
                    Caption = 'Unit Name';
                }
                field(unitNumber; Rec."Unit Number")
                {
                    Caption = 'Unit Number';
                }
                field(unitSize; Rec."Unit Size")
                {
                    Caption = 'Unit Size';
                }
                field(unitType; Rec."Unit Type")
                {
                    Caption = 'Unit Type';
                }
                field(unitIdm; Rec.UnitID)
                {
                    Caption = 'UnitID';
                }
                field(usageType; Rec."Usage Type")
                {
                    Caption = 'Usage Type';
                }
                field(utilityBillsResponsibility; Rec."Utility Bills Responsibility")
                {
                    Caption = 'Utility Bills Responsibility';
                }
            }
        }
    }
}
