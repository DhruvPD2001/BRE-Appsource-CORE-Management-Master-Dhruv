codeunit 50951 "Approval Request Crdit note "
{
    procedure SubmitCreditNote(var RequestCreditNote: Record "Request Credit Note")
    var
        ApprovalStatusList: Record RequestCreditNoteApprovalList;
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User;
        CompanyInfo: Record "Company Information";
        requestcreditnotegrid: Record "Request Credit Note Grid";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        EmailList: List of [Text];
        fianancemanager: Text;
        EmailBody: Text;
        AcutalRentAmount: Decimal;
        Totalreductionamount: Decimal;
    begin
        requestcreditnotegrid.SetRange("Request No.", RequestCreditNote."Request No.");
        requestcreditnotegrid.SetRange("Contract ID", RequestCreditNote."Contract ID");
        if requestcreditnotegrid.FindSet() then
            repeat
                AcutalRentAmount += requestcreditnotegrid."Current Charges Amount";
                Totalreductionamount += requestcreditnotegrid."Total Reduction";
            until requestcreditnotegrid.Next() = 0;
        ApprovalStatusList.Init();
        ApprovalStatusList."Request No." := RequestCreditNote."Request No.";
        ApprovalStatusList."Contract ID" := RequestCreditNote."Contract ID";
        ApprovalStatusList."Tenant No." := RequestCreditNote."Tenant No.";
        ApprovalStatusList."Total Rent Amount" := RequestCreditNote."Current Rent Amount";
        ApprovalStatusList."Total Reduction Amount" := RequestCreditNote."Total Reduction";
        ApprovalStatusList.Status := 'Pending';
        ApprovalStatusList.Insert();
        RequestCreditNote.Status := RequestCreditNote.Status::Pending;
        RequestCreditNote.Modify();
        fianancemanager := '';
        UserPersonalizationRec.SetRange("Profile ID", 'FINANCE MANAGER');
        if UserPersonalizationRec.FindSet() then
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then begin
                        EmailList.Add(UserRec."Contact Email");
                        if fianancemanager = '' then
                            fianancemanager := UserRec."User Name"
                        else
                            fianancemanager += ', ' + UserRec."User Name";
                    end;
            until UserPersonalizationRec.Next() = 0;
        if EmailList.Count = 0 then
            Error('No valid email addresses found for Finance Manager.');
        if CompanyInfo.Get() then begin
            EmailBody :=
                '<html><body>' +
                '<p>Dear <b>Finance Manager</b>,</p>' +
                '<p>This is an automated notification from the system.</p>' +
                '<p>A new Credit Note has been submitted with the following details:</p>' +
                '<p>' +
                '<b>Request No.:</b> ' + Format(RequestCreditNote."Request No.") + '<br/>' +
                '<b>Contract ID: </b> ' + Format(RequestCreditNote."Contract ID") + '<br/>' +
                '<b>Tenant No:</b> ' + RequestCreditNote."Tenant No." + '<br/>' +
                '<b>Tenant Name: </b> ' + Format(RequestCreditNote."Customer Name") + '<br/>' +
                '<b>Request Date: </b> ' + Format(RequestCreditNote."Request Date") + '<br/>' +
               '<b>Total Rent Amount: </b> ' + Format(AcutalRentAmount) + '<br/>' +
               '<b>Total Reduction Amount: </b> ' + Format(Totalreductionamount) + '<br/>' +
                '</p>' +
                '<p>Please review the <b>Request Credit Note Approval List</b> and take the necessary action.</p>' +
                '<p>This is a system-generated email. Please do not reply.</p>' +
                '<p>Thank you,</p>' +
                '</body></html>';
            EmailMessage.Create(
                    EmailList,
                    'System Notification: Action Required - Review Credit Note for Approval - Contract ID ' + Format(RequestCreditNote."Contract ID"),
                    EmailBody,
                    true
                );
            if not Email.Send(EmailMessage) then
                Error('Email failed to send. Please check SMTP settings.');
        end;
    end;
}
