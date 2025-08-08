codeunit 50503 "Send Contract Email"
{
    procedure SendEmail(Rec: Record "Tenancy Contract"): Text;
    var
        CompanyInfo: Record "Company Information";
        TempBlob: Codeunit "Temp Blob";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        RecRef: RecordRef;
        OutStream: OutStream;
        InStream: InStream;
        FileName: Text[250];
        ReportID: Integer;
        Emirate: Enum Emirates;
        CurrentEmirateValue: Enum Emirates;
    begin
        if Evaluate(CurrentEmirateValue, Rec.Emirate) then
            case CurrentEmirateValue of
                Emirate::Dubai, Emirate::"Abu Dhabi", Emirate::Sharjah, Emirate::Ajman, Emirate::Fujairah, Emirate::"Ras Al Khaimah":
                    ReportID := 50101;
                Emirate::"Umm Al Quwain":
                    ReportID := 50115;
                else
                    Error('Unsupported emirate: %1', Rec.Emirate);
            end
        else
            Error('Invalid emirate value: %1', Rec.Emirate);

        if Rec."Tenant ID" <> '' then begin
            TempBlob.CreateOutStream(OutStream);
            Rec.SetRecFilter();
            RecRef.GetTable(Rec);
            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
            TempBlob.CreateInStream(InStream);
            FileName := 'Contract_' + Format(Rec."Tenant ID") + '.pdf';
            Message('Preparing to send email to: %1', Rec."Email Address");
            if CompanyInfo.Get() then
                EmailMessage.Create(Rec."Email Address",
                                    'Tenancy Contract Document Attached_' + Format(Rec."Tenant ID"),
                                    '<html>' +
                                    '<body>' +
                                    '<p>Dear ' + Rec."Customer Name" + ',</p>' +
                                    '<p>We are pleased to inform you that the tenancy contract for your property has been finalized. Please find the contract document attached to this email for your review and records.</p>' +
                                    '<h3>Contract Summary:</h3>' +
                                    '<p><b>Contract ID:</b> ' + Format(Rec."Contract ID") + '<br/>' +
                                    '<b>Unit Number:</b> ' + Rec."Unit Number" + '<br/>' +
                                    '<b>Property Name:</b> ' + Rec."Property Name" + '<br/>' +
                                    '<b>Location:</b> ' + Format(CurrentEmirateValue) + '   ' + Rec.Community + '<br/>' +
                                    '<b>Contract Period:</b> ' + Format(Rec."Contract Start Date") + '  ' + 'To' + '  ' + Format(Rec."Contract End Date") + '<br/>' +
                                    '<b>Lease Amount:</b> ' + Format(Rec."Annual Rent Amount") + '<br/>' +
                                    '<b>Payment Mode:</b> ' + Format(Rec."No of Installments") + '  ' + Format(Rec."Payment Method") + '</p>' + '<br/>' +
                                    '<p>Kindly review the attached document thoroughly. If you have any questions or need further clarification, please do not hesitate to contact us.</p>' +
                                    '<p>Thank you for choosing ' + CompanyInfo.Name + '.</p>' +
                                    '<p>We look forward to serving you and ensuring a seamless tenancy experience.</p>' +
                                    '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                                    '</body>' +
                                    '</html>',
                                    true);
            EmailMessage.AddAttachment(FileName, '', InStream);
            if Email.Send(EmailMessage) then
                Message('Email sent successfully to: %1', Rec."Email Address")
            else
                Error('Failed to send email. Please verify SMTP settings and email addresses.');
            exit('Email sent successfully.');
        end else
            Error('No tenancy contract details found for Tenant ID: %1', Rec."Tenant ID");
    end;
}
