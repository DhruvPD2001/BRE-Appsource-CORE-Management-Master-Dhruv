codeunit 50508 LeaseManagerSendMail
{
    trigger OnRun()
    var
        UserRec: Record User;
        UserPersonalizationRec: Record "User Personalization";
        UserPersonalizationRec1: Record "User Personalization";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        EmailBody: Text;
        EmailAddress: List of [Text];
        CCMail: List of [Text];
        Username: Text;
        BCCMail: List of [Text];
        InvoicesExist: Boolean;
    begin
        InvoicesExist := False;
        UserPersonalizationRec.SetRange("Profile ID", 'FINANCE MANAGER');
        if UserPersonalizationRec.FindSet() then
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then
                        EmailAddress.Add(UserRec."Contact Email");
            until UserPersonalizationRec.Next() = 0;
        if EmailAddress.Count() = 0 then
            Error('No users with the "Finance Manager" profile have a valid email address.');
        UserPersonalizationRec1.SetRange("Profile ID", 'Property Manager');
        if UserPersonalizationRec.FindSet() then
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then
                        EmailAddress.Add(UserRec."Contact Email");
            until UserPersonalizationRec.Next() = 0;
        if EmailAddress.Count() = 0 then
            Error('No users with the "Property Manager" profile have a valid email address.');
        EmailBody := LeaseManagerSendInvoiceMail(InvoicesExist);
        if InvoicesExist then begin
            EmailMessage.Create(EmailAddress, 'Daily Invoice Summary', '<html>' +
                                           '<body>' +
                                           '<p>Dear ' + Username + ',</p>' +
                                           '<p>Today, new invoices were generated:</p>' +
                                           EmailBody +
                                           '<br/><br/><br/>' + 'Thank you' +
                                           '</body>' +
                                           '</html>', true, CCMail, BCCMail);
            EmailMessage.SetBodyHTMLFormatted(true);
            Email.Send(EmailMessage)
        end;
    end;

    procedure LeaseManagerSendInvoiceMail(var InvoicesExist: Boolean): Text
    var
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        emailBodyLbl: Label '<tr><td style="text-align:center;">%1</td><td style="text-align:center;">%2</td><td style="text-align:center;">%3</td><td style="text-align:center;">%4</td></tr>', Comment = '%1=Invoice No., %2=Contract ID, %3=Tenant Name, %4=Amount Including VAT';
        TempEmailBody: Text;
        TotalAmount: Decimal;
    begin
        SalesHeader.SetRange("Posting Date", Today);
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        if SalesHeader.FindSet() then begin
            InvoicesExist := True;
            TempEmailBody := '<table border = "1" style="width:100%; text-align:center;"><tr><th>Invoice No.</th><th>Contract ID</th><th>Tenant Name</th><th>Amount Including VAT</th></tr>';
            repeat
                TotalAmount := 0;
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                if SalesLine.FindSet() then
                    repeat
                        TotalAmount += Round(SalesLine."Amount Including VAT");
                    until SalesLine.Next() = 0;
                TempEmailBody += StrSubstNo(emailBodyLbl, SalesHeader."No.", SalesHeader."Contract ID", SalesHeader."Tenant Name", Format(TotalAmount));
            until SalesHeader.Next() = 0;
            TempEmailBody += '</table>';
        end;
        exit(TempEmailBody);
    end;
}
