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
            field("SystemId"; Rec.SystemId) // Add SystemId explicitly to the layout
            {
                Caption = 'System Identifier';
            }
            field("ContractID"; Rec."Contract ID") { }
            field("ProposalID"; Rec."Proposal ID") { }
            field("PropertyName"; Rec."Property Name") { }
            field("UnitName1"; Rec."Unit Name") { }
            field("EjariName"; Rec."Ejari Name") { }
            field("PropertyClassification"; Rec."Property Classification") { }
            field("PropertyType"; Rec."Property Type") { }
            field("AnnualRentAmount"; rec."Annual Rent Amount") { }
            field("ContractDate"; rec."Contract Date") { }
            field("ContractStartDate"; rec."Contract Start Date") { }
            field("ContractEndDate"; rec."Contract End Date") { }
            field("ContractTenor"; rec."Contract Tenor") { }
            field("BaseUnitofMeasure"; rec."Base Unit of Measure") { }
            field("UnitSqFeet"; rec."Unit Sq. Feet") { }
            field("GracePeriod"; rec."Grace Period") { }
            field("GraceStartDate"; rec."Grace Start Date") { }
            field("GraceEndDate"; rec."Grace End Date") { }
            field("TenantID"; rec."Tenant ID") { }
            field("PropertyID"; rec."Property ID") { }
            field("UnitID"; rec."Unit ID") { }
            field("EmiratesID"; rec."Emirates ID") { }
            field("ContactNumber"; rec."Contact Number") { }
            field("EmailAddress"; rec."Email Address") { }
            field("PaymentFrequency"; rec."Payment Frequency") { }
            field("PaymentMethod"; rec."Payment Method") { }
            field("TenantContractStatus"; rec."Tenant Contract Status") { }
            field("UnitIDD"; rec.UnitID) { }
            field("HandoverisCompleted"; rec."Handover is Completed") { }
            field("MergeUnitID"; rec."Merge Unit ID") { }
            field("RentAmount"; rec."Rent Amount") { }
            field("UpdateContractStatus"; rec."Update Contract Status") { }
            field("CreatedBy"; rec."Created By") { }
            field("OwnersName"; Rec."Owner's Name") { }
            field("LessorsName"; Rec."Lessor's Name") { }
            field("LessorsEmiratesID"; Rec."Lessor's Emirates ID") { }
            field("LicenseNo"; Rec."License No.") { }
            field("LicensingAuthority"; Rec."Licensing Authority") { }
            field("LessorsEmail"; Rec."Lessor's Email") { }
            field("LessorsPhone"; Rec."Lessor's Phone") { }
            field("UnitName"; Rec."Unit Name") { }
            field("TenantLicenseNo"; Rec."Tenant_License No.") { }
            field("TenantLicensingAuthority"; Rec."Tenant_Licensing Authority") { }
            field("SecurityDepositAmount"; Rec."Security Deposit Amount") { }
            field("UnitNumber"; Rec."Unit Number") { }
            field("MakaniNumber"; Rec."Makani Number") { }
            field(Emirate; Rec.Emirate) { }
            field(Community; Rec.Community) { }
            field("DEWANumber"; Rec."DEWA Number") { }
            field("PropertySize"; Rec."Property Size") { }
            field(ID; Rec.ID) { }
            field("SuspendedReasonlist"; Rec."Suspended Reason list") { }
            field("NoofInstallments"; Rec."No of Installments") { }
            field("TenantName"; Rec."Customer Name") { }
            field("UploadDocument"; Rec."Upload Document") { }
            field("viewDocument"; Rec."view Document") { }
            field("RenewalContractStatus"; Rec."Renewal Contract Status") { }
            field("YesOrNo"; Rec."Yes/No") { }

            field("RenewalNotificationtoTenant"; rec."Renewal Notification to Tenant")
            {
                Caption = 'Renewal Notification to Tenant';
            }

            field("TenantLoyaltyCheckReminder"; rec."Tenant Loyalty Check Reminder")
            {

                Caption = 'Tenant Loyalty Check Reminder';
            }

            field("PaymentReminder"; rec."Payment Reminder")
            {
                Caption = 'Payment Reminder';
            }
            field("PreviousStatus"; Rec."Previous Status")
            {
                Caption = 'Previous Status';
            }




        }
    }
}