table 50946 "Final Billing Calculation Grid"
{
    DataClassification = ToBeClassified;
    Caption = 'Final Billing Calculation Grid';
    fields
    {
        field(50100; RevenueDescription; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Revenue Description';
        }
        field(50101; InvoicedAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoiced Amount';
        }
        field(50102; InvoicedVAT; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoiced VAT';
        }
        field(50103; InvoicedAmountInclVAT; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoiced Amount Incl. VAT';
        }
        field(50104; RevisedAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revised Amount';
        }
        field(50105; RevisedVAT; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revised VAT';
        }
        field(50106; RevisedAmountInclVAT; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revised Amount Incl. VAT';
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
        field(50113; "Total Invoiced Amount"; Decimal)
        {
            Caption = 'Total Invoiced Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Final Billing Calculation Grid"."InvoicedAmount" where("Contract ID" = field("Contract ID")));
        }
        field(50114; "Total Invoiced VAT"; Decimal)
        {
            Caption = 'Total Invoiced VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Final Billing Calculation Grid"."InvoicedVAT" where("Contract ID" = field("Contract ID")));
        }
        field(50115; "Total Invoiced AmountIncl. VAT"; Decimal)
        {
            Caption = 'Total Invoiced AmountIncl. VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Final Billing Calculation Grid"."InvoicedAmountInclVAT" where("Contract ID" = field("Contract ID")));
        }
        field(50116; "Total Revised Amount"; Decimal)
        {
            Caption = 'Total Revised Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Billing Calculation Grid"."RevisedAmount" where("Contract ID" = field("Contract ID")));
        }
        field(50117; "Total Revised VAT"; Decimal)
        {
            Caption = 'Total Revised VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Billing Calculation Grid"."RevisedVAT" where("Contract ID" = field("Contract ID")));
        }
        field(50118; "Total Revised AmountIncl.VAT"; Decimal)
        {
            Caption = 'Total Revised AmountIncl. VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Billing Calculation Grid"."RevisedAmountInclVAT" where("Contract ID" = field("Contract ID")));
        }
        field(50119; "Total Differnece Amount"; Decimal)
        {
            Caption = 'Total Difference Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Final Billing Calculation Grid"."DifferenceAmount" where("Contract ID" = field("Contract ID")));
        }
        field(50120; "Total Difference VAT"; Decimal)
        {
            Caption = 'Total Invoiced Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Final Billing Calculation Grid"."DifferenceVAT" where("Contract ID" = field("Contract ID")));
        }
        field(50121; "Total DifferenceAmountIncl.VAT"; Decimal)
        {
            Caption = 'Total Difference Amount Incl. VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Final Billing Calculation Grid"."DifferenceAmountInclVAT" where("Contract ID" = field("Contract ID")));
        }
        field(50122; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
            DataClassification = ToBeClassified;
        }
        field(50123; "Invoice To Be Raised"; Decimal)
        {
            Caption = 'Invoice To Be Raised';
            DataClassification = ToBeClassified;
        }
        field(50124; "Credit Note To Be Raised"; Decimal)
        {
            Caption = 'Credit To Be Raised';
            DataClassification = ToBeClassified;
        }
        field(50125; "Payment Type"; Text[250])
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
        }
        field(50126; "Property Classification"; Text[20])
        {
            Caption = 'Property Classification';
            DataClassification = ToBeClassified;
        }
        field(50127; "Invoiced"; Boolean)
        {
            Caption = 'Invoiced';
            DataClassification = ToBeClassified;
        }
        field(50128; "Tenant ID"; Code[50])
        {
            Caption = 'Tenant ID';
            DataClassification = ToBeClassified;
        }
        field(50129; "Invoice ID"; Text[20])
        {
            Caption = 'Invoice ID';
            DataClassification = ToBeClassified;
        }
        field(50130; "Posted Invoice ID"; Code[20])
        {
            Caption = 'Posted Invoice ID';
            DataClassification = ToBeClassified;
        }
        field(50131; "Invoice Document"; Text[250])
        {
            Caption = 'Invoice Document';
            DataClassification = ToBeClassified;
        }
        field(50132; "Invoice Document URL"; Text[250])
        {
            Caption = 'Invoice Document URL';
            DataClassification = ToBeClassified;
        }
        field(50133; "VAT %"; Integer)
        {
            Caption = 'VAT %';
            DataClassification = ToBeClassified;
        }
        field(50134; "Creditnote"; Boolean)
        {
            Caption = 'Creditnote';
            DataClassification = ToBeClassified;
        }
        field(50135; "Credit Note Amount"; Decimal)
        {
            Caption = 'Credit Note Amount';
            DataClassification = ToBeClassified;
        }
        field(50136; "Invoice Amount"; Decimal)
        {
            Caption = 'Invoice Amount';
            DataClassification = ToBeClassified;
        }
        field(50137; "Credit Note ID"; Code[1000])
        {
            Caption = 'Credit Note ID';
            DataClassification = ToBeClassified;
        }
        field(50138; "Credit Note Document"; Text[250])
        {
            Caption = 'Credit Note Document';
            DataClassification = ToBeClassified;
        }
        field(50139; "Credit Note Document URL"; Text[250])
        {
            Caption = 'Credit Note Document URL';
            DataClassification = ToBeClassified;
        }
        field(50140; "Line"; Code[50])
        {
            Caption = 'Credit Note Posted ID';
            DataClassification = ToBeClassified;
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