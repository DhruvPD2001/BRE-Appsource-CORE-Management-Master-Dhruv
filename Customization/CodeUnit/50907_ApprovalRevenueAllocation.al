codeunit 50907 "Approval Revenue Allocation"
{
    procedure SendRevenueApprovalrequest(Rec: Record "Revenue Allocation Approval"): Text;
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User; // Record for User
        Username: Text;
        EmailAddress: List of [Text];
    begin
        UserPersonalizationRec.SetRange("Profile ID", 'FINANCE MANAGER');
        if UserPersonalizationRec.FindSet() then begin
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then
                        EmailAddress.Add(UserRec."Contact Email");
                Username := UserRec."User Name";
            until UserPersonalizationRec.Next() = 0;
        end;

        EmailMessage.Create(
             EmailAddress,
             'New Revenue Allocation Created - Approval Required',
             '<html><body>' +
             '<p>Dear Finance Manager,</p>' +
             '<p>A new Revenue Allocation has been created and requires your approval.</p>' +
             '<h3>Revenue Allocation Details:</h3>' +
             '<b>ID:</b> ' + Format(Rec."ID") + '<br/>' +
             '<b>Financial Year:</b> ' + Format(Rec."Financial Year") + '<br/>' +
             '<b>Month:</b> ' + Format(Rec."Month") + '<br/>' +
             '<p>Please log in to Business Central to review and take the necessary action.</p>' +
             '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
             '</body></html>',
             true
         );

        if Email.Send(EmailMessage) then
            Message('Email sent successfully')
        else
            Error('Failed to send email. Please verify SMTP settings and email addresses.');
    end;


    procedure ApprovalRevenuerequest(Rec: Record "Revenue Allocation Approval"): Text;
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User; // Record for User
        Username: Text;
        EmailAddress: List of [Text];
    begin

        UserPersonalizationRec.SetRange("Profile ID", 'LEASE_MANAGER');
        if UserPersonalizationRec.FindSet() then begin
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then
                        EmailAddress.Add(UserRec."Contact Email");
                Username := UserRec."User Name";
            until UserPersonalizationRec.Next() = 0;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            // Ensure that the correct record is passed and exists
            if CompanyInfo.Get() then begin
                EmailMessage.Create(
             EmailAddress,
             'New Revenue Allocation Created - Approval Required',
             '<html><body>' +
             '<p>Dear Lease Manager,</p>' +
             '<p>A new Revenue Allocation has been created and requires your approval.</p>' +
             '<h3>Revenue Allocation Details:</h3>' +
             '<b>ID:</b> ' + Format(Rec."ID") + '<br/>' +
             '<b>Financial Year:</b> ' + Format(Rec."Financial Year") + '<br/>' +
             '<b>Month:</b> ' + Format(Rec."Month") + '<br/>' +
             '<p>Please log in to Business Central to review and take the necessary action.</p>' +
             '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
             '</body></html>',
             true
         );


                if Email.Send(EmailMessage) then
                    Message('Email sent successfully')
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
        end;
    end;


    procedure RejectRevenuerequest(Rec: Record "Revenue Allocation Approval"): Text;
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User; // Record for User
        Username: Text;
        EmailAddress: List of [Text];
    begin

        UserPersonalizationRec.SetRange("Profile ID", 'LEASE_MANAGER');
        if UserPersonalizationRec.FindSet() then begin
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then
                        EmailAddress.Add(UserRec."Contact Email");
                Username := UserRec."User Name";
            until UserPersonalizationRec.Next() = 0;
        end;

        if Rec.Status = Rec.Status::Reject then begin
            // Ensure that the correct record is passed and exists
            if CompanyInfo.Get() then begin
                // Create the email message
                EmailMessage.Create(
                            EmailAddress,
                            'New Revenue Allocation Created - Approval Required',
                            '<html><body>' +
                            '<p>Dear Lease Manager,</p>' +
                            '<p>A new Revenue Allocation has been created and requires your approval.</p>' +
                            '<h3>Revenue Allocation Details:</h3>' +
                            '<b>ID:</b> ' + Format(Rec."ID") + '<br/>' +
                            '<b>Financial Year:</b> ' + Format(Rec."Financial Year") + '<br/>' +
                            '<b>Month:</b> ' + Format(Rec."Month") + '<br/>' +
                            '<p>Please log in to Business Central to review and take the necessary action.</p>' +
                            '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                            '</body></html>',
                            true
                        );

                if Email.Send(EmailMessage) then
                    Message('Email sent successfully')
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
        end;
    end;
}