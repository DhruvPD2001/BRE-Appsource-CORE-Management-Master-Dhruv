table 50905 "Revenue Calculate Sub"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(50112; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }

        field(50101; "RS ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }

        field(50102; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item Type';
            Editable = false;
        }

        field(50103; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            Editable = false;
        }

        field(50104; "Installment Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment Start Date';
            Editable = false;
        }

        field(50105; "Installment End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment End Date';
            Editable = false;
        }

        field(50106; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
            Editable = false;
        }

        field(50107; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
            Editable = false;
        }

        field(50109; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
            Editable = false;
        }


        field(50110; "Total Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Revenue Calculate Sub"."Amount" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }

        field(50111; "Total VAT Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Revenue Calculate Sub"."VAT Amount" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }

        field(50113; "Total Amount Including VAT"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Revenue Calculate Sub"."Amount Including VAT" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }

    }
    keys
    {
        key(PK; "RS ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Contract ID")
        {

        }
    }

}





