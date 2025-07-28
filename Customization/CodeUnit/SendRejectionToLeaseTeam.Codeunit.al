codeunit 50511 "SendRejectionToLeaseTeam"
{
    procedure SendPaymentRejectionToLeaseManager(PaymentModeId: Integer; PaymentId: Code[20]; ContractId: Integer)
    var
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User;
        CompanyInfo: Record "Company Information";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        EmailBody: Text;
        LeasingManagerFullName: Text;
        EmailAddress: List of [Text];
        CCMail: List of [Text];
        BCCMail: List of [Text];
    begin
        UserPersonalizationRec.SetRange("Profile ID", 'LEASE_MANAGER');
        if UserPersonalizationRec.FindSet() then
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then begin
                    EmailAddress.Add(UserRec."Contact Email");
                    LeasingManagerFullName := UserRec."User Name";
                end else
                    Error('Leasing Manager user not found.');
            until UserPersonalizationRec.Next() = 0
        else
            Error('No user with Profile ID "LEASING MANAGER" found.');
        if CompanyInfo.Get() then
            EmailBody := ComposeRejectionEmailBody(PaymentModeId, PaymentId, ContractId, LeasingManagerFullName, CompanyInfo.Name)
        else
            EmailBody := ComposeRejectionEmailBody(PaymentModeId, PaymentId, ContractId, LeasingManagerFullName, CompanyInfo.Name);
        EmailMessage.Create(EmailAddress, 'Payment Entry Rejected – Action Required', EmailBody, true, CCMail, BCCMail);
        EmailMessage.SetBodyHTMLFormatted(true);
        if Email.Send(EmailMessage) then
            Message('Rejection email sent successfully.')
        else
            Error('Failed to send rejection email.');
    end;

    procedure ComposeRejectionEmailBody(PaymentTransactionId: Integer; PaymentId: Text; ContractId: Integer; LeasingManagerFullName: Text; Compnyname: Text): Text
    var
        EmailBody: Text;
    begin
        EmailBody :=
            '<p>Dear Leasing Team,<br>' +
            '<p>We have reviewed the payment entry and identified discrepancies. Approval of the payment entries for the <strong> contract ' + Format(ContractId) + '</strong> is <strong>"On Hold".</strong> Please check the details and update the required information for further processing.</p>' +
            '<p><strong>Payment Details:</strong></p>' +
            'Below are the details of the rejected transaction:<br>' +
            '<table border="1" style="border-collapse: collapse;">' +
            '<tr>' +
            '<th>Contract ID</th>' +
            '<th>Payment ID</th>' +
            '<th>Tenant ID</th>' +
            '<th>Status</th>' +
            '</tr>' +
            '<tr>' +
            '<td>' + Format(ContractID) + '</td>' +
            '<td>' + Format(PaymentId) + '</td>' +
            '<td></td>' +
            '</tr>' +
            '</table>' +
            '<br>' +
            'Action Required:<br>' +
            'Please review the transaction and update the details as necessary to resolve the issue.<br>' +
            '<br>' +
            'You can take the necessary action by accessing the Payment Transactions List via the link below:<br>' +
            '<a href="https://businesscentral.dynamics.com/0fc6d7a4-aa1d-4825-bc34-7dd0c18a4f63/RealestateDev?company=BlueRidge%20Real-Estate&page=50515&dc=0&bookmark=15_TsUAAAJ7_1AAVAAtADEAOQ">Access Payment Transaction List</a><br>' +
            '<br>' +
            'If you have any questions, please contact the Finance Manager for clarification.<br>' +
            '<br>' +
            'Best regards,</p>' +
            '<p> Finance Team<br>' + Format(Compnyname) +
            '</p>';
        exit(StrSubstNo(EmailBody, PaymentTransactionId, TenantId(), ContractId, Compnyname));
    end;
}