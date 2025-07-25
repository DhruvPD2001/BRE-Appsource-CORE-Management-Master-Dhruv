codeunit 50108 "Final Settlement Posting Mgt."
{
    procedure PostFinalSettlementAmount(FinalSettlement: Record "FinalSettlement")
    var
        GenJnlLine: Record "Gen. Journal Line";
        TenantContract: Record "Final Calculation";
        PendingReceivableRID: Record "Pending Receviable Grid";
        AdditionalCharges: Record "Additional Charges Sub";
        BillingSetup: Record "Final Billing Calculation Grid";
        GLSetup: Record "General Ledger Setup";
        BankAccount: Record "Bank Account";
        CustomerCard: Record Customer;
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        LineNo: Integer;
        DocNo: Code[20];
        Amount: Decimal;
        PendingAmount: Decimal;
        TenantName: Text[100];
        JournalTemplateName: Code[10];
        JournalBatchName: Code[10];
    begin
        GLSetup.Get();
        Amount := FinalSettlement."Receivable Total Amount";
        if Amount = 0 then
            Error('Final Settlement Amount is zero. Cannot post.');
        Amount := Round(Amount, GLSetup."Amount Rounding Precision");
        JournalTemplateName := 'CASH RECE';
        JournalBatchName := 'DEFAULT';
        TenantContract.Reset();
        TenantContract.SetRange("Contract ID", FinalSettlement."Contract ID");
        if not TenantContract.FindFirst() then
            Error('Contract not found for Contract ID %1', FinalSettlement."Contract ID");
        TenantName := TenantContract."Tenant Name";
        PendingReceivableRID.Reset();
        PendingReceivableRID.SetRange("Contract ID", FinalSettlement."Contract ID");
        if not PendingReceivableRID.FindFirst() then
            Error('Pending receivable not found for Contract ID %1', FinalSettlement."Contract ID");
        PendingAmount := PendingReceivableRID."Total Receivable";
        if PendingAmount <= 0 then
            Error('Pending amount is zero or negative (%1) for Contract ID %2',
                  PendingAmount, FinalSettlement."Contract ID");
        AdditionalCharges.Reset();
        AdditionalCharges.SetRange("Contract ID", FinalSettlement."Contract ID");
        if not AdditionalCharges.FindFirst() then
            Error('Additional charges not found for Contract ID %1', FinalSettlement."Contract ID");
        DocNo := 'FS-' + Format(FinalSettlement."Contract ID") + '-' + Format(FinalSettlement."FC ID");
        LineNo := 10000;
        if TenantContract."Total Receive" <= 0 then
            Error('Total receive amount is zero or negative (%1) for Contract ID %2',
                  TenantContract."Total Receive", FinalSettlement."Contract ID");
        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JournalTemplateName;
        GenJnlLine."Journal Batch Name" := JournalBatchName;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := Today;
        GenJnlLine."Document No." := DocNo;
        GenJnlLine.Description := BillingSetup."Invoice ID";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := FinalSettlement."Tenant ID";
        GenJnlLine.Description := TenantName;
        GenJnlLine.Validate(Amount, -TenantContract."Total Receive");
        if GenJnlLine.Amount = 0 then
            Error('Amount became zero after validation for first journal line. Check Customer %1 and amount %2',
                  FinalSettlement."Tenant ID", TenantContract."Total Receive");
        BankAccount.Reset();
        BankAccount.SetRange("Search Name", FinalSettlement."Deposit Bank");
        if BankAccount.FindFirst() then begin
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
            GenJnlLine."Bal. Account No." := BankAccount."No.";
        end
        else begin
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            GenJnlLine."Bal. Account No." := '3001';
        end;
        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
        GenJnlLine."Applies-to Doc. No." := AdditionalCharges."Invoiced ID";
        GenJnlLine.Insert();
        LineNo += 10000;
        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JournalTemplateName;
        GenJnlLine."Journal Batch Name" := JournalBatchName;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := Today;
        GenJnlLine."Document No." := DocNo;
        GenJnlLine.Description := AdditionalCharges."Invoiced ID";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := FinalSettlement."Tenant ID";
        GenJnlLine.Description := TenantName;
        GenJnlLine.Validate(Amount, -PendingAmount);
        if GenJnlLine.Amount = 0 then
            Error('Amount became zero after validation for second journal line. Check Customer %1 and amount %2',
                  FinalSettlement."Tenant ID", PendingAmount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
        BillingSetup.Reset();
        BillingSetup.SetRange("Contract ID", FinalSettlement."Contract ID");
        if BillingSetup.FindFirst() then
            GenJnlLine."Applies-to Doc. No." := BillingSetup."Invoice ID"
        else
            Error('No billing setup found for Contract ID %1', FinalSettlement."Contract ID");
        GenJnlLine.Insert();
        if TenantContract."Unit Type" <> '' then begin
            CustomerCard.Reset();
            CustomerCard.SetRange("No.", FinalSettlement."Tenant ID");
            if CustomerCard.FindFirst() then begin
                CustomerCard.Validate("Gen. Bus. Posting Group", TenantContract."Unit Type");
                CustomerCard.Validate("Customer Posting Group", TenantContract."Unit Type");
                CustomerCard.Modify();
            end;
        end;
        GenJnlPost.Run(GenJnlLine);
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", JournalTemplateName);
        GenJnlLine.SetRange("Journal Batch Name", JournalBatchName);
        if GenJnlLine.FindSet() then
            GenJnlLine.DeleteAll(true);
        Message('Final Settlement amount posted successfully. Total: %1, Pending: %2', Amount, PendingAmount);
    end;

    procedure receivecashrecipt(FinalSettlement: Record "FinalSettlement")
    var
        GenJnlLine: Record "Gen. Journal Line";
        finalcalculation: Record "Final Calculation";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        TerminationChargesub: Record "Additional Charges Sub";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PostingDate: Date;
        DocumentNo: Code[20];
        AccountNo: Code[20];
        InvoiceNo: Code[20];
        LastLineNo: Integer;
        TotalRefundableDeposit: Decimal;
        Tenantid: Code[20];
        Tenantname: Text[100];
        JournalTemplateName: Code[10];
        JournalBatchName: Code[10];
    begin
        JournalTemplateName := 'CASH RECE';
        JournalBatchName := 'DEFAULT';
        if not GenJnlTemplate.Get(JournalTemplateName) then
            Error('The Journal Template %1 does not exist.', JournalTemplateName);
        GenJnlBatch.Reset();
        GenJnlBatch.SetRange("Journal Template Name", JournalTemplateName);
        GenJnlBatch.SetRange(Name, JournalBatchName);
        if GenJnlBatch.IsEmpty() then
            Error('The Journal Batch %1 does not exist for template %2.', JournalBatchName, JournalTemplateName);
        PostingDate := Today();
        if FinalSettlement."Contract ID" = 0 then
            Error('Contract ID is missing in the Final Settlement record');
        DocumentNo := 'RECEIVE-' + Format(FinalSettlement."Contract ID");
        finalcalculation.Reset();
        finalcalculation.SetRange("Contract ID", FinalSettlement."Contract ID");
        if finalcalculation.FindFirst() then begin
            Tenantid := finalcalculation."Tenant ID";
            Tenantname := finalcalculation."Tenant Name";
        end else
            Error('Final Calculation not found for Contract ID %1', FinalSettlement."Contract ID");
        if UpperCase(FinalSettlement."Receivable Payment mode") = 'CASH' then
            AccountNo := '3001'
        else begin
            AccountNo := '3002';
            if AccountNo = '' then
                Error('Bank Account No. not found for Contract ID %1', FinalSettlement."Contract ID");
        end;
        TotalRefundableDeposit := 0;
        InvoiceNo := '';
        TerminationChargesub.Reset();
        TerminationChargesub.SetRange("Contract ID", FinalSettlement."Contract ID");
        if TerminationChargesub.FindSet() then
            repeat
                TotalRefundableDeposit += TerminationChargesub."Amount Including VAT";
                if InvoiceNo = '' then
                    InvoiceNo := TerminationChargesub."Posted Invoice ID";
            until TerminationChargesub.Next() = 0
        else
            Error('Additional charges not found for Contract ID %1', FinalSettlement."Contract ID");
        if TotalRefundableDeposit <= 0 then
            Error('Total refundable deposit amount is zero or negative (%1) for Contract ID %2. Cannot create journal entry.',
                  TotalRefundableDeposit, FinalSettlement."Contract ID");
        LastLineNo := 10000;
        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JournalTemplateName;
        GenJnlLine."Journal Batch Name" := JournalBatchName;
        GenJnlLine."Line No." := LastLineNo;
        GenJnlLine."Posting Date" := PostingDate;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := DocumentNo;
        GenJnlLine.Description := Tenantname;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := Tenantid;
        GenJnlLine.Validate(Amount, -TotalRefundableDeposit);
        if GenJnlLine.Amount = 0 then
            Error('Amount became zero after validation. Check Customer %1 and amount %2',
                  Tenantid, TotalRefundableDeposit);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := AccountNo;
        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
        GenJnlLine."Applies-to Doc. No." := InvoiceNo;
        GenJnlLine.Insert(true);
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", JournalTemplateName);
        GenJnlLine.SetRange("Journal Batch Name", JournalBatchName);
        if GenJnlLine.FindSet() then
            GenJnlLine.DeleteAll(true);
        if GenJnlLine.Amount <> 0 then begin
            GenJnlPostLine.RunWithCheck(GenJnlLine);
            Message('Cash Receipt journal entries created and posted successfully.');
        end else
            Error('Journal posting skipped because amount is zero.');
    end;

    procedure receivablecashrecipt(FinalSettlement: Record "FinalSettlement")
    var
        GenJnlLine: Record "Gen. Journal Line";
        billingcalculation: Record "Final Billing Calculation Grid";
        finalcalculation: Record "Final Calculation";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PostingDate: Date;
        DocumentNo: Code[20];
        AccountNo: Code[20];
        InvoiceNo: Code[20];
        LastLineNo: Integer;
        TotalRefundableDeposit: Decimal;
        Tenantid: Code[20];
        Tenantname: Text[100];
        JournalTemplateName: Code[10];
        JournalBatchName: Code[10];
    begin
        JournalTemplateName := 'CASH RECE';
        JournalBatchName := 'DEFAULT';
        if not GenJnlTemplate.Get(JournalTemplateName) then
            Error('The Journal Template %1 does not exist.', JournalTemplateName);
        GenJnlBatch.Reset();
        GenJnlBatch.SetRange("Journal Template Name", JournalTemplateName);
        GenJnlBatch.SetRange(Name, JournalBatchName);
        if GenJnlBatch.IsEmpty() then
            Error('The Journal Batch %1 does not exist for template %2.', JournalBatchName, JournalTemplateName);
        PostingDate := Today();
        if FinalSettlement."Contract ID" = 0 then
            Error('Contract ID is missing in the Final Settlement record');
        DocumentNo := 'RECEIVE-' + Format(FinalSettlement."Contract ID");
        finalcalculation.Reset();
        finalcalculation.SetRange("Contract ID", FinalSettlement."Contract ID");
        if finalcalculation.FindFirst() then begin
            Tenantid := finalcalculation."Tenant ID";
            Tenantname := finalcalculation."Tenant Name";
        end else
            Error('Final Calculation not found for Contract ID %1', FinalSettlement."Contract ID");
        if UpperCase(FinalSettlement."Receivable Payment mode") = 'CASH' then
            AccountNo := '3001'
        else begin
            AccountNo := '3002';
            if AccountNo = '' then
                Error('Bank Account No. not found for Contract ID %1', FinalSettlement."Contract ID");
        end;
        billingcalculation.Reset();
        billingcalculation.SetRange("Contract ID", FinalSettlement."Contract ID");
        if billingcalculation.FindFirst() then begin
            InvoiceNo := billingcalculation."Posted Invoice ID";
            TotalRefundableDeposit := billingcalculation."Invoice Amount";
            if TotalRefundableDeposit <= 0 then
                Error('Invoice amount is zero or negative (%1) for Contract ID %2. Cannot create journal entry.',
                      TotalRefundableDeposit, FinalSettlement."Contract ID");
        end else
            Error('Invoice not found for Contract ID %1', FinalSettlement."Contract ID");
        LastLineNo := 10000;
        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JournalTemplateName;
        GenJnlLine."Journal Batch Name" := JournalBatchName;
        GenJnlLine."Line No." := LastLineNo;
        GenJnlLine."Posting Date" := PostingDate;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := DocumentNo;
        GenJnlLine.Description := Tenantname;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := Tenantid;
        GenJnlLine.Validate(Amount, -TotalRefundableDeposit);
        if GenJnlLine.Amount = 0 then
            Error('Amount became zero after validation. Check Customer %1 and amount %2',
                  Tenantid, TotalRefundableDeposit);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := AccountNo;
        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
        GenJnlLine."Applies-to Doc. No." := InvoiceNo;
        GenJnlLine.Insert(true);
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", JournalTemplateName);
        GenJnlLine.SetRange("Journal Batch Name", JournalBatchName);
        if GenJnlLine.FindSet() then
            GenJnlLine.DeleteAll(true);
        if GenJnlLine.Amount <> 0 then begin
            GenJnlPostLine.RunWithCheck(GenJnlLine);
            Message('Cash Receipt journal entries created and posted successfully.');
        end else
            Error('Journal posting skipped because amount is zero.');
    end;
}