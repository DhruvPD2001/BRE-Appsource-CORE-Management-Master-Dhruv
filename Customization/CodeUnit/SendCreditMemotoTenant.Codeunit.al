codeunit 50904 "Send Credit Memo to Tenant"
{
    procedure SendMailToTenantForCreditMemo(Rec: Record "Sales Header")
    var
        customer: Record Customer;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        UserRec: Record User;
        CompanyInfo: Record "Company Information";
        UserPersonalizationRec: Record "User Personalization";
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        RecRef: RecordRef;
        Tomail: List of [Text];
        EmailAddress: List of [Text];
        BCCMail: List of [Text];
        TotalAmount: Decimal;
        OutStream: OutStream;
        InStream: InStream;
        FileName: Text[250];
        ReportID: Integer;
        ConfirmationResult: Boolean;
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
        ReportID := 50116;
        SalesHeader.SetRange("No.", Rec."No.");
        SalesHeader.SetRange("Document Type", Rec."Document Type"::"Credit Memo");
        if SalesHeader.FindSet() then
            repeat
                RecRef.GetTable(SalesHeader);
                TempBlob.CreateOutStream(OutStream);
                Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
                TempBlob.CreateInStream(InStream);
                FileName := 'CreditMemo' + SalesHeader."No." + '.pdf';
                TotalAmount := 0;
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                if SalesLine.FindSet() then
                    repeat
                        TotalAmount += Round(SalesLine."Amount Including VAT");
                    until SalesLine.Next() = 0;
                if CompanyInfo.Get() then
                    if SalesHeader."Sell-to E-Mail" = '' then begin
                        customer.Get(SalesHeader."Sell-to Customer No.");
                        Tomail.Add(customer."E-Mail");
                        EmailMessage.Create(Tomail, 'Your Credit Memo ' + SalesHeader."No.",
                        '<html>' +
                         '<body>' +
                         '<p>Dear ' + SalesHeader."Sell-to Customer Name" + ',</p>' +
                         '<h3>Credit Memo Details:</h3>' +
                                            '<p><b>Credit Note No.</b> ' + SalesHeader."No." + '<br/>' +
                                           '<p><b>Contract ID:</b> ' + Format(SalesHeader."Contract ID") + '<br/>' +
                                           '<p><b>Original Invoice No.</b> ' + SalesHeader."Applies-to Doc. No." + '<br/>' +
                                           '<b>Property Name:</b> ' + SalesHeader."Property Name" + '<br/>' +
                                             '<b>Total Amount:</b> ' + Format(TotalAmount) + '<br/>' +
                                             '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                         '</body>' +
                         '</html>',
                          true, EmailAddress, BCCMail);
                    end
                    else begin
                        Tomail.Add(SalesHeader."Sell-to E-Mail");
                        EmailMessage.Create(Tomail, 'Your Credit Memo ' + SalesHeader."No.",
                        '<html>' +
                         '<body>' +
                         '<p>Dear ' + SalesHeader."Sell-to Customer Name" + ',</p>' +
                         '<h3>Credit Memo Details:</h3>' +
                                             '<p><b>Credit Note No.</b> ' + SalesHeader."No." + '<br/>' +
                                            '<p><b>Contract ID:</b> ' + Format(SalesHeader."Contract ID") + '<br/>' +
                                           '<p><b>Original Invoice No.</b> ' + SalesHeader."Applies-to Doc. No." + '<br/>' +
                                           '<b>Property Name:</b> ' + SalesHeader."Property Name" + '<br/>' +
                                             '<b>Total Amount:</b> ' + Format(TotalAmount) + '<br/>' +
                                             '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                                            '</body>' +
                                            '</html>',
                          true, EmailAddress, BCCMail);
                    end;
                EmailMessage.AddAttachment(FileName, '', InStream);
                ConfirmationResult := Confirm('Do you want to send the Credit Note email to ' + SalesHeader."Sell-to Customer Name" + '?', false);
                if ConfirmationResult then begin
                    if Email.Send(EmailMessage) then
                        Message('Email sent successfully :)');
                end else
                    Message('Email sending canceled.');
            until SalesHeader.Next() = 0;
    end;
}