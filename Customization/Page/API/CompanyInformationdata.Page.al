namespace PropertyManagement.PropertyManagement;

using Microsoft.Foundation.Company;

page 50705 CompanyInformationdata
{
    APIGroup = 'company';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'companyInformationdata';
    DelayedInsert = true;
    EntityName = 'companyInfo';
    EntitySetName = 'companyInfos';
    PageType = API;
    SourceTable = "Company Information";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(allowBlankPaymentInfo; Rec."Allow Blank Payment Info.")
                {
                    Caption = 'Allow Blank Payment Info.';
                }
                field(alternativeLanguageCode; Rec."Alternative Language Code")
                {
                    Caption = 'Alternative Language Code';
                }
                field(bankAccountNo; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                }
                field(bankBranchNo; Rec."Bank Branch No.")
                {
                    Caption = 'Bank Branch No.';
                }
                field(bankName; Rec."Bank Name")
                {
                    Caption = 'Bank Name';
                }
                field(baseCalendarCode; Rec."Base Calendar Code")
                {
                    Caption = 'Base Calendar Code';
                }
                field(brandColorCode; Rec."Brand Color Code")
                {
                    Caption = 'Brand Color Code';
                }
                field(brandColorValue; Rec."Brand Color Value")
                {
                    Caption = 'Brand Color Value';
                }
                field(calConvergenceTimeFrame; Rec."Cal. Convergence Time Frame")
                {
                    Caption = 'Cal. Convergence Time Frame';
                }
                field(checkAvailPeriodCalc; Rec."Check-Avail. Period Calc.")
                {
                    Caption = 'Check-Avail. Period Calc.';
                }
                field(checkAvailTimeBucket; Rec."Check-Avail. Time Bucket")
                {
                    Caption = 'Check-Avail. Time Bucket';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(contactPerson; Rec."Contact Person")
                {
                    Caption = 'Contact Person';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(createdDateTime; Rec."Created DateTime")
                {
                    Caption = 'Created DateTime';
                }
                field(customSystemIndicatorText; Rec."Custom System Indicator Text")
                {
                    Caption = 'Custom System Indicator Text';
                }
                field(customsPermitDate; Rec."Customs Permit Date")
                {
                    Caption = 'Customs Permit Date';
                }
                field(customsPermitNo; Rec."Customs Permit No.")
                {
                    Caption = 'Customs Permit No.';
                }
                field(demoCompany; Rec."Demo Company")
                {
                    Caption = 'Demo Company';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(eoriNumber; Rec."EORI Number")
                {
                    Caption = 'EORI Number';
                }
                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }
                field(gln; Rec.GLN)
                {
                    Caption = 'GLN';
                }
                field(giroNo; Rec."Giro No.")
                {
                    Caption = 'Giro No.';
                }
                field(iban; Rec.IBAN)
                {
                    Caption = 'IBAN';
                }
                field(industrialClassification; Rec."Industrial Classification")
                {
                    Caption = 'Industrial Classification';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                }
                field(paymentRoutingNo; Rec."Payment Routing No.")
                {
                    Caption = 'Payment Routing No.';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(phoneNo2; Rec."Phone No. 2")
                {
                    Caption = 'Phone No. 2';
                }
                field(picture; Rec.Picture)
                {
                    ApplicationArea = all;
                    Caption = 'Picture';
                }

                field(pictureLastModDateTime; Rec."Picture - Last Mod. Date Time")
                {
                    Caption = 'Picture - Last Mod. Date Time';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(primaryKey; Rec."Primary Key")
                {
                    Caption = 'Primary Key';
                }
                field(registrationNo; Rec."Registration No.")
                {
                    Caption = 'Registration No.';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(swiftCode; Rec."SWIFT Code")
                {
                    Caption = 'SWIFT Code';
                }
                field(shipToAddress; Rec."Ship-to Address")
                {
                    Caption = 'Ship-to Address';
                }
                field(shipToAddress2; Rec."Ship-to Address 2")
                {
                    Caption = 'Ship-to Address 2';
                }
                field(shipToCity; Rec."Ship-to City")
                {
                    Caption = 'Ship-to City';
                }
                field(shipToContact; Rec."Ship-to Contact")
                {
                    Caption = 'Ship-to Contact';
                }
                field(shipToCountryRegionCode; Rec."Ship-to Country/Region Code")
                {
                    Caption = 'Ship-to Country/Region Code';
                }
                field(shipToCounty; Rec."Ship-to County")
                {
                    Caption = 'Ship-to County';
                }
                field(shipToName; Rec."Ship-to Name")
                {
                    Caption = 'Ship-to Name';
                }
                field(shipToName2; Rec."Ship-to Name 2")
                {
                    Caption = 'Ship-to Name 2';
                }
                field(shipToPhoneNo; Rec."Ship-to Phone No.")
                {
                    Caption = 'Ship-to Phone No.';
                }
                field(shipToPostCode; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code';
                }
                field(systemIndicator; Rec."System Indicator")
                {
                    Caption = 'System Indicator';
                }
                field(systemIndicatorStyle; Rec."System Indicator Style")
                {
                    Caption = 'System Indicator Style';
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
                field(telexAnswerBack; Rec."Telex Answer Back")
                {
                    Caption = 'Telex Answer Back';
                }
                field(telexNo; Rec."Telex No.")
                {
                    Caption = 'Telex No.';
                }
                field(useGLNInElectronicDocument; Rec."Use GLN in Electronic Document")
                {
                    Caption = 'Use GLN in Electronic Documents';
                }
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.';
                }

            }
        }
    }

}
