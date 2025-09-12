
codeunit 50108 "Final Settlement Posting Mgt."
{
    procedure PostFinalSettlementAmount(FinalSettlement: Record "FinalSettlement")
    var
        GenJnlLine: Record "Gen. Journal Line";
        TenantContract: Record "Final Calculation";
        PendingReceivableRID: Record "Pending Receviable Grid";
        AdditionalCharges: Record "Additional Charges Sub";
        CustomerCard: Record Customer;
        BankAccount: Record "Bank Account";
        GLSetup: Record "General Ledger Setup";
        BillingSetup: Record "Final Billing Calculation Grid";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        LineNo: Integer;
        DocNo: Code[20];
        Amount: Decimal;
        PendingAmount: Decimal;
        TenantName: Text[100];
        BankAccountNo: Code[20];
        JournalTemplateName: Code[10];
        JournalBatchName: Code[10];
        InvoiceID: Code[20];
        HasJournalEntries: Boolean;
    begin
        // Load G/L Setup for rounding
        GLSetup.Get();
        GenJnlLine.DeleteAll();
        // Check if there's any amount to post
        Amount := FinalSettlement."Receivable Total Amount";
        if Amount = 0 then
            Error('Final Settlement Amount is zero. Cannot post.');

        // Round the amount according to G/L setup
        Amount := Round(Amount, GLSetup."Amount Rounding Precision");

        // Set Journal Template and Batch
        JournalTemplateName := 'CASH RECE';
        JournalBatchName := 'DEFAULT';

        // Get tenant contract information
        TenantContract.Reset();
        TenantContract.SetRange("Contract ID", FinalSettlement."Contract ID");
        if not TenantContract.FindFirst() then
            Error('Contract not found for Contract ID %1', FinalSettlement."Contract ID");

        TenantName := TenantContract."Tenant Name";

        // Get pending receivable information
        PendingReceivableRID.Reset();
        PendingReceivableRID.SetRange("Contract ID", FinalSettlement."Contract ID");
        if PendingReceivableRID.FindFirst() then
            PendingAmount := PendingReceivableRID."Total Receivable"
        else
            PendingAmount := 0;

        // Get Invoice ID (Optional - try multiple sources)
        InvoiceID := '';

        // If still not found, create default
        if InvoiceID = '' then
            InvoiceID := 'FS-' + Format(FinalSettlement."Contract ID");

        // Find Bank Account
        BankAccountNo := '';
        BankAccount.Reset();
        BankAccount.SetRange("Search Name", FinalSettlement."Deposit Bank");
        if BankAccount.FindFirst() then
            BankAccountNo := BankAccount."No.";

        // Generate Document No
        DocNo := 'FS-' + Format(FinalSettlement."Contract ID") + '-' + Format(FinalSettlement."FC ID");

        // Start with first line number
        LineNo := 10000;
        HasJournalEntries := false;

        // 1st Line - Total Receive entry (Only if Total Receive > 0)
        if TenantContract."Total Receive" > 0 then begin
            AdditionalCharges.Reset();
            AdditionalCharges.SetRange("Contract ID", FinalSettlement."Contract ID");
            if AdditionalCharges.FindFirst() then
                InvoiceID := AdditionalCharges."Invoiced ID";
            Clear(GenJnlLine);
            GenJnlLine.Init();
            GenJnlLine."Journal Template Name" := JournalTemplateName;
            GenJnlLine."Journal Batch Name" := JournalBatchName;
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Posting Date" := Today;
            GenJnlLine."Document No." := DocNo;
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
            GenJnlLine."Account No." := FinalSettlement."Tenant ID";
            GenJnlLine.Description := TenantName;
            GenJnlLine.Validate(Amount, -TenantContract."Total Receive");

            // Set balancing account
            if BankAccountNo <> '' then begin
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
                GenJnlLine."Bal. Account No." := BankAccountNo;
            end else begin
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '3001';
            end;

            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
            GenJnlLine."Applies-to Doc. No." := InvoiceID;
            GenJnlLine.Insert();

            LineNo += 10000;
            HasJournalEntries := true;
        end;

        // 2nd Line - Pending Receivable entry (Only if Pending Amount > 0)
        if PendingAmount > 0 then begin
            BillingSetup.Reset();
            BillingSetup.SetRange("Contract ID", FinalSettlement."Contract ID");
            if BillingSetup.FindFirst() then
                InvoiceID := BillingSetup."Invoice ID";
            Clear(GenJnlLine);
            GenJnlLine.Init();
            GenJnlLine."Journal Template Name" := JournalTemplateName;
            GenJnlLine."Journal Batch Name" := JournalBatchName;
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Posting Date" := Today;
            GenJnlLine."Document No." := DocNo;
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
            GenJnlLine."Account No." := FinalSettlement."Tenant ID";
            GenJnlLine.Description := TenantName;
            GenJnlLine.Validate(Amount, -PendingAmount);

            // Set balancing account
            if BankAccountNo <> '' then begin
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
                GenJnlLine."Bal. Account No." := BankAccountNo;
            end else begin
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '3001';
            end;

            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
            GenJnlLine."Applies-to Doc. No." := InvoiceID;
            GenJnlLine.Insert();

            HasJournalEntries := true;
        end;

        // Check if at least one journal line was created
        if not HasJournalEntries then
            Error('No journal entries were created. Both Total Receive (%1) and Pending Amount (%2) are zero or negative for Contract ID %3',
                  TenantContract."Total Receive", PendingAmount, FinalSettlement."Contract ID");

        // Update customer posting groups if Unit Type exists
        if TenantContract."Unit Type" <> '' then begin
            CustomerCard.Reset();
            CustomerCard.SetRange("No.", FinalSettlement."Tenant ID");
            if CustomerCard.FindFirst() then begin
                CustomerCard.Validate("Gen. Bus. Posting Group", TenantContract."Unit Type");
                CustomerCard.Validate("Customer Posting Group", TenantContract."Unit Type");
                CustomerCard.Modify();
            end;
        end;

        // Post the Journal
        GenJnlPost.Run(GenJnlLine);

        // Clean up journal lines
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", JournalTemplateName);
        GenJnlLine.SetRange("Journal Batch Name", JournalBatchName);
        if GenJnlLine.FindSet() then
            GenJnlLine.DeleteAll(true);

        Message('Final Settlement amount posted successfully. Total Receive: %1, Pending: %2',
                TenantContract."Total Receive", PendingAmount);
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
        // Initialize journal template and batch names
        JournalTemplateName := 'CASH RECE';
        JournalBatchName := 'DEFAULT';

        // Verify that the template and batch exist
        if not GenJnlTemplate.Get(JournalTemplateName) then
            Error('The Journal Template %1 does not exist.', JournalTemplateName);

        GenJnlBatch.Reset();
        GenJnlBatch.SetRange("Journal Template Name", JournalTemplateName);
        GenJnlBatch.SetRange(Name, JournalBatchName);
        if GenJnlBatch.IsEmpty() then
            Error('The Journal Batch %1 does not exist for template %2.', JournalBatchName, JournalTemplateName);

        PostingDate := Today();

        // Add validation for finalsettlement record
        if FinalSettlement."Contract ID" = 0 then
            Error('Contract ID is missing in the Final Settlement record');

        DocumentNo := 'RECEIVE-' + Format(FinalSettlement."Contract ID");

        // Fetch tenant details from Final Calculation
        finalcalculation.Reset();
        finalcalculation.SetRange("Contract ID", FinalSettlement."Contract ID");
        if finalcalculation.FindFirst() then begin
            Tenantid := finalcalculation."Tenant ID";
            Tenantname := finalcalculation."Tenant Name";
        end else
            Error('Final Calculation not found for Contract ID %1', FinalSettlement."Contract ID");

        // Determine Bal. Account based on Refund Payment Mode
        if UpperCase(FinalSettlement."Receivable Payment mode") = 'CASH' then
            AccountNo := '3001'
        else begin
            AccountNo := '3002';
            if AccountNo = '' then
                Error('Bank Account No. not found for Contract ID %1', FinalSettlement."Contract ID");
        end;

        // Sum Additional Charges and fetch Invoice No.
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

        // Critical validation - ensure amount is not zero
        if TotalRefundableDeposit <= 0 then
            Error('Total refundable deposit amount is zero or negative (%1) for Contract ID %2. Cannot create journal entry.',
                  TotalRefundableDeposit, FinalSettlement."Contract ID");

        // Start with standard line number
        LastLineNo := 10000;

        // Create journal line
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

        // Use Validate to ensure all dependent fields are calculated
        GenJnlLine.Validate(Amount, -TotalRefundableDeposit);

        // Double-check that amount is not zero after validation
        if GenJnlLine.Amount = 0 then
            Error('Amount became zero after validation. Check Customer %1 and amount %2',
                  Tenantid, TotalRefundableDeposit);

        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := AccountNo;
        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
        GenJnlLine."Applies-to Doc. No." := InvoiceNo;

        // Insert the journal line
        GenJnlLine.Insert(true);

        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", JournalTemplateName);
        GenJnlLine.SetRange("Journal Batch Name", JournalBatchName);
        if GenJnlLine.FindSet() then
            GenJnlLine.DeleteAll(true);

        // Post the journal line
        if GenJnlLine.Amount <> 0 then begin
            GenJnlPostLine.RunWithCheck(GenJnlLine);
            Message('Cash Receipt journal entries created and posted successfully.');
        end else
            Error('Journal posting skipped because amount is zero.');
    end;

    procedure receivablecashrecipt(FinalSettlement: Record "FinalSettlement")
    var
        GenJnlLine: Record "Gen. Journal Line";
        finalcalculation: Record "Final Calculation";
        billingcalculation: Record "Final Billing Calculation Grid";
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
        // Initialize journal template and batch names
        JournalTemplateName := 'CASH RECE';
        JournalBatchName := 'DEFAULT';

        // Verify that the template and batch exist
        if not GenJnlTemplate.Get(JournalTemplateName) then
            Error('The Journal Template %1 does not exist.', JournalTemplateName);

        GenJnlBatch.Reset();
        GenJnlBatch.SetRange("Journal Template Name", JournalTemplateName);
        GenJnlBatch.SetRange(Name, JournalBatchName);
        if GenJnlBatch.IsEmpty() then
            Error('The Journal Batch %1 does not exist for template %2.', JournalBatchName, JournalTemplateName);

        PostingDate := Today();

        // Add validation for finalsettlement record
        if FinalSettlement."Contract ID" = 0 then
            Error('Contract ID is missing in the Final Settlement record');

        DocumentNo := 'RECEIVE-' + Format(FinalSettlement."Contract ID");

        // Fetch tenant details from Final Calculation
        finalcalculation.Reset();
        finalcalculation.SetRange("Contract ID", FinalSettlement."Contract ID");
        if finalcalculation.FindFirst() then begin
            Tenantid := finalcalculation."Tenant ID";
            Tenantname := finalcalculation."Tenant Name";
        end else
            Error('Final Calculation not found for Contract ID %1', FinalSettlement."Contract ID");

        // Determine Bal. Account based on Refund Payment Mode
        if UpperCase(FinalSettlement."Receivable Payment mode") = 'CASH' then
            AccountNo := '3001'
        else begin
            AccountNo := '3002';
            if AccountNo = '' then
                Error('Bank Account No. not found for Contract ID %1', FinalSettlement."Contract ID");
        end;

        // Find Invoice No. and Amount based on Contract ID
        billingcalculation.Reset();
        billingcalculation.SetRange("Contract ID", FinalSettlement."Contract ID");
        if billingcalculation.FindFirst() then begin
            InvoiceNo := billingcalculation."Posted Invoice ID";
            TotalRefundableDeposit := billingcalculation."Invoice Amount";

            // Critical check: Ensure amount is not zero or negative
            if TotalRefundableDeposit <= 0 then
                Error('Invoice amount is zero or negative (%1) for Contract ID %2. Cannot create journal entry.',
                      TotalRefundableDeposit, FinalSettlement."Contract ID");
        end else
            Error('Invoice not found for Contract ID %1', FinalSettlement."Contract ID");

        LastLineNo := 10000;

        // Create journal line
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