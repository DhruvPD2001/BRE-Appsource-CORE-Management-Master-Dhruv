table 50916 "Revenue Structure Subpage1"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Year';
            Editable = false;
        }
        field(50101; "Installment No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment No.';
            Editable = false;
        }
        field(50102; "Installment Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment Start Date';
            Editable = false;
        }
        field(50103; "Installment End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment End Date';
            Editable = false;
        }
        field(50104; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
            Editable = false;
        }
        field(50105; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            Editable = false;
        }
        field(50107; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50108; "RS ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'RS ID';
        }
        field(50110; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
            Editable = false;
        }
        field(50116; "VAT %"; Integer)
        {
            Caption = 'VAT %';
            Editable = false;
        }
        field(50111; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
            Editable = false;
        }
        field(50112; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item Type';
            Editable = false;
        }
        field(50113; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(50115; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(50114; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Revenue Structure Subpage1".Amount where("RS ID" = field("RS ID")));
            DecimalPlaces = 0 : 0;
        }
    }
    keys
    {
        key(Key1; "Entry No.", "RS ID")
        {
            Clustered = true;
        }
    }
}
