table 50915 "Split Payment Change"
{
    DataClassification = ToBeClassified;
    fields
    {

        field(50100; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';

        }
        field(50101; "Split Payment Series"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50102; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Split Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50104; "Split Payment Mode"; Text[150])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Type"."Payment Method";
        }

        field(50105; "Split Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50106; "Split VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50107; "Split Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50108; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50109; "Tenant Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';

        }
    }

    keys
    {
        key(Key1; "Entry No.", "Contract ID")
        {
            Clustered = true;
        }
    }


}