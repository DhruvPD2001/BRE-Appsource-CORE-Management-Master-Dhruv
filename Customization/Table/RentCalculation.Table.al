table 50942 "Rent Calculation"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50112; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
            TableRelation = "Tenancy Contract"."Contract ID";
        }
        field(50101; "RC ID"; Integer)
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
        field(50104; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';
            Editable = false;
        }
        field(50105; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';
            Editable = false;
        }
        field(50106; "Number of Installments"; Integer)
        {
            Caption = 'Number of Installments';
        }
        field(50107; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
            Editable = false;
        }
        field(50108; "Amount Including VAT"; Decimal)
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
            TableRelation = "Lease Proposal Details"."Tenant ID";
        }
        field(50110; "Rent Calculation Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rent Calculation Type';
            Editable = false;
        }
        field(50111; "VAT %"; Option)
        {
            OptionMembers = "0","5";
            Caption = 'VAT %';
            Editable = false;
        }
        field(50912; "Property Classification"; Text[100])
        {
            Caption = 'Property Classification';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "RC ID")
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
    trigger OnDelete()
    var
    begin
        deletepaymentschedule();
        deleterevenuestructuresubpag1();
    end;

    procedure deletepaymentschedule()
    var
        paymentschedule: Record "Rent Calculation Subpage";
    begin
        paymentschedule.SetRange("Contract Id", Rec."Contract ID");
        paymentschedule.SetRange("RC ID", Rec."RC ID");
        if paymentschedule.FindSet() then
            paymentschedule.DeleteAll();
    end;

    procedure deleterevenuestructuresubpag1()
    var
        revenuestructuresubpage1: Record "Rent Calculation Subpage2";
    begin
        revenuestructuresubpage1.SetRange("Contract ID", Rec."Contract ID");
        revenuestructuresubpage1.SetRange("RC ID", Rec."RC ID");
        if revenuestructuresubpage1.FindSet() then
            revenuestructuresubpage1.DeleteAll();
    end;
}
