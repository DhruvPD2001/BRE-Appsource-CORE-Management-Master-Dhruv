codeunit 50107 "Security Deposit Posting Mgt."
{
    procedure PostSecurityDepositAmount(SecurityDeposit: Record "Security Deposit")
    var
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        GenJnlTemplate: Code[10];
        GenJnlBatch: Code[10];
        Amount: Decimal;
        PropertyType: Text[30];
        TenantReceivableAccount: Code[20];
        CarryForwardOutAccount: Code[20];
        CarryForwardInAccount: Code[20];
        LineNo: Integer;
        DocNo: Code[20];
    begin
        GenJnlTemplate := 'CASH RECE';
        GenJnlBatch := 'DEFAULT';
        Amount := SecurityDeposit."New_Balance Amount";
        PropertyType := SecurityDeposit."Property Classification";
        if Amount = 0 then
            Error('Security Deposit Amount Received is zero. Cannot post.');
        case PropertyType of
            'Residential':
                TenantReceivableAccount := '1501';
            'Commercial':
                TenantReceivableAccount := '1506';
            else
                Error('Invalid Property Type. Must be Residential or Commercial.');
        end;
        CarryForwardOutAccount := '4504';
        CarryForwardInAccount := '4503';
        DocNo := 'SD-' + Format(SecurityDeposit."Contract ID");
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", GenJnlTemplate);
        GenJnlLine.SetRange("Journal Batch Name", GenJnlBatch);
        if GenJnlLine.FindLast() then
            LineNo := GenJnlLine."Line No." + 1
        else
            LineNo := 1;
        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := GenJnlTemplate;
        GenJnlLine."Journal Batch Name" := GenJnlBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := Today;
        GenJnlLine."Document No." := DocNo;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := TenantReceivableAccount;
        GenJnlLine.Amount := -Amount;
        GenJnlLine.Insert();
        LineNo += 10000;
        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := GenJnlTemplate;
        GenJnlLine."Journal Batch Name" := GenJnlBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := Today;
        GenJnlLine."Document No." := DocNo;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := CarryForwardOutAccount;
        GenJnlLine.Amount := Amount;
        GenJnlLine.Insert();
        LineNo += 10000;
        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := GenJnlTemplate;
        GenJnlLine."Journal Batch Name" := GenJnlBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := Today;
        GenJnlLine."Document No." := DocNo;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := CarryForwardInAccount;
        GenJnlLine.Amount := -Amount;
        GenJnlLine.Insert();
        LineNo += 10000;
        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := GenJnlTemplate;
        GenJnlLine."Journal Batch Name" := GenJnlBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := Today;
        GenJnlLine."Document No." := DocNo;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := TenantReceivableAccount;
        GenJnlLine.Amount := Amount;
        GenJnlLine.Insert();
        GenJnlPost.Run(GenJnlLine);
        Message('Security Deposit posted successfully.');
    end;
}
