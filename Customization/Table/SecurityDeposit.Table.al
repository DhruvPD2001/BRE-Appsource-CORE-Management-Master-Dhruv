table 50319 "Security Deposit"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Security Deposit ID";

    fields
    {
        field(50100; "Security Deposit ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Security Deposit ID';
            AutoIncrement = true;
        }
        field(50103; "Tenant Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Full Name';
            TableRelation = Customer.Name;

            trigger OnLookup()
            var
                CustomerRec: Record Customer;
            begin
                if PAGE.RunModal(PAGE::"Customer List", CustomerRec) = ACTION::LookupOK then
                    "Tenant Full Name" := CustomerRec.Name;
            end;

            trigger OnValidate()
            var
                CustomerRec: Record Customer;
            begin
                if "Tenant Full Name" <> '' then begin
                    CustomerRec.SetRange(Name, "Tenant Full Name");
                    if CustomerRec.IsEmpty() then
                        Error('The selected tenant does not exist in the Customer table.');
                end;
            end;
        }
        field(50102; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
            TableRelation = "Tenancy Contract"."Contract ID";
        }
        field(50104; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';
        }
        field(50105; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';
        }

        field(50106; "Security Deposit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Security Deposit Amount';

            trigger OnValidate()
            begin
                UpdateAdjustedAmount();
            end;
        }

        field(50107; "New_Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Contract ID';
            TableRelation = "Tenancy Contract"."Contract ID";
        }

        field(50108; "New_Tenant Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'New Tenant Full Name';
        }

        field(50109; "New_Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Contract Start Date';
        }

        field(50110; "New_Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Contract End Date';
        }

        field(50111; "Carry Forward Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Enter Amount';

            trigger OnValidate()
            begin
                UpdateAdjustedAmount();
            end;
        }

        field(50112; "Security Deposit Amt. Pending"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Security Deposit Amount Pending';
            Editable = false; // Make it non-editable since it's auto-calculated
        }

        field(50113; "Narration"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Narration';
        }
        field(50176; "Balance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Available Security Deposit Amount';
        }

        field(50177; "New Security Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Security Deposit Amount';

        }

        field(50178; "Security Deposit Amt. Received"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Security Deposit Amount Received';
        }
        field(50179; "Property Classification"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Classification';
            tableRelation = "Tenancy Contract"."Property Classification";
        }
    }



    keys
    {
        key(PK; "Security Deposit ID", "Tenant Full Name")
        {
            Clustered = true;
        }
    }
    local procedure UpdateAdjustedAmount()
    var
        TenancyContractRec: Record "Tenancy Contract";
        tenancyContractSubPage: Record "Tenancy Contract Subpage";
    begin
        if "Balance Amount" > "Carry Forward Amount" then begin
            "Balance Amount" := "Balance Amount" - "Carry Forward Amount";
            "Security Deposit Amt. Received" += "Carry Forward Amount";
            "Security Deposit Amt. Pending" := "New Security Amount" - "Security Deposit Amt. Received";
        end else
            "Balance Amount" := 0;

        TenancyContractRec.SetRange("Contract ID", "Contract ID");
        if TenancyContractRec.FindFirst() then begin
            TenancyContractRec."Security Balanced Amount" := "Balance Amount";
            TenancyContractRec.Modify();
        end;

        TenancyContractRec.SetRange("Contract ID", "New_Contract ID");
        if TenancyContractRec.FindFirst() then begin
            TenancyContractRec."Security Deposit Amt. Received" := "Security Deposit Amt. Received";
            TenancyContractRec."Security Balanced Amount" := "Security Deposit Amt. Received";
            TenancyContractRec."Security Amount Pending" := "Security Deposit Amt. Pending";  // Update the Balance Amount
            TenancyContractRec.IsCarryForwarded := true; // Mark as carry forward
            TenancyContractRec.Modify(); // Save the record

            tenancyContractSubPage.SetRange(ContractID, TenancyContractRec."Contract ID");
            tenancyContractSubPage.SetRange("Secondary Item Type", 'Security Deposit Amount');
            if tenancyContractSubPage.FindSet() then begin
                tenancyContractSubPage.Amount := TenancyContractRec."Security Deposit Amount" - TenancyContractRec."Security Deposit Amt. Received";
                tenancyContractSubPage.Validate(Amount);
                tenancyContractSubPage.Modify();
            end;
        end;
    end;
}
