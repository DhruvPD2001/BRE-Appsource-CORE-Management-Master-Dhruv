codeunit 50306 "Contract Renewal Notifier"
{
    Subtype = Normal;
    trigger OnRun()
    begin
        ProcessContractRenewals();
    end;

    local procedure ProcessContractRenewals()
    var
        TenancyContract: Record "Tenancy Contract";
        ApprovalList: Record ContractEndProcessApproval;
        TodayDate: Date;
        ReminderDate: Date;
        ReminderDays: Integer;
    begin
        TodayDate := Today;
        TenancyContract.Reset();
        TenancyContract.SetFilter("Contract End Date", '<>%1', 0D);
        TenancyContract.SetFilter("Renewal Notification to Tenant", '>0');
        if TenancyContract.FindSet() then
            repeat
                ReminderDays := TenancyContract."Renewal Notification to Tenant";
                ReminderDate := TenancyContract."Contract End Date" - ReminderDays;
                if ReminderDate = TodayDate then begin
                    ApprovalList.Reset();
                    ApprovalList.SetRange("Contract ID", TenancyContract."Contract ID");
                    if ApprovalList.FindFirst() then
                        if (ApprovalList."Lease_M Status" = 'Approved') and
                          (ApprovalList."Property_M Status" = 'Approved') and
                           (ApprovalList.Value = 'False') then begin
                            SendRenewalReminderEmail(TenancyContract);
                            TenancyContract."Renewal Contract Status" := TenancyContract."Renewal Contract Status"::"Notify Tenant For Renewal";
                            TenancyContract.Modify();
                        end;
                end;
            until TenancyContract.Next() = 0;
    end;

    local procedure SendRenewalReminderEmail(TenancyContract: Record "Tenancy Contract")
    var
        CompanyInfo: Record "Company Information";
        Email: Codeunit "Email";
        EmailMsg: Codeunit "Email Message";
        EmailBody: Text;
        RecipientEmail: Text;
    begin
        RecipientEmail := TenancyContract."Email Address";
        if DelChr(RecipientEmail, '=', ' ') = '' then begin
            Message('Skipped: No email for tenant %1.', TenancyContract."Customer Name");
            exit;
        end;
        if not CompanyInfo.Get() then
            Error('Company information not found.');
        EmailBody :=
      '<html><body>' +
      '<p>Dear ' + TenancyContract."Customer Name" + ',</p>' +
      '<p>I hope this email finds you well. This is a kind reminder that your contract with <b>Contract ID - ' +
      Format(TenancyContract."Contract ID") + '</b> is set to expire in the next <b>' +
      Format(TenancyContract."Renewal Notification to Tenant") + ' days</b>. To ensure continuity, we would like to know if you are interested in renewing your contract.</p>' +
      '<p>Please let us know your decision at your earliest convenience so we can proceed accordingly. If you have any questions or require assistance, feel free to reach out to us.</p>' +
      '<p>Looking forward to your response.</p>' +
      '<p>Best regards,</p>' +
      '</body></html>';
        EmailMsg.Create(
            RecipientEmail,
            'Contract Renewal Confirmation - Contract ID :-' + Format(TenancyContract."Contract ID"),
            EmailBody,
            true
        );
        if Email.Send(EmailMsg) then
            Message('✅ Renewal reminder email sent to %1.', RecipientEmail)
        else
            Error('❌ Failed to send renewal reminder email to %1.', RecipientEmail);
    end;
}
