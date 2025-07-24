table 50958 "Billing Calculation CN"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50101; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(50102; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(50103; "Item"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item';
        }
        field(50104; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(50105; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
        }
        field(50106; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
        }
        field(50107; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(50108; "VAT %"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT %';
        }
        field(50109; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Billing Calculation CN"."Amount Including VAT" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }
        field(50110; "Credit Note ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note ID';
        }
    }
    keys
    {
        key(PK; "Entry No.", "Contract ID")
        {
            Clustered = true;
        }
    }
}
