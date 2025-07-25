codeunit 50102 "Send Payment Receipt"
{
    procedure SendEmail(Rec: Record "Payment Mode2"): Text;
    var
        CompanyInfo: Record "Company Information";
        ConsolidatedInvoiceHeader: Record "Payment Mode2";
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        NoSeriesManagement: Codeunit "No. Series";
        RecRef: RecordRef;
        OutStream: OutStream;
        InStream: InStream;
        FileName: Text[250];
        ReportID: Integer;
        ReceiptNo: Code[20];
    begin
        ReportID := 50112;
        // Apply filters to fetch the specific record
        ConsolidatedInvoiceHeader.Reset();
        ConsolidatedInvoiceHeader.SetRange("Tenant ID", Rec."Tenant ID");
        ConsolidatedInvoiceHeader.SetRange("Contract ID", Rec."Contract ID"); // Ensure filtering on unique ID
        ConsolidatedInvoiceHeader.SetRange("Payment Series", Rec."Payment Series"); // Add this line to filter by Payment Series
        if ConsolidatedInvoiceHeader.FindFirst() then begin
            // Generate auto-incremented receipt number
            if ConsolidatedInvoiceHeader."Receipt #" = '' then begin
                ReceiptNo := NoSeriesManagement.GetNextNo('RECEIPTNO', WorkDate(), true);
                ConsolidatedInvoiceHeader."Receipt #" := ReceiptNo;
                ConsolidatedInvoiceHeader.Modify(); // Save the new receipt number
            end;
            // Prepare the report output
            RecRef.GetTable(ConsolidatedInvoiceHeader);
            TempBlob.CreateOutStream(OutStream);
            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
            TempBlob.CreateInStream(InStream);
            FileName := 'Receipt_' + Format(ConsolidatedInvoiceHeader."Receipt #") + '.pdf';
            // Debugging to confirm email creation parameters
            Message('Preparing to send email to: %1', ConsolidatedInvoiceHeader."Tenant Email");
            // Retrieve company information
            if CompanyInfo.Get() then begin
                // Create email with detailed contract information
                EmailMessage.Create(
                    ConsolidatedInvoiceHeader."Tenant Email",
                    'Payment Receipt Attached_' + Format(ConsolidatedInvoiceHeader."Receipt #"),
                    '<html>' +
                    '<body>' +
                    '<p>Dear ' + ConsolidatedInvoiceHeader."Tenant Name" + ',' +
                    'Your payment has been received. Please find your receipt attached.</p>' +
                    '</body>' +
                    '</html>',
                    true
                );
                // Attach the PDF document
                EmailMessage.AddAttachment(FileName, '', InStream);
                // Send the email
                if Email.Send(EmailMessage) then
                    Message('Email sent successfully to: %1', ConsolidatedInvoiceHeader."Tenant Email")
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
            exit('Email sent successfully');
        end else
            Error('No Payment Receipt details found for Tenant ID: %1, Contract ID: %2, Payment Series: %3', Rec."Tenant ID", Rec."Contract ID", Rec."Payment Series");
    end;
}