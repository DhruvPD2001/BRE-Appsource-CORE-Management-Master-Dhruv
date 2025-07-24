page 50701 "Company Data"
{
    PageType = Card;
    SourceTable = "testData";
    ApplicationArea = All;
    Caption = 'Company Data';
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group("Company Information")
            {
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    Caption = 'Company Name';
                    ToolTip = 'Specifies the name of the company.';
                }

                field("Company Logo"; Rec."Company Logo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the logo of the company.';
                    Editable = false;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "Azure AD Blob Storage";
                        fileName: Text;
                        uploadResult: Text;
                        folderName: Text;
                    begin

                        folderName := 'CompanyLogos';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."Company Logo" := CopyStr(fileName, 1, StrLen(fileName));
                            Rec."Logo URL" := CopyStr(uploadResult, 1, StrLen(uploadResult));
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;


                }

                field("Azure Blob URL"; Rec."Logo URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'The URL of the company logo stored in Azure Blob Storage.';
                    Editable = true;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        FileURL: Text;
                    begin
                        FileURL := Rec."View Document URL";

                        if FileURL = '' then
                            Error('No document is available to view.');

                        OpenFileInBrowser(FileURL);
                    end;
                }

                field("Tenant id"; Rec."Tenant id")
                {
                    ApplicationArea = All;
                    Caption = 'Tenant Id';
                    ToolTip = 'Specifies the Azure AD Tenant ID for the company.';
                }
                field("Environment Name"; Rec."Environment Name")
                {
                    ApplicationArea = All;
                    Caption = 'Environment Name';
                    ToolTip = 'Specifies the name of the environment for the company.';
                }
                field("API URL"; Rec."API URL")
                {
                    ApplicationArea = All;
                    Caption = 'API URL';
                    ToolTip = 'This is the API URL of portal';
                }
                field("Revenue Methods"; Rec."Revenue Methods")
                {
                    ApplicationArea = All;
                    Caption = 'Revenue Methods';
                    ToolTip = 'Specifies the revenue methods used by the company.';
                }
            }

            group("WorkflowFrequency")
            {
                part("Workflow Frequency"; "Workflow Frequency Card")
                {
                    SubPageLink = "Company ID" = FIELD("Company ID");
                    ApplicationArea = All;
                }
            }
            field("Access Validity"; Rec."Access Validity")
            {
                ApplicationArea = All;
                Caption = 'Access Validity (Days)';
                ToolTip = 'Specifies the number of days for which the access is valid.';
            }
        }
    }
    procedure OpenFileInBrowser(URL: Text)
    begin
        if URL <> '' then
            Hyperlink(URL)
        else
            Error('The file URL is invalid.');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        CompanyInfo: Record "Company Information";
    begin
        if CompanyInfo.Get() then
            Rec."Company Name" := CompanyInfo.Name;
    end;
}
