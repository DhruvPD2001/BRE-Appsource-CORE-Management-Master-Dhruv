page 50504 "Unit Document SubPage"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Unit Document Details";
    Caption = 'Unit Document SubPage';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of document associated with the unit.';
                }
                field("Document Name"; Rec."Document Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the document associated with the unit.';
                }
                field("Upload Document"; Rec."Upload Document")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the uploaded document for the unit.';
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "Azure AD Blob Storage";
                        fileName: Text;
                        uploadResult: Text;
                        folderName: Text;
                    begin
                        folderName := 'UnitDocuments';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."Upload Document" := CopyStr(fileName, 1, StrLen(fileName));
                            Rec."View Document URL" := CopyStr(uploadResult, 1, StrLen(uploadResult));
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;
                }

                field("View & Download"; Rec."View & Download")
                {
                    ApplicationArea = All;
                    ToolTip = 'View or download the uploaded document.';
                    Editable = false;
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
                field(Download; Rec.Download)
                {
                    ApplicationArea = All;
                    ToolTip = 'Download the uploaded document.';
                    Editable = false;
                    DrillDown = true;
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        DownloadUrl: Text;
                    begin
                        DownloadUrl := Rec."View Document URL";

                        if DownloadUrl = '' then
                            Error('No document is available to download.');

                        Hyperlink(DownloadUrl);
                    end;
                }
            }
        }
    }

    local procedure OpenFileInBrowser(URL: Text)
    begin
        if URL <> '' then
            Hyperlink(URL)
        else
            Error('The file URL is invalid.');
    end;

    procedure SetUnitId(pOwnerId: code[20])
    begin
        unitId := pOwnerId;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.UnitID := unitId;
    end;

    var
        unitId: code[20];
}