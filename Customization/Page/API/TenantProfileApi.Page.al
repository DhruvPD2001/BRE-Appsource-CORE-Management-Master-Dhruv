page 50702 "tenantProfileAPI"
{
    PageType = API;
    DelayedInsert = true;
    SourceTable = Customer;
    APIPublisher = 'RealeststeDev';
    APIGroup = 'tenants';
    APIVersion = 'v2.0';
    EntityName = 'tenantProfile';
    EntitySetName = 'tenantProfiles';
    Caption = 'tenantProfileAPI';
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field("SystemId"; Rec.SystemId) // Add SystemId explicitly to the layout
            {
                Caption = 'System Identifier';
            }
            field("TenantID"; Rec."No.") { }
            field("FullName"; Rec.Name) { }
            field("Username"; Rec."Username") { }
            field("Password"; Rec."Password") { }
            field("DateOfBirth"; Rec."Date Of Birth") { }
            field("Nationality"; Rec."Nationality") { }
            field("CodeArea"; Rec."Code Area") { }
            field("ContactNumber"; rec."Phone No.") { }
            field("EmailAddress"; rec."E-Mail") { }
            field("LocalAddress"; rec.Address) { }
            field("EmergencyContact"; rec."Mobile Phone No.") { }
            field("Occupation"; rec."Occupation") { }
            field("PassportNumber"; rec."Passport Number") { }
            field("PassportIssueDate"; rec."Passport Issue Date") { }
            field("PassportExpiryDate"; rec."Passport Expiry Date") { }
            field("CountryofPassport"; rec."Country of Passport") { }
            field("EmiratesID"; rec."Emirates ID") { }
            field("EmiratesIDExpiryDate"; rec."Emirates ID Expiry Date") { }
            field(Approve; Rec.Approve) { }
            field(Decline; Rec.Decline) { }
        }
    }
}