table 50904 "Rent Calculate Sub"
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

        field(50101; "Period Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
            Editable = false;
        }
        field(50102; "Period End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
            Editable = false;
        }

        field(50103; "Number of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Number of Days';
            Editable = false;
        }
        field(50104; "Final Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Annual Amount';
            Editable = true;
        }

        field(50105; "Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Per Day Rent';
            Editable = false;
        }

        field(50106; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(50107; "RC ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'RC ID';

        }

        field(50109; "Tenant Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';

        }

        field(50117; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';

        }

        field(50118; "Total Number of Days"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Rent Calculate Sub"."Number of Days" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }


        field(50119; "Total Final Annual Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Rent Calculate Sub"."Final Annual Amount" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }
    }

    keys
    {
        key(Key1; "Entry No.", "RC ID")
        {
            Clustered = true;
        }
    }

}





