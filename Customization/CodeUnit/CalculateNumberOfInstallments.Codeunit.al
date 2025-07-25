codeunit 50105 CalculateNumberOfInstallments
{
    procedure CalculateInstallments(var prevenuestructuresubpage: Record "Revenue Structure Subpage")
    var
        revenuestructure: Record "Revenue Structure";
        revenuestructuresubpage: Record "Revenue Structure Subpage";
        getinstallments: Integer;
        Totalinstallments: Integer;
    begin
        Totalinstallments := 0;
        revenuestructure.SetRange("RS ID", prevenuestructuresubpage."RS ID");
        revenuestructure.SetRange("Contract ID", prevenuestructuresubpage."Contract Id");
        if revenuestructure.FindSet() then begin
            getinstallments := prevenuestructuresubpage."Yearly No. of Installment";
            Totalinstallments += getinstallments;
            revenuestructuresubpage.SetRange("RS ID", revenuestructure."RS ID");
            if revenuestructuresubpage.FindSet() then
                repeat
                    if revenuestructuresubpage."Entry No." <> prevenuestructuresubpage."Entry No." then begin
                        getinstallments := revenuestructuresubpage."Yearly No. of Installment";
                        Totalinstallments += getinstallments;
                    end;
                until revenuestructuresubpage.Next() = 0;
            revenuestructure."Number of Installments" := Totalinstallments;
            revenuestructure.Modify();
        end;
    end;

    procedure BeforeDeleteCalculateInstallments(var prevenuestructuresubpage: Record "Revenue Structure Subpage")
    var
        revenuestructure: Record "Revenue Structure";
        revenuestructuresubpage: Record "Revenue Structure Subpage";
        getinstallments: Integer;
        Totalinstallments: Integer;
    begin
        Totalinstallments := 0;
        revenuestructure.SetRange("RS ID", prevenuestructuresubpage."RS ID");
        revenuestructure.SetRange("Contract ID", prevenuestructuresubpage."Contract Id");
        if revenuestructure.FindSet() then begin
            revenuestructuresubpage.SetRange("RS ID", revenuestructure."RS ID");
            if revenuestructuresubpage.FindSet() then
                repeat
                    if revenuestructuresubpage."Entry No." <> prevenuestructuresubpage."Entry No." then begin
                        getinstallments := revenuestructuresubpage."Yearly No. of Installment";
                        Totalinstallments += getinstallments;
                    end;
                until revenuestructuresubpage.Next() = 0;
            revenuestructure."Number of Installments" := Totalinstallments;
            revenuestructure.Modify();
        end;
    end;
}
