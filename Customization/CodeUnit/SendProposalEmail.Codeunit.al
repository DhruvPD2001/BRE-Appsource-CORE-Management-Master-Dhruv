codeunit 50502 "Send Proposal Email"
{
    procedure SendEmail(Rec: Record "Lease Proposal Details"): Text;
    var
        CompanyInfo: Record "Company Information";
        ConsolidatedInvoiceHeader: Record "Lease Proposal Details";
        AdditionalDetailsTable: Record "Revenue Item Subpage";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        SecondTempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        SecondRecRef: RecordRef;
        OutStream: OutStream;
        SecondOutStream: OutStream;
        InStream: InStream;
        SecondInStream: InStream;
        FileName: Text[250];
        SecondFileName: Text[250];
        ReportID: Integer;
        SecondReportID: Integer;
    begin
        ReportID := 50102;
        SecondReportID := 50110;
        ConsolidatedInvoiceHeader.SetRange("Proposal ID", Rec."Proposal ID");
        if ConsolidatedInvoiceHeader.FindSet() then begin
            RecRef.GetTable(ConsolidatedInvoiceHeader);
            TempBlob.CreateOutStream(OutStream);
            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
            TempBlob.CreateInStream(InStream);
            FileName := 'proposal_' + Format(ConsolidatedInvoiceHeader."Proposal ID") + '.pdf';
            AdditionalDetailsTable.SetRange(ProposalID, Rec."Proposal ID");
            if AdditionalDetailsTable.FindSet() then begin
                SecondRecRef.GetTable(AdditionalDetailsTable);
                SecondTempBlob.CreateOutStream(SecondOutStream);
                Report.SaveAs(SecondReportID, '', ReportFormat::Pdf, SecondOutStream, SecondRecRef);
                SecondTempBlob.CreateInStream(SecondInStream);
                SecondFileName := 'additional_details_' + Format(AdditionalDetailsTable.ProposalID) + '.pdf';
            end else
                Error('No data found for the second report.');
            Message('Preparing to send email to: %1', ConsolidatedInvoiceHeader."Tenant Contact Email");
            if CompanyInfo.Get() then
                EmailMessage.Create(
                    ConsolidatedInvoiceHeader."Tenant Contact Email",
                    'Lease Proposal for Your Consideration_' + Format(ConsolidatedInvoiceHeader."Proposal ID"),
                    '<html>' +
                    '<body>' +
                    '<p>Dear ' + ConsolidatedInvoiceHeader."Tenant Full Name" + ',</p>' +
                    '<p>Thank you for your interest in leasing one of our properties. We are pleased to share the lease proposal for your review.</p>' +
                    '<h3>Property Details:</h3>' +
                    '<p><b>Property Name:</b> ' + ConsolidatedInvoiceHeader."Property Name" + '<br/>' +
                    '<b>Unit Number:</b> ' + ConsolidatedInvoiceHeader."Unit Number" + '<br/>' +
                    '<b>Area:</b> ' + Format(ConsolidatedInvoiceHeader."Unit Size") + '<br/>' +
                    '<b>Lease Amount:</b> ' + Format(ConsolidatedInvoiceHeader."Annual Rent Amount") + '<br/>' +
                    '<b>Lease Term:</b> ' + ConsolidatedInvoiceHeader."Lease Duration" + '</p>' +
                    '<h3>Terms and Conditions:</h3>' +
                    '<p>The tenancy contract will be renewable annually upon the successful completion of the yearly rental payment.<br/>' +
                    'Renewal options are available with 90 days prior notice in alignment with the RERA Calculator.<br/>' +
                    'Insurance: The tenant shall maintain insurance for the premises at their own expense, while the landlord will maintain insurance for the building.</p>' +
                    '<p>We value your consideration of our property and look forward to your response. Should you have any questions or require further information, please do not hesitate to contact us.</p>' +
                    '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                    '</body>' +
                    '</html>',
                    true
                );
            EmailMessage.AddAttachment(FileName, '', InStream);
            EmailMessage.AddAttachment(SecondFileName, '', SecondInStream);
            if Email.Send(EmailMessage) then
                Message('Email sent successfully to: %1', ConsolidatedInvoiceHeader."Tenant Contact Email")
            else
                Error('Failed to send email. Please verify SMTP settings and email addresses.');
            exit('Email send successfully');
        end else
            Error('No lease proposal details found for Proposal ID: %1', Rec."Tenant ID");
    end;
}
