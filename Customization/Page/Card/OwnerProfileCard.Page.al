page 50309 "Owner Profile Card"
{
    PageType = Card;
    SourceTable = "Owner Profile";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Identification")
            {
                Caption = 'Owner Identification Details';

                field("Owner ID"; rec."Owner ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the owner.';
                }

                field("Full Name"; rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the full name of the owner.';
                }

                field("Nationality"; rec."Nationality")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select the nationality of the owner.';
                }

                field("Emirates ID"; rec."Emirates ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the Emirates ID of the owner.';
                }
            }

            group("Contact Information")
            {
                Caption = 'Contact Information';

                field("Phone Number"; rec."Phone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the phone number of the owner.';
                }

                field("Email Address"; rec."Email Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the email address of the owner.';
                }

                field("P.O.Box"; Rec."P.O.Box")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the P.O.Box number for the owner.';
                }

                field("Mailing Address"; rec."Mailing Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the mailing address of the owner.';
                }

                field("Local Address in UAE"; rec."Local Address in UAE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the local address of the owner in the UAE.';
                }
            }

            group("Ownership Details")
            {
                Caption = 'Ownership Details';

                field("Ownership Type"; rec."Ownership Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select the type of ownership for the owner.';
                }

                field("TRN"; rec."TRN")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the Tax Registration Number (TRN) of the owner.';
                }

            }

            group("Banking Information")
            {
                Caption = 'Banking Information';

                field("Bank Account Number"; rec."Bank Account Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the bank account number of the owner.';
                }

                field("IBAN"; rec."IBAN")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the International Bank Account Number (IBAN) of the owner.';
                }

                field("Bank Name"; rec."Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the name of the bank where the owner holds an account.';
                }

                field("SWIFT/IFSC Code"; rec."SWIFT/IFSC Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the SWIFT or IFSC code of the owner`s bank.';
                }
            }

            group("Status and Remarks")
            {
                Caption = 'Status and Remarks';

                field("Status"; rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select the current status of the owner profile.';
                }

                field("Date of Registration"; rec."Date of Registration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the date when the owner was registered in the system.';
                }

                field("Remarks/Notes"; rec."Remarks/Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter any additional remarks or notes regarding the owner profile.';
                }

                field("Ejari Registration Number"; Rec."Ejari Registration Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the Ejari registration number for the owner.';
                }
                field("RERA Owner ID"; Rec."RERA Owner ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the RERA owner ID for the owner.';
                }

            }

            // Add the Document Attachment Subpage here
            part("Document Attachments"; "Owner Document Subpage")
            {
                SubPageLink = OwnerId = FIELD("Owner ID"); // Link to filter attachments for this owner only
                ApplicationArea = All;
                Visible = isVisible;
            }
        }
    }

    var
        isVisible: Boolean;

    trigger OnModifyRecord(): Boolean
    begin
        CurrPage."Document Attachments".Page.SetOwnerId(Rec."Owner ID");
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage."Document Attachments".Page.SetOwnerId(Rec."Owner ID");
        isVisible := true;
    end;

    trigger OnAfterGetRecord()
    begin
        CurrPage."Document Attachments".Page.SetOwnerId(Rec."Owner ID");
        if Format(Rec."Owner ID") <> '' then
            isVisible := true
        else
            isVisible := false;

    end;
}
