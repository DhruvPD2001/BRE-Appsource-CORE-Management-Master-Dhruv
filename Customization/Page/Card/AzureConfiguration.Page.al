page 50505 "Azure Configuration"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = AzureConfiguration;
    Caption = 'Azure Configuration Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Azure Storage Configuration';

                field("Storage Account Name"; Rec."Storage Account Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of your Azure Storage account';
                }
                field("Default Container"; Rec."Default Container")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default container name to use for uploads';
                }
                field("SAS URL"; Rec."SAS URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'The SAS URL for legacy compatibility (not recommended)';
                    Visible = false;
                }
            }
            group("Azure AD Authentication")
            {
                Caption = 'Azure AD Authentication';

                field("Tenant ID"; Rec."Tenant ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Azure AD Tenant ID';
                }
                field("Client ID"; Rec."Client ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Client ID (Application ID) from your Azure AD app registration';
                }
                field("Client Secret"; Rec."Client Secret")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Client Secret from your Azure AD app registration';
                    ExtendedDatatype = Masked;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TestConnection)
            {
                ApplicationArea = All;
                Caption = 'Test Connection';
                ToolTip = 'Test the connection to Azure Blob Storage';
                Image = TestDatabase;

                trigger OnAction()
                var
                    AzureADBlob: Codeunit "Azure AD Blob Storage";
                    TempBlob: Codeunit "Temp Blob";
                    InStream: InStream;
                    OutStream: OutStream;
                    TestFileName: Text;
                    TestFolderName: Text;
                    Result: Text;
                begin
                    if not Confirm('Do you want to test the Azure connection?') then
                        exit;

                    TempBlob.CreateOutStream(OutStream);
                    OutStream.WriteText('This is a test file to validate Azure blob storage connection.');
                    TempBlob.CreateInStream(InStream);

                    TestFileName := 'connection_test_' + Format(CurrentDateTime) + '.txt';
                    TestFileName := ConvertStr(TestFileName, ' :', '__');

                    TestFolderName := 'TestFolder';

                    Result := AzureADBlob.UploadDocumentToBlob(InStream, TestFileName, TestFolderName);

                    if Result <> '' then
                        Message('Connection successful! Test file uploaded to: %1', Result)
                    else
                        Error('Connection test failed.');
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        AzureConfig: Record AzureConfiguration;
    begin
        if not AzureConfig.FindFirst() then begin
            AzureConfig.Init();
            AzureConfig.Insert();
        end;

        Rec := AzureConfig;
    end;
}