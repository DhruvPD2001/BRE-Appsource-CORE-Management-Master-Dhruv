codeunit 50310 "Contract Renewal Response"
{
    procedure SyncToTenancyContractRenewal(ContractStatusRec: Record "Approval Contract Status")
    var
        ContractRenewal: Record "Contract Renewal";
        RenewalHandler: Codeunit "Contract Renewal Response";
    begin
        ContractRenewal.Reset();
        ContractRenewal.SetRange(Id, ContractStatusRec."Renewal Contract ID");
        if not ContractRenewal.FindFirst() then begin
            Message('No Contract Renewal found for Contract ID %1', ContractStatusRec."Renewal Contract ID");
            exit;
        end;
        if ContractStatusRec.Status = 'Approved' then
            case ContractStatusRec."Tenancy Contract Status" of
                'Contract Renewal':
                    begin
                        ContractRenewal."Renewal Contract Status" := ContractRenewal."Renewal Contract Status"::"Renewal of Original Contract ID";
                        ContractRenewal."Approval For Renewal" := ContractRenewal."Approval For Renewal"::" ";
                        ContractRenewal."Original Contract ID" := Format(ContractRenewal."Contract ID");
                        ContractRenewal.Modify();
                        RenewalHandler.ProcessContractRenewal(ContractRenewal);
                    end;
                else
                    Message('Unsupported Tenancy Contract Status: %1', ContractStatusRec."Tenancy Contract Status");
            end;
        if ContractStatusRec.Status = 'Declined' then begin
            ContractRenewal."Approval For Renewal" := ContractRenewal."Approval For Renewal"::" ";
            ContractRenewal.Modify();
        end;
    end;

    procedure ProcessContractRenewal(RenewalRec: Record "Contract Renewal")
    var
        TenancyContractRec: Record "Tenancy Contract";
        EmailRec: Codeunit "Send Contract Renewal Email";
        ContractIDInt: Integer;
    begin
        if RenewalRec."Renewal Contract Status" = RenewalRec."Renewal Contract Status"::"Renewal of Original Contract ID" then
            if Evaluate(ContractIDInt, RenewalRec."Original Contract ID") then begin
                TenancyContractRec.SetRange("Contract ID", ContractIDInt);
                if TenancyContractRec.FindFirst() then begin
                    TenancyContractRec."Tenant Contract Status" :=
                        TenancyContractRec."Tenant Contract Status"::"Active-Contract Renewed";
                    TenancyContractRec.Modify();
                    Message('Tenancy Contract ID %1 updated to "Active-Contract Renewed".', ContractIDInt);
                end else
                    Error('No Tenancy Contract found with Contract ID %1.', ContractIDInt);
                EmailRec.SendEmail(RenewalRec);
            end else
                Error('Failed to convert Original Contract ID "%1" to Integer.', RenewalRec."Original Contract ID");
    end;
}
