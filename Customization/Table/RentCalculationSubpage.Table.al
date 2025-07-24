table 50943 "Rent Calculation Subpage"
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
        }
        field(50105; "Yearly No. of Installment"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Yearly No. of Instalment';
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
        field(50110; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Rent Calculation Subpage"."Final Annual Amount" where("Contract ID" = field("Contract Id"), "RC ID" = field("RC ID")));
        }
        field(50111; "Link"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Update Data';
            InitValue = 'Update Data';
        }
        field(50113; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50115; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50116; "VAT %"; Option)
        {
            OptionMembers = "0","5";
            Caption = 'VAT %';
            Editable = false;
        }
        field(50117; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(50118; "Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Per Day Rent';
        }
        field(50119; "Propety Classification"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Proeprty Classifcation';
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
