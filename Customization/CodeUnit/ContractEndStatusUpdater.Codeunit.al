codeunit 50311 "Contract End Status Updater"
{
    Subtype = Normal;
    trigger OnRun()
    begin
        UpdateStatusesOnContractEnd();
    end;

    local procedure UpdateStatusesOnContractEnd()
    var
        TenancyRec: Record "Tenancy Contract";
        RenewalRec: Record "Contract Renewal";
    begin
        if TenancyRec.FindSet() then
            repeat
                if (TenancyRec."Tenant Contract Status" = TenancyRec."Tenant Contract Status"::"Active-Contract Renewed") and
                   (TenancyRec."Contract End Date" <= Today()) then begin
                    TenancyRec."Tenant Contract Status" := TenancyRec."Tenant Contract Status"::"Contract Renewed";
                    TenancyRec.Modify();
                    RenewalRec.SetRange("Contract ID", TenancyRec."Contract ID");
                    if RenewalRec.FindSet() then
                        repeat
                            RenewalRec."Contract Status" := RenewalRec."Contract Status"::Active;
                            RenewalRec.Modify();
                            TenancyRec.Reset();
                            TenancyRec.SetRange("Renewal Proposal ID", RenewalRec.Id);
                            if TenancyRec.FindSet() then
                                repeat
                                    TenancyRec."Tenant Contract Status" := TenancyRec."Tenant Contract Status"::Active;
                                    TenancyRec.Modify();
                                until TenancyRec.Next() = 0;
                        until RenewalRec.Next() = 0;
                end;
            until TenancyRec.Next() = 0;
    end;
}
