table 50914 "Revenue Structure Subpage"
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
        field(50105; "Yearly No. of Installment"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Yearly No. of Instalment';
            Editable = true;
        }
        field(50106; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50107; "RS ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'RS ID';
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
            CalcFormula = sum("Revenue Structure Subpage"."Final Annual Amount" where("Contract ID" = field("Contract Id"), "RS ID" = field("RS ID")));
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
            Caption = 'VAT Amount';
        }
        field(50114; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
        }
        field(50115; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item Type';
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
    }
    keys
    {
        key(Key1; "Entry No.", "RS ID")
        {
            Clustered = true;
        }
    }
}
tableextension 50105 RevenueStructureSubpageExt extends "Revenue Structure Subpage"
{
    trigger OnDelete()
    var
        calculateinstallmentstotal: Codeunit CalculateNumberOfInstallments;
    begin
        calculateinstallmentstotal.BeforeDeleteCalculateInstallments(Rec);
    end;
}
