page 50703 "tenantContractApi"
{
    PageType = API;
    DelayedInsert = true;
    SourceTable = "Tenancy Contract";
    APIPublisher = 'realestate';
    APIGroup = 'tenants';
    APIVersion = 'v2.0';
    EntityName = 'tenantContract';
    EntitySetName = 'tenantContracts';
    Caption = 'Tenant Contract API';
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
            field("contractID"; Rec."Contract ID") { }
            field("proposalID"; Rec."Proposal ID") { }
            field("propertyName"; Rec."Property Name") { }
            field("unitName1"; Rec."Unit Name") { }
            field("ejariName"; Rec."Ejari Name") { }
            field("propertyClassification"; Rec."Property Classification") { }
            field("propertyType"; Rec."Property Type") { }
            field("annualRentAmount"; rec."Annual Rent Amount") { }
            field("contractDate"; rec."Contract Date") { }
            field("contractStartDate"; rec."Contract Start Date") { }
            field("contractEndDate"; rec."Contract End Date") { }
            field("contractTenor"; rec."Contract Tenor") { }
            field("baseUnitofMeasure"; rec."Base Unit of Measure") { }
            field("unitSqFeet"; rec."Unit Sq. Feet") { }
            field("gracePeriod"; rec."Grace Period") { }
            field("graceStartDate"; rec."Grace Start Date") { }
            field("graceEndDate"; rec."Grace End Date") { }
            field("tenantID"; rec."Tenant ID") { }
            field("propertyID"; rec."Property ID") { }
            field("unitID"; rec."Unit ID") { }
            field("emiratesID"; rec."Emirates ID") { }
            field("contactNumber"; rec."Contact Number") { }
            field("emailAddress"; rec."Email Address") { }
            field("paymentFrequency"; rec."Payment Frequency") { }
            field("paymentMethod"; rec."Payment Method") { }
            field("tenantContractStatus"; rec."Tenant Contract Status") { }
            field("unitIDD"; rec.UnitID) { }
            field("handoverisCompleted"; rec."Handover is Completed") { }
            field("mergeUnitID"; rec."Merge Unit ID") { }
            field("rentAmount"; rec."Rent Amount") { }
            field("updateContractStatus"; rec."Update Contract Status") { }
            field("createdBy"; rec."Created By") { }
            field("ownersName"; Rec."Owner's Name") { }
            field("lessorsName"; Rec."Lessor's Name") { }
            field("lessorsEmiratesID"; Rec."Lessor's Emirates ID") { }
            field("licenseNo"; Rec."License No.") { }
            field("licensingAuthority"; Rec."Licensing Authority") { }
            field("lessorsEmail"; Rec."Lessor's Email") { }
            field("lessorsPhone"; Rec."Lessor's Phone") { }
            field("unitName"; Rec."Unit Name") { }
            field("tenantLicenseNo"; Rec."Tenant_License No.") { }
            field("tenantLicensingAuthority"; Rec."Tenant_Licensing Authority") { }
            field("securityDepositAmount"; Rec."Security Deposit Amount") { }
            field("unitNumber"; Rec."Unit Number") { }
            field("makaniNumber"; Rec."Makani Number") { }
            field(emirate; Rec.Emirate) { }
            field(community; Rec.Community) { }
            field("dEWANumber"; Rec."DEWA Number") { }
            field("propertySize"; Rec."Property Size") { }
            field(id; Rec.ID) { }
            field("suspendedReasonlist"; Rec."Suspended Reason list") { }
            field("noofInstallments"; Rec."No of Installments") { }
            field("tenantName"; Rec."Customer Name") { }
            field("uploadDocument"; Rec."Upload Document") { }
            field("viewDocument"; Rec."view Document") { }
            field("renewalContractStatus"; Rec."Renewal Contract Status") { }
            field("yesOrNo"; Rec."Yes/No") { }

            field("renewalNotificationtoTenant"; rec."Renewal Notification to Tenant")
            {
                Caption = 'Renewal Notification to Tenant';
            }

            field("tenantLoyaltyCheckReminder"; rec."Tenant Loyalty Check Reminder")
            {

                Caption = 'Tenant Loyalty Check Reminder';
            }

            field("paymentReminder"; rec."Payment Reminder")
            {
                Caption = 'Payment Reminder';
            }
            field("previousStatus"; Rec."Previous Status")
            {
                Caption = 'Previous Status';
            }




        }
    }
}