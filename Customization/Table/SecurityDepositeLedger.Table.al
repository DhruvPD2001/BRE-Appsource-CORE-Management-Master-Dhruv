table 50512 "Security Deposite Ledger"
{
    DataClassification = ToBeClassified;
    Caption = 'Security Deposite Ledger';

    fields
    {
        field(50501; "Ledger ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ledger ID';
            Editable = false;
        }

        field(50502; "Contract ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
            TableRelation = "Tenancy Contract"."Contract ID";
        }

        field(50503; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
            TableRelation = Customer."No.";
        }

        field(50504; "Property ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property ID';
            TableRelation = "Property Registration"."Property ID";
        }
        field(50505; "Transaction Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Transaction Date';
            Editable = false;
        }

        field(50506; "Transaction Type"; Option)
        {
            // DataClassification = ToBeClassified;
            OptionMembers = " ","Deposit","Deduction","Refund";
            Caption = 'Transaction Type';
        }
        field(50507; "Initial Deposit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Initial Deposit Amount';
        }
        field(50508; "Unpaid Rent Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Unpaid Rent Deduction';
        }
        field(50509; "Damage Charges Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Damage Charges Deduction';
        }
        field(50510; "Penalty Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Penalty Deduction';
        }
        field(50511; "Service Charges Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Charges Deduction';
        }
        field(50512; "Other Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Deductions';
        }
        field(50513; "Total Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Deductions';
        }
        field(50514; "Refundable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Refundable Amount';
        }
        field(50515; "Approval Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Status';
        }
        field(50516; "Processed By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Processed By';
            // TableRelation = User;
        }
        field(50517; "Final Settlement Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Settlement Date';
        }
    }

    keys
    {
        key(Key1; "Ledger ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";
    begin
        "Transaction Date" := CurrentDateTime;
        "Total Deductions" := "Unpaid Rent Deduction" + "Damage Charges Deduction" + "Penalty Deduction" + "Service Charges Deduction" + "Other Deductions";
        "Refundable Amount" := "Initial Deposit Amount" - "Total Deductions";
        if "Ledger ID" = '' then
            "Ledger ID" := NoSeriesMgt.GetNextNo('S-DEPOSITLEDGER', Today(), true);
    end;

    trigger OnModify()
    begin
        "Transaction Date" := CurrentDateTime;
        "Total Deductions" := "Unpaid Rent Deduction" + "Damage Charges Deduction" + "Penalty Deduction" + "Service Charges Deduction" + "Other Deductions";
        "Refundable Amount" := "Initial Deposit Amount" - "Total Deductions";
    end;
}