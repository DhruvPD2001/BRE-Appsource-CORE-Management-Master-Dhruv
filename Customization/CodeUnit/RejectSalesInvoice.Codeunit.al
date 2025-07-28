codeunit 50512 RejectSalesInvoice
{
    procedure SendInvoiceToLeaseManager(Rec: Record "Sales Header")
    var
        SalesHeader: Record "Sales Header";
        UserRec: Record User;
        SalesLine: Record "Sales Line";
        CompanyInfo: Record "Company Information";
        UserPersonalizationRec: Record "User Personalization";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        EmailAddress: List of [Text];
        Username: Text;
        TotalAmount: Decimal;
        InvoiceLink: Text;
    begin
        UserPersonalizationRec.SetRange("Profile ID", 'LEASE_MANAGER');
        if UserPersonalizationRec.FindSet() then
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then
                        EmailAddress.Add(UserRec."Contact Email");
            until UserPersonalizationRec.Next() = 0;
        if EmailAddress.Count() = 0 then
            Error('No users with the "Finance Manager" profile have a valid email address.');
        SalesHeader.SetRange("No.", Rec."No.");
        SalesHeader.SetRange("Document Type", Rec."Document Type"::Invoice);
        if SalesHeader.FindSet() then
            repeat
                TotalAmount := 0;
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                if SalesLine.FindSet() then
                    repeat
                        TotalAmount += Round(SalesLine."Amount Including VAT");
                    until SalesLine.Next() = 0;
                InvoiceLink := GETURL(ClientType::Current, COMPANYNAME, ObjectType::Page, PAGE::"Sales Invoice", Rec);
                if CompanyInfo.Get() then
                    EmailMessage.Create(EmailAddress, 'Invoice Rejection Notification - ' + SalesHeader."No.",
                        '<html>' +
                         '<body>' +
                         '<p>Dear ' + Username + ',</p>' +
                         '<h3>Invoice Rejection Details:</h3>' +
                         '<p>The following invoice has been rejected:</p>' +
                         '<p><b>Invoice ID:</b> ' + SalesHeader."No." + '<br/>' +
                         '<b>Contract ID:</b> ' + Format(SalesHeader."Contract ID") + '<br/>' +
                         '<b>Property Name:</b> ' + SalesHeader."Property Name" + '<br/>' +
                         '<b>Total Amount:</b> ' + Format(TotalAmount) + '<br/>' +
                         '<b>Reason For Rejection:</b> ' + SalesHeader."Reason for Rejection" + '<br/>' +
                         '<p>Please review the details and update the invoice</p>' +
                         '<p><a href="' + InvoiceLink + '" target="_blank">Click here to view the invoice</a></p>' +
                         '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                        '</body>' +
                        '</html>',
                        true);
                if Email.Send(EmailMessage)
                then
                    Message('Rejection email sent successfully.')
                else
                    Error('Failed to send rejection email.');
            until SalesHeader.Next() = 0;
    end;
}