table 50945 "Final Revenue Calculation Grid"
{
    DataClassification = ToBeClassified;
    Caption = 'Final Revenue Calculation Grid';
    fields
    {
        field(50100; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(50101; "Revenue Description"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Revenue Description';
        }
        field(50102; "Original Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            DecimalPlaces = 2 : 2;
        }
        field(50103; "Original VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT';
            DecimalPlaces = 2 : 2;
        }
        field(50104; "Original Amount Incl."; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount incl.';
            DecimalPlaces = 2 : 2;
        }
        field(50105; "Revised Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revised Amount';
            DecimalPlaces = 2 : 2;
        }
        field(50106; "Revised VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revised VAT';
            DecimalPlaces = 2 : 2;
        }
        field(50108; "Revised Amount Incl."; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revised Amount Incl.';
            DecimalPlaces = 2 : 2;
        }
        field(50109; "Difference Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Difference Amount';
            DecimalPlaces = 2 : 2;
        }
        field(50110; "Difference VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Difference VAT';
            DecimalPlaces = 2 : 2;
        }
        field(50111; "Difference Amount Incl."; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Difference Amount Incl.';
            DecimalPlaces = 2 : 2;
        }
        field(50112; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50113; "Actual Contract Tenure"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Actual Contract Tenure';
        }
        field(50114; "Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Per Day Rent';
        }
        field(50115; "Revised VAT %"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revised VAT %';
        }
        field(50116; "ContractYear(Termination Date)"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Year On Termination Date';
        }
        field(50117; "Annual Rent Amount TermiYear"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Annual Rent Amount of Termination Year';
        }
        field(50118; "Total No. Of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total No. Of Days(Termination Year)';
        }
        field(50119; "Total Original Amount"; Decimal)
        {
            Caption = 'Total Original Amount';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Final Revenue Calculation Grid"."Original Amount" where("Contract ID" = field("Contract ID")));
        }
        field(50120; "Total Original VAT"; Decimal)
        {
            Caption = 'Total Original VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Final Revenue Calculation Grid"."Original VAT" where("Contract ID" = field("Contract ID")));
        }
        field(50121; "Total Orgininal AmountIncl.VAT"; Decimal)
        {
            Caption = 'Total Orgininal Amount Incl. VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Revenue Calculation Grid"."Original Amount Incl." where("Contract ID" = field("Contract ID")));
        }
        field(50122; "Total Revised Amount"; Decimal)
        {
            Caption = 'Total Revised Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Revenue Calculation Grid"."Revised Amount" where("Contract ID" = field("Contract ID")));
        }
        field(50123; "Total Revised VAT"; Decimal)
        {
            Caption = 'Total Revised VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Revenue Calculation Grid"."Revised VAT" where("Contract ID" = field("Contract ID")));
        }
        field(50124; "Total Revised AmountIncl.VAT"; Decimal)
        {
            Caption = 'Total Revised Amount Incl. VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Revenue Calculation Grid"."Revised Amount Incl." where("Contract ID" = field("Contract ID")));
        }
        field(50125; "Total Difference Amount"; Decimal)
        {
            Caption = 'Total Difference Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Revenue Calculation Grid"."Difference Amount" where("Contract ID" = field("Contract ID")));
        }
        field(50126; "Total Difference VAT"; Decimal)
        {
            Caption = 'Total Difference VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Revenue Calculation Grid"."Difference VAT" where("Contract ID" = field("Contract ID")));
        }
        field(50127; "Total DifferenceAmountIncl.VAT"; Decimal)
        {
            Caption = 'Total Difference Amount Incl. VAT"';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Revenue Calculation Grid"."Difference Amount Incl." where("Contract ID" = field("Contract ID")));
        }
        field(50128; "Payment Type"; Text[250])
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Contract ID", "Entry No.")
        {
            Clustered = true;
        }
    }
}