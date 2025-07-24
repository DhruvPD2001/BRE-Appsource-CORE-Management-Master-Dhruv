table 50947 "Pending Receviable Grid"
{
    DataClassification = ToBeClassified;
    Caption = 'Pending Receviable Grid';
    fields
    {
        field(50100; RevenueDescription; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Revenue Description';
        }
        field(50101; RevisedAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revised Amount';
        }
        field(50102; RevisedVAT; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revised VAT';
        }
        field(50103; RevisedAmountInclVAT; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revised Amount Incl. VAT';
        }
        field(50104; ReceiptsAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipts Amount';
        }
        field(50105; ReceiptsVAT; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipts VAT';
        }
        field(50106; ReceiptsAmountInclVAT; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipts Amount Incl. VAT';
        }
        field(50107; DifferenceAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Difference Amount';
        }
        field(50108; DifferenceVAT; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Difference VAT';
        }
        field(50109; DifferenceAmountInclVAT; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Difference Amount Incl. VAT';
        }
        field(50111; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
            DataClassification = ToBeClassified;
        }
        field(50112; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50113; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
            DataClassification = ToBeClassified;
        }
        field(50114; "Total Refundable"; Decimal)
        {
            Caption = 'Total Refundable';
            DataClassification = ToBeClassified;
        }
        field(50115; "Total Receivable"; Decimal)
        {
            Caption = 'Total Receivable';
            DataClassification = ToBeClassified;
        }
        field(50116; "Total Revised Amount"; Decimal)
        {
            Caption = 'Total Revised Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".RevisedAmount where("Contract ID" = field("Contract ID")));
        }
        field(50117; "Total Revised VAT"; Decimal)
        {
            Caption = 'Total Revised VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".RevisedVAT where("Contract ID" = field("Contract ID")));
        }
        field(50118; "Total Revised AmountIncl. VAT"; Decimal)
        {
            Caption = 'Total Revised AmountIncl. VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".RevisedAmountInclVAT where("Contract ID" = field("Contract ID")));
        }
        field(50119; "Total Receipts Amount"; Decimal)
        {
            Caption = 'Total Receipts Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".ReceiptsAmount where("Contract ID" = field("Contract ID")));
        }
        field(50120; "Total Receipts VAT"; Decimal)
        {
            Caption = 'Total Receipts VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".ReceiptsVAT where("Contract ID" = field("Contract ID")));
        }
        field(50121; "Total Receipts AmountIncl. VAT"; Decimal)
        {
            Caption = 'Total Receipts AmountIncl. VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".ReceiptsAmountInclVAT where("Contract ID" = field("Contract ID")));
        }
        field(50122; "Total Difference Amount"; Decimal)
        {
            Caption = 'Total Difference Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".DifferenceAmount where("Contract ID" = field("Contract ID")));
        }
        field(50123; "Total Difference VAT"; Decimal)
        {
            Caption = 'Total Difference VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".DifferenceVAT where("Contract ID" = field("Contract ID")));
        }
        field(50124; "Total DifferenceAmountIncl.VAT"; Decimal)
        {
            Caption = 'Total Difference Amount Incl. VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".DifferenceAmountInclVAT where("Contract ID" = field("Contract ID")));
        }
        field(50125; "Payment Type"; Text[250])
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
        }
        field(50126; "Tenant ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(50127; "Unit Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Type';
        }
    }
    keys
    {
        key(PK; "Contract ID", "Entry No")
        {
            Clustered = true;
        }
    }
}