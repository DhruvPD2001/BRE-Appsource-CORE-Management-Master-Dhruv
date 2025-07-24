page 50339 "contractRenewalApi"
{
    PageType = API;
    DelayedInsert = true;
    SourceTable = "Contract Renewal";
    APIPublisher = 'realestate';
    APIGroup = 'contracts';
    APIVersion = 'v2.0';
    EntityName = 'contractRenewal';    // Singular, PascalCase
    EntitySetName = 'contractRenewals'; // Plural, PascalCase
    Caption = 'Contract Renewal API';
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            field("systemId"; Rec.SystemId) // Add SystemId explicitly to the layout
            {
                Caption = 'System Identifier';
            }
            field("id"; Rec.Id) { }
            field("ownersName"; Rec."Owner's Name") { }
            field("lessorsName"; Rec."Lessor's Name") { }
            field("lessorsEmiratesID"; Rec."Lessor's Emirates ID") { }
            field("licenseNo"; Rec."License No.") { }
            field("licensingAuthority"; Rec."Licensing Authority") { }
            field("lessorsEmail"; Rec."Lessor's Email") { }
            field("lessorsPhone"; Rec."Lessor's Phone") { }
            field("contractID"; Rec."Contract ID") { }
            field("contractStartDate"; Rec."Contract Start Date") { }
            field("contractEndDate"; Rec."Contract End Date") { }
            field("contractAmount"; Rec."Contract Amount") { }
            field("unitID"; Rec."Unit ID") { }
            field("unitName"; Rec."Unit Name") { }
            field("propertyID"; Rec."Property ID") { }
            field("propertyName"; Rec."Property Name") { }
            field("renewalContractStatus"; Rec."Renewal Contract Status") { }
            field("tenantFullName"; Rec."Tenant Full Name") { }
            field("contractTenor"; Rec."Contract Tenor") { }
            field("approvalForRenewal"; Rec."Approval For Renewal") { }
            field("proposalID"; Rec."Proposal ID") { }
            field("ejariName"; Rec."Ejari Name") { }
            field("propertyClassification"; Rec."Property Classification") { }
            field("propertyType"; Rec."Property Type") { }
            field("annualRentAmount"; Rec."Annual Rent Amount") { }
            field("contractDate"; Rec."Contract Date") { }
            field("baseUnitOfMeasure"; Rec."Base Unit of Measure") { }
            field("unitSqFeet"; Rec."Unit Sq. Feet") { }
            field("gracePeriod"; Rec."Grace Period") { }
            field("graceStartDate"; Rec."Grace Start Date") { }
            field("graceEndDate"; Rec."Grace End Date") { }
            field("tenantID"; Rec."Tenant ID") { }
            field("emiratesID"; Rec."Emirates ID") { }
            field("contactNumber"; Rec."Contact Number") { }
            field("emailAddress"; Rec."Email Address") { }
            field("paymentFrequency"; Rec."Payment Frequency") { }
            field("paymentMethod"; Rec."Payment Method") { }
            field("createdBy"; Rec."Created By") { }
            field("mergeUnitID"; Rec."Merge Unit ID") { }
            field("rentAmount"; Rec."Rent Amount") { }
            field("tenantLicenseNo"; Rec."Tenant_License No.") { }
            field("tenantLicensingAuthority"; Rec."Tenant_Licensing Authority") { }
            field("securityDepositAmount"; Rec."Security Deposit Amount") { }
            field("unitNumber"; Rec."Unit Number") { }
            field("makaniNumber"; Rec."Makani Number") { }
            field(emirate; Rec.Emirate) { }
            field(community; Rec.Community) { }
            field("dewaNumber"; Rec."DEWA Number") { }
            field("propertySize"; Rec."Property Size") { }
            field("noOfInstallments"; Rec."No of Installments") { }
            field(unitID1; Rec.UnitID) { }
            field(originalContractID; Rec."Original Contract ID") { }
        }
    }
}
