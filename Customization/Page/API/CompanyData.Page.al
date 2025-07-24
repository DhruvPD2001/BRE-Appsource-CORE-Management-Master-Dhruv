namespace PropertyManagement.PropertyManagement;

page 50706 CompanyData
{
    APIGroup = 'tenants';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'companyData';
    DelayedInsert = true;
    EntityName = 'companyData';
    EntitySetName = 'companyDatas';
    PageType = API;
    SourceTable = testData;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(companyID; Rec."Company ID")
                {
                    Caption = 'Company ID';
                }
                field(companyLogo; Rec."Company Logo")
                {
                    Caption = 'Company Logo';
                }
                field("logoURL"; Rec."Logo URL")
                {
                    Caption = 'Company Logo';
                }
                field(companyName; Rec."Company Name")
                {
                    Caption = 'Company Name';
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
                field("tenantid"; Rec."Tenant id")
                {
                    Caption = 'Tenant id';
                }
                field("environmentName"; Rec."Environment Name")
                {
                    Caption = 'Environment Name';
                }
                field("accessValidity"; Rec."Access Validity")
                {
                    Caption = 'Access Validity';
                }
                field("apiURL"; Rec."API URL")
                {
                    Caption = 'API URL';
                }
            }
        }
    }
}
