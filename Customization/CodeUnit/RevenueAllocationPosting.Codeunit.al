codeunit 50516 "Revenue Allocation Posting"
{
    Subtype = Normal;
    procedure PostRevenueAllocation(RevenueAllocationRec: Record "Revenue Allocation Details")
    var
        GenJournalLineRec: Record "Gen. Journal Line";
        RevenueAllocationGrid: Record "Revenue Allocation SubGrid";
        OtherChargesAllocationGrid: Record "Revenue Recognition Details";
        COASetup: Record "COA Setup";
        COASetupLine: Record "COA Setup Line";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        LineNumber: Integer;
    begin
        COASetup.Get();
        GenJournalLineRec.DeleteAll();
        RevenueAllocationGrid.SetRange("Header No.", RevenueAllocationRec."No.");
        if RevenueAllocationGrid.FindSet() then begin
            LineNumber := 0;
            repeat
                LineNumber := GenJournalLineRec."Line No." + 10000;
                GenJournalLineRec.Init();
                GenJournalLineRec."Journal Template Name" := 'GENERAL';
                GenJournalLineRec."Journal Batch Name" := 'DEFAULT';
                GenJournalLineRec."Line No." := LineNumber;
                GenJournalLineRec."Account Type" := GenJournalLineRec."Account Type"::"G/L Account";
                GenJournalLineRec."Document No." := RevenueAllocationGrid.Description;
                GenJournalLineRec."Posting Date" := Today;
                GenJournalLineRec.Description := 'Rent - ' + RevenueAllocationGrid."Posting Period";
                GenJournalLineRec.Validate(Amount, RevenueAllocationGrid."Total Value");
                GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"G/L Account";
                if (RevenueAllocationGrid."Unit Type" = 'COMMERCIAL') or (RevenueAllocationGrid."Unit Type" = 'Commercial') then begin
                    GenJournalLineRec."Account No." := COASetup."Commercial Unearned Rent";
                    GenJournalLineRec."Bal. Account No." := COASetup."Commercial Rent";
                end
                else
                    if (RevenueAllocationGrid."Unit Type" = 'RESIDENTIAL') or (RevenueAllocationGrid."Unit Type" = 'Residential') then begin
                        GenJournalLineRec."Account No." := COASetup."Residential Unearned Rent";
                        GenJournalLineRec."Bal. Account No." := COASetup."Residential Rent";
                    end;
                GenJournalLineRec.Insert();
            until RevenueAllocationGrid.Next() = 0;
        end;
        OtherChargesAllocationGrid.SetRange("RR_No.", RevenueAllocationRec."No.");
        if OtherChargesAllocationGrid.FindSet() then begin
            LineNumber := GenJournalLineRec."Line No." + 10000;
            repeat
                COASetupLine.SetRange("Secondary Item", OtherChargesAllocationGrid."Item Type");
                COASetupLine.FindFirst();
                LineNumber := GenJournalLineRec."Line No." + 10000;
                GenJournalLineRec.Init();
                GenJournalLineRec."Journal Template Name" := 'GENERAL';
                GenJournalLineRec."Journal Batch Name" := 'DEFAULT';
                GenJournalLineRec."Line No." := LineNumber;
                GenJournalLineRec."Account Type" := GenJournalLineRec."Account Type"::"G/L Account";
                GenJournalLineRec."Document No." := OtherChargesAllocationGrid.Description;
                GenJournalLineRec."Posting Date" := Today;
                GenJournalLineRec.Description := CopyStr(OtherChargesAllocationGrid."Item Type" + ' - ' + OtherChargesAllocationGrid."Posting Period", 1, 100);
                GenJournalLineRec.Validate(Amount, OtherChargesAllocationGrid."Total Value");
                GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"G/L Account";
                if (OtherChargesAllocationGrid."Unit Type" = 'COMMERCIAL') or (OtherChargesAllocationGrid."Unit Type" = 'Commercial') then begin
                    GenJournalLineRec."Account No." := COASetupLine."Commercial-Unearned";
                    GenJournalLineRec."Bal. Account No." := COASetupLine.Commercial;
                end
                else
                    if (OtherChargesAllocationGrid."Unit Type" = 'RESIDENTIAL') or (OtherChargesAllocationGrid."Unit Type" = 'Residential') then begin
                        GenJournalLineRec."Account No." := COASetupLine."Residential-Unearned";
                        GenJournalLineRec."Bal. Account No." := COASetupLine.Residential;
                    end;
                GenJournalLineRec.Insert();
            until OtherChargesAllocationGrid.Next() = 0;
        end;
        Commit();
        GenJnlPost.Preview(GenJournalLineRec);
    end;
}