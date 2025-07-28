codeunit 50906 "Reject Credit Memo"
{
    procedure SendInvoiceToLeaseManager(Rec: Record "Sales Header")
    var
        SalesHeader: Record "Sales Header";
        UserRec: Record User;
        SalesLine: Record "Sales Line";
        UserPersonalizationRec: Record "User Personalization";
        CompanyInfo: Record "Company Information";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        EmailAddress: List of [Text];
        Username: Text;
        TotalAmount: Decimal;
        Creditmemolink: Text;
    begin
        UserPersonalizationRec.SetRange("Profile ID", 'LEASE_MANAGER');
        if UserPersonalizationRec.FindSet() then
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then
                        EmailAddress.Add(UserRec."Contact Email");
            until UserPersonalizationRec.Next() = 0;
        if EmailAddress.Count() = 0 then
            Error('No users with the "LEASE_MANAGER" profile have a valid email address.');
        SalesHeader.SetRange("No.", Rec."No.");
        SalesHeader.SetRange("Document Type", Rec."Document Type"::"Credit Memo");
        if SalesHeader.FindSet(true) then
            repeat
                TotalAmount := 0;
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                if SalesLine.FindSet() then
                    repeat
                        TotalAmount += Round(SalesLine."Amount Including VAT");
                    until SalesLine.Next() = 0;
                Creditmemolink := GETURL(ClientType::Current, COMPANYNAME, ObjectType::Page, PAGE::"Sales Credit Memo", Rec);
                if CompanyInfo.Get() then
                    EmailMessage.Create(EmailAddress, 'Credit Memo Rejection Notification - ' + SalesHeader."No.",
                        '<html>' +
                         '<body>' +
                         '<p>Dear ' + Username + ',</p>' +
                         '<h3>Credit Memo Rejection Details:</h3>' +
                         '<p>The following invoice has been rejected:</p>' +
                         '<p><b>Invoice ID:</b> ' + SalesHeader."No." + '<br/>' +
                         '<b>Contract ID:</b> ' + Format(SalesHeader."Contract ID") + '<br/>' +
                          '<b>Applies-to Invoice No.:</b> ' + SalesHeader."Applies-to Doc. No." + '<br/>' +
                         '<b>Property Name:</b> ' + SalesHeader."Property Name" + '<br/>' +
                         '<b>Total Amount:</b> ' + Format(TotalAmount) + '<br/>' +
                         '<b>Reason For Rejection:</b> ' + SalesHeader."Rejection Reason CreditNote" + '<br/>' +
                         '<p>Please review the details and update the Credit Memo</p>' +
                         '<p><a href="' + Creditmemolink + '" target="_blank">Click here to view the Credit Memo</a></p>' +
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