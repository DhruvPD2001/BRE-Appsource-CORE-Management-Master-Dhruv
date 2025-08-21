page 50943 "Vendor I/R DocumentSub"
{
    PageType = ListPart;
    SourceTable = "Vendor Contract Document";
    ApplicationArea = All;
    Caption = 'Vendor Invoice/Receipt Documents';

    layout
    {
        area(content)
        {
            repeater("Documents")
            {
                field("Vendor ID"; Rec."Vendor ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'The ID of the vendor associated with this document.';
                }

                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'The amount associated with the vendor document.';
                }

                field("Payment Status"; Rec."Payment Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'The payment status of the vendor document.';
                }

                field("Invoice ID"; Rec."Invoice ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'The unique identifier for the vendor invoice.';
                }

                field("Invoice Document Upload"; Rec."Invoice Document Upload")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;
                    ToolTip = 'Upload the invoice document for the vendor.';

                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "Azure AD Blob Storage";
                        fileName: Text;
                        uploadResult: Text;
                        folderName: Text;
                    begin

                        folderName := 'PropertyDocuments';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."Invoice Document Upload" := CopyStr(fileName, 1, StrLen(fileName));
                            Rec."Invoice Document URL" := CopyStr(uploadResult, 1, StrLen(uploadResult));
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;
                }

                field("Invoice Document View"; Rec."Invoice Document View")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;
                    ToolTip = 'View the uploaded invoice document for the vendor.';

                    trigger OnDrillDown()
                    var
                        FileURL: Text;
                    begin
                        // Get the URL of the uploaded document
                        FileURL := Rec."Invoice Document URL";

                        // Check if the file URL is not empty
                        if FileURL = '' then
                            Error('No document is available to view.');

                        // Open the file URL in the browser (new tab)
                        OpenFileInBrowser(FileURL);

                    end;
                }

                field("Invoice Document URL"; Rec."Invoice Document URL")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'The URL of the uploaded invoice document.';
                }

                field("Receipt ID"; Rec."Receipt ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'The unique identifier for the vendor receipt.';
                }

                field("Receipt Document Upload"; Rec."Receipt Document Upload")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;
                    ToolTip = 'Upload the receipt document for the vendor.';

                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "Azure AD Blob Storage";
                        fileName: Text;
                        uploadResult: Text;
                        folderName: Text;
                    begin
                        folderName := 'PropertyDocuments';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."Receipt Document Upload" := CopyStr(fileName, 1, StrLen(fileName));
                            Rec."Receipt Document URL" := CopyStr(uploadResult, 1, StrLen(uploadResult));
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;
                }

                field("Receipt Document View"; Rec."Receipt Document View")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;
                    ToolTip = 'View the uploaded receipt document for the vendor.';

                    trigger OnDrillDown()
                    var
                        FileURL: Text;
                    begin
                        // Get the URL of the uploaded document
                        FileURL := Rec."Receipt Document URL";

                        // Check if the file URL is not empty
                        if FileURL = '' then
                            Error('No document is available to view.');

                        // Open the file URL in the browser (new tab)
                        OpenFileInBrowser(FileURL);

                    end;
                }

                field("Receipt Document URL"; Rec."Receipt Document URL")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'The URL of the uploaded receipt document.';
                }

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'The unique entry number for the vendor document.';
                }
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

    procedure SetVendorID(pVendorID: Code[20])
    begin
        VendorID := pVendorID;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        vendor: Record "Vendor Profile";
        PaymentStatus: Enum "Payment Status";
    begin
        Rec."Vendor ID" := VendorID;

        vendor.SetRange("vendor ID", Rec."vendor ID");
        if not vendor.IsEmpty() then
            if Rec."Payment Status" = PaymentStatus::" " then
                Rec."Payment Status" := PaymentStatus::Scheduled;

    end;

    var
        VendorID: Code[20];

    trigger OnModifyRecord(): Boolean
    var
        vendor: Record "Vendor Profile";
        PaymentStatus: Enum "Payment Status";
    begin
        vendor.SetRange("vendor ID", Rec."vendor ID");
        if not vendor.IsEmpty() then
            if Rec."Payment Status" = PaymentStatus::" " then
                Rec."Payment Status" := PaymentStatus::Scheduled;

    end;

}