table 50934 "Payment Schedule2"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item Type';
            trigger OnValidate()
            begin
                if "Secondary Item Type" = 'Security Deposit Amount' then
                    UpdateBalanceAmountOnPaymentReceived();
            end;
        }
        field(50101; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(50102; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
        }
        field(50103; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
            trigger OnValidate()
            begin
                UpdateBalanceAmountOnPaymentReceived();
            end;
        }
        field(50104; "Installment Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment Start Date';
        }
        field(50105; "Installment End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment End Date';
        }
        field(50106; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }
        field(50107; "Installment No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment No.';
        }
        field(50116; "Payment Series"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';
        }
        field(50108; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50110; "Tenant ID"; Code[20])
        {
            Caption = 'Tenant ID';
        }
        field(50111; "Tenant Name"; Text[100])
        {
            Caption = 'Tenant Name';
        }
        field(50915; "Invoiced"; Boolean)
        {
            Caption = 'Invoiced';
        }
        field(50914; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
        }
        field(50916; "Payment Status"; Text[100])
        {
            Caption = 'Payment Status';
            trigger OnValidate()
            begin
                if "Payment Status" = 'Received' then
                    UpdateBalanceAmountOnPaymentReceived();
            end;
        }
        field(50917; "Property Classification"; Text[100])
        {
            Caption = 'Property Classification';
            DataClassification = ToBeClassified;
        }
        field(50918; "Contract Status"; Text[100])
        {
            Caption = 'Contract Status';
            DataClassification = ToBeClassified;
        }
        field(50919; "Invoice ID"; Code[50])
        {
            Caption = 'Invoice ID';
            DataClassification = ToBeClassified;
        }
        field(50920; "Overdue Invoice"; Text[20])
        {
            Caption = 'Overdue Invoice';
            DataClassification = ToBeClassified;
        }
        field(50921; "Payment Recieved Date"; Date)
        {
            Caption = 'Payment Recived Date';
            DataClassification = ToBeClassified;
        }
        field(50922; "Payment Mode"; Text[100])
        {
            Caption = 'Payment Mode';
        }
        field(50923; "Cheque Number"; Text[100])
        {
            Caption = 'Cheque Number';
        }
        field(50924; "Contract start date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start date';
        }
        field(50925; "Property ID"; Code[40])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property ID';
        }
        field(50926; "No of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No of Days';
        }
        field(50927; "Workflow frequency date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Workflow Frequency Date';
        }
        field(50928; "VAT%"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT%';
        }
        field(50929; "Credit Note No."; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note No.';
        }
        field(50930; "Credit Note Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note Amount';
        }
        field(50931; "Final Rent Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Rent Amount';
        }
        field(50932; "Final RentAmountIncludingVAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Rent Amount Including VAT';
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Secondary Item Type", "Amount", "VAT Amount", "Amount Including VAT")
        {
            Caption = 'Payment Schedule';
        }
    }
    local procedure UpdateBalanceAmountOnPaymentReceived()
    var
        TenancyContractRec: Record "Tenancy Contract";
    begin
        TenancyContractRec.SetRange("Contract ID", Rec."Contract ID");
        if TenancyContractRec.FindSet() then
            if (Rec."Secondary Item Type" = 'Security Deposit Amount') and
     (Rec."Payment Status" = 'Received') then begin
                if TenancyContractRec."Balance Amount" <> 0 then begin
                    TenancyContractRec."Balance Amount" += Rec."Amount Including VAT";
                    TenancyContractRec."Security Balanced Amount" += Rec."Amount Including VAT";
                end
                else begin
                    TenancyContractRec."Balance Amount" := Rec."Amount Including VAT";
                    TenancyContractRec."Security Balanced Amount" := Rec."Amount Including VAT";
                end;
                TenancyContractRec.Modify();
            end;
    end;
}
