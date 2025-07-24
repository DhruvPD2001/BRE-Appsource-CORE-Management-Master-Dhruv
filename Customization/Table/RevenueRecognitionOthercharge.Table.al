table 50959 "RevenueRecognition Othercharge"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50109; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(50102; "RS Id"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'RS Id';
        }
        field(50100; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tenancy Contract"."Contract ID";
            Editable = false;
        }
        field(50101; "Tenant Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Id';
            TableRelation = "Tenancy Contract"."Tenant ID";
            Editable = false;
        }
        field(50103; "Month"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Month';
            Editable = false;
        }
        field(50104; "No. of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No. of Days';
            Editable = false;
        }
        field(50105; "RR - Method 1 (Day)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'RR - Method 1 (Day)';
            Editable = false;
        }
        field(50106; "RR - Method 2 (Month)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'RR - Method 2 (Month)';
            Editable = false;
        }
        field(50107; "Total Amount(Day)"; Decimal)
        {
            Caption = 'Total Amount(Day)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("RevenueRecognition Othercharge"."RR - Method 1 (Day)" where("Contract ID" = field("Contract ID")));
        }
        field(50108; "Total Amount(Month)"; Decimal)
        {
            Caption = 'Total Amount(Month)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("RevenueRecognition Othercharge"."RR - Method 2 (Month)" where("Contract ID" = field("Contract ID")));
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
