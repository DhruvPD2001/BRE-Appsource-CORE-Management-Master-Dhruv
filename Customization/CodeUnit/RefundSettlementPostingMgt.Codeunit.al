codeunit 50109 "Refund Settlement Posting Mgt."
{
    procedure PostRefundJournalLines(FinalSettlementRefund: Record "FinalSettlementRefund")
    var
        GenJnlLine: Record "Gen. Journal Line";
        TenantContract: Record "Final Calculation";
        BankAccount: Record "Bank Account";
        customer: Record Customer;
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        GenJnlTemplate: Code[10];
        GenJnlBatch: Code[10];
        LineNo: Integer;
        DocNo: Code[20];
        PostingDate: Date;
        TenantReceivableAccount: Code[20];
        RefundOtherDepositGL: Code[20];
        RefundChillerDepositGL: Code[20];
        RefundSecurityDepositGL: Code[20];
        NetRefundToTenant: Decimal;
        adjustsecurityDeposit: Decimal;
        adjustChillerDeposit: Decimal;
        adjustotherDeposit: Decimal;
        appliedamount: Decimal;
    begin
        RefundOtherDepositGL := '4508';
        RefundChillerDepositGL := '4508';
        RefundSecurityDepositGL := '4502';
        NetRefundToTenant := Round(FinalSettlementRefund."Net Refund to the Tenant");
        adjustsecurityDeposit := FinalSettlementRefund."Adjust Security Deposit";
        adjustChillerDeposit := FinalSettlementRefund."Adjust Chiller Deposit";
        adjustotherDeposit := FinalSettlementRefund."Adjust other deposit";
        PostingDate := Today();
        GenJnlTemplate := 'CASH RECE';
        GenJnlBatch := 'DEFAULT';
        ClearJournalLines(GenJnlTemplate, GenJnlBatch);
        TenantContract.Reset();
        TenantContract.SetRange("FC ID", FinalSettlementRefund."FC ID");
        if TenantContract.IsEmpty() then
            Error('Final Calculation not found for FC ID %1', FinalSettlementRefund."FC ID");
        customer.SetRange("No.", FinalSettlementRefund."Tenant ID");
        if customer.FindFirst() then
            TenantReceivableAccount := customer."No.";
        DocNo := 'RFND-' + Format(FinalSettlementRefund."Contract ID") + '-' + Format(FinalSettlementRefund."FC ID");
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", GenJnlTemplate);
        GenJnlLine.SetRange("Journal Batch Name", GenJnlBatch);
        if GenJnlLine.FindLast() then
            LineNo := GenJnlLine."Line No." + 10000
        else
            LineNo := 10000;
        if FinalSettlementRefund."Adjust other deposit" > 0 then begin
            AppliedAmount := Round(Min(adjustotherDeposit, NetRefundToTenant));
            GenJnlLine.Init();
            GenJnlLine."Journal Template Name" := 'CASH RECE';
            GenJnlLine."Journal Batch Name" := 'DEFAULT';
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Posting Date" := PostingDate;
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine."Document No." := DocNo;
            GenJnlLine.Description := 'Refund Other Deposit';
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := RefundOtherDepositGL;
            GenJnlLine.Validate(Amount, Round(appliedamount));
            BankAccount.Reset();
            BankAccount.SetRange("Search Name", FinalSettlementRefund."Deposit Bank");
            if BankAccount.FindSet()
            then begin
                GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"Bank Account";
                GenJnlLine."Bal. Account No." := BankAccount."No.";
            end else begin
                GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '3001';
            end;
            GenJnlLine.Insert(true);
            NetRefundToTenant -= AppliedAmount;
            adjustotherDeposit -= AppliedAmount;
            LineNo += 10000;
        end;
        if FinalSettlementRefund."Adjust Chiller Deposit" > 0 then begin
            AppliedAmount := Round(Min(adjustChillerDeposit, NetRefundToTenant));
            GenJnlLine.Init();
            GenJnlLine."Journal Template Name" := 'CASH RECE';
            GenJnlLine."Journal Batch Name" := 'DEFAULT';
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Posting Date" := PostingDate;
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine."Document No." := DocNo;
            GenJnlLine.Description := 'Refund Chiller Deposit';
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := RefundChillerDepositGL;
            GenJnlLine.Validate(Amount, Round(appliedamount));
            BankAccount.Reset();
            BankAccount.SetRange("Search Name", FinalSettlementRefund."Deposit Bank");
            if BankAccount.FindSet()
            then begin
                GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"Bank Account";
                GenJnlLine."Bal. Account No." := BankAccount."No.";
            end else begin
                GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '3001';
            end;
            GenJnlLine.Insert(true);
            NetRefundToTenant -= AppliedAmount;
            adjustChillerDeposit -= AppliedAmount;
            LineNo += 10000;
        end;
        if FinalSettlementRefund."Adjust Security Deposit" > 0 then begin
            AppliedAmount := Round(Min(adjustsecurityDeposit, NetRefundToTenant));
            GenJnlLine.Init();
            GenJnlLine."Journal Template Name" := 'CASH RECE';
            GenJnlLine."Journal Batch Name" := 'DEFAULT';
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Posting Date" := PostingDate;
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine."Document No." := DocNo;
            GenJnlLine.Description := 'Refund Security Deposit';
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := RefundSecurityDepositGL;
            GenJnlLine.Validate(Amount, Round(appliedamount));
            BankAccount.Reset();
            BankAccount.SetRange("Search Name", FinalSettlementRefund."Deposit Bank");
            if BankAccount.FindSet()
            then begin
                GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"Bank Account";
                GenJnlLine."Bal. Account No." := BankAccount."No.";
            end else begin
                GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '3001';
            end;
            GenJnlLine.Insert(true);
            NetRefundToTenant -= AppliedAmount;
            adjustsecurityDeposit -= AppliedAmount;
            LineNo += 10000;
        end;
        if (adjustsecurityDeposit = 0) and (adjustChillerDeposit = 0) and (adjustotherDeposit = 0) then
            if NetRefundToTenant > 0 then begin
                AppliedAmount := Round(NetRefundToTenant);
                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := 'CASH RECE';
                GenJnlLine."Journal Batch Name" := 'DEFAULT';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := PostingDate;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund;
                GenJnlLine."Document No." := DocNo;
                GenJnlLine.Description := 'Refund to Tenant';
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                GenJnlLine."Account No." := TenantReceivableAccount;
                GenJnlLine.Validate(Amount, Round(appliedamount));
                BankAccount.Reset();
                BankAccount.SetRange("Search Name", FinalSettlementRefund."Deposit Bank");
                if BankAccount.FindFirst()
                then begin
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"Bank Account";
                    GenJnlLine."Bal. Account No." := BankAccount."No.";
                end else begin
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '3001';
                end;
                GenJnlLine.Insert(true);
                NetRefundToTenant -= AppliedAmount;
                LineNo += 10000;
            end;
        GenJnlPost.Run(GenJnlLine);
    end;

    local procedure ClearJournalLines(TemplateName: Code[10]; BatchName: Code[10])
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", TemplateName);
        GenJnlLine.SetRange("Journal Batch Name", BatchName);
        if not GenJnlLine.IsEmpty() then
            GenJnlLine.DeleteAll(true);
    end;

    local procedure Min(a: Decimal; b: Decimal): Decimal
    begin
        if a < b then
            exit(a)
        else
            exit(b);
    end;
}