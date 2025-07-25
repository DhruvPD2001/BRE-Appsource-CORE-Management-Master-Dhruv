page 50702 "tenantProfileAPI"
{
    PageType = API;
    DelayedInsert = true;
    SourceTable = Customer;
    APIPublisher = 'realestate';
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
            field("systemId"; Rec.SystemId) // Add SystemId explicitly to the layout
            {
                Caption = 'System Identifier';
            }
            field("tenantID"; Rec."No.") { }
            field("fullName"; Rec.Name) { }
            field("username"; Rec."Username") { }
            field("password"; Rec."Password") { }
            field("dateOfBirth"; Rec."Date Of Birth") { }
            field("nationality"; Rec."Nationality") { }
            field("codeArea"; Rec."Code Area") { }
            field("contactNumber"; rec."Phone No.") { }
            field("emailAddress"; rec."E-Mail") { }
            field("localAddress"; rec.Address) { }
            field("emergencyContact"; rec."Mobile Phone No.") { }
            field("occupation"; rec."Occupation") { }
            field("passportNumber"; rec."Passport Number") { }
            field("passportIssueDate"; rec."Passport Issue Date") { }
            field("passportExpiryDate"; rec."Passport Expiry Date") { }
            field("countryofPassport"; rec."Country of Passport") { }
            field("emiratesID"; rec."Emirates ID") { }
            field("emiratesIDExpiryDate"; rec."Emirates ID Expiry Date") { }
            field(approve; Rec.Approve) { }
            field(decline; Rec.Decline) { }
        }
    }
}