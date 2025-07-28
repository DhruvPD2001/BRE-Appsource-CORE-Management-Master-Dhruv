codeunit 50513 "Send Payment Reciept"
{
    Subtype = Normal;
    procedure GenerateAndSendReceipt(CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        Customer: Record Customer;
        paymentReceipt: Record "Gen. Journal Line";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStream: InStream;
        FileName: Text[250];
        ReportID: Integer;
    begin
        ReportID := 50112;
        Clear(paymentReceipt);
        paymentReceipt.SetRange("Document Type", paymentReceipt."Document Type"::Payment);
        paymentReceipt.SetRange("Document No.", CustLedgerEntry."Document No.");
        if paymentReceipt.IsEmpty() then
            Error('No payment found for Document No.: %1', CustLedgerEntry."Document No.");
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStream);
        if Customer.Get(CustLedgerEntry."Customer No.") then begin
            if Customer."E-Mail" = '' then
                Error('Customer does not have an email address.');
            FileName := 'PaymentReceipt_' + CustLedgerEntry."Document No." + '.pdf';
            EmailMessage.Create(Customer."E-Mail", 'Payment Receipt',
                'Dear ' + Customer.Name + ', please find your payment receipt attached.');
            EmailMessage.AddAttachment(FileName, '', InStream);
            if Email.Send(EmailMessage) then
                Message('Email sent successfully to: %1', Customer."E-Mail")
            else
                Error('Failed to send email. Please verify SMTP settings and email addresses.');
        end else
            Error('Customer record not found for Customer No. %1.', CustLedgerEntry."Customer No.")
    end;

    procedure GeneratePaymentReceipt(DocumentNo: Code[20]; RecipientEmail: Text)
    var
        EmailMsg: Codeunit "Email Message";
        EmailSender: Codeunit "Email";
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStream: InStream;
        FileName: Text[250];
        ReportID: Integer;
    begin
        ReportId := 50112;
        if RecipientEmail = '' then
            Error('Recipient email is missing. Cannot send receipt.');
        FileName := 'PaymentReceipt_' + DocumentNo + '.pdf';
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(ReportId, '', ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStream);
        EmailMsg.Create('noreply@yourcompany.com', RecipientEmail, 'Payment Receipt');
        EmailMsg.AddAttachment(FileName, '', InStream);
        EmailSender.Send(EmailMsg);
    end;

    procedure SendReceiptEmail(CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        Customer: Record Customer;
        paymentReceipt: Record "Gen. Journal Line";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStream: InStream;
        FileName: Text[250];
        ReportID: Integer;
    begin
        ReportID := 50112;
        Clear(paymentReceipt);
        paymentReceipt.SetRange("Document Type", paymentReceipt."Document Type"::Payment);
        paymentReceipt.SetRange("Applies-to Doc. No.", CustLedgerEntry."Document No.");
        if not paymentReceipt.IsEmpty() then begin
            TempBlob.CreateOutStream(OutStr);
            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStr);
            TempBlob.CreateInStream(InStream);
            if Customer.Get(CustLedgerEntry."Customer No.") then begin
                if Customer."E-Mail" = '' then
                    Error('Customer does not have an email address.');
                FileName := 'PaymentReceipt_' + CustLedgerEntry."Document No." + '.pdf';
                EmailMessage.Create(Customer."E-Mail", 'Payment Receipt',
                    'Dear ' + Customer.Name + ', please find your payment receipt attached.');
                EmailMessage.AddAttachment(FileName, '', InStream);
                if Email.Send(EmailMessage) then
                    Message('Email sent successfully to: %1', Customer."E-Mail")
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end else
                Error('Customer record not found for Customer No. %1.', CustLedgerEntry."Customer No.")
        end else
            Error('No payment receipt found for Document No.: %1', CustLedgerEntry."Document No.");
    end;

    procedure SendPaymentReceiptEmail(PaymentEntry: Record "Payment Mode2")
    var
        Tenant: Record Customer;
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        OutStr: OutStream;
        InStream: InStream;
        FileName: Text[250];
        ReportID: Integer;
    begin
        ReportID := 50112;
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStream);
        if Tenant.Get(PaymentEntry."Tenant ID") then begin
            if Tenant."E-Mail" = '' then
                Error('Tenant does not have an email address.');
            FileName := 'PaymentReceipt_' + Format(PaymentEntry."Contract ID") + '.pdf';
            EmailMessage.Create(Tenant."E-Mail", 'Payment Receipt',
                'Dear ' + Tenant.Name + ', your payment has been received. Please find your receipt attached.');
            EmailMessage.AddAttachment(FileName, '', InStream);
            if Email.Send(EmailMessage) then
                Message('Email sent successfully to Tenant: %1', Tenant."E-Mail")
            else
                Error('Failed to send email. Please verify SMTP settings and email addresses.');
        end else
            Error('Tenant record not found for Tenant ID %1.', PaymentEntry."Tenant ID");
    end;
}