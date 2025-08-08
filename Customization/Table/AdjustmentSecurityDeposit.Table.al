table 50111 "Adjustment Security Deposit"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = ID;
    fields
    {
        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(50101; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            TableRelation = "Tenancy Contract"."Contract ID";
            trigger OnValidate()
            var
                ContractRec: Record "Tenancy Contract";
                AdjustSecurityDeposit: Record "Adjustment Security Deposit";
            begin
                AdjustSecurityDeposit.Reset();
                AdjustSecurityDeposit.SetRange("Contract ID", Rec."Contract ID");
                if not AdjustSecurityDeposit.IsEmpty() then
                    Error('This Contract ID %1 is already used in another record.', Rec."Contract ID");
                ContractRec.SetRange("Contract ID", "Contract ID");
                if ContractRec.Get() then begin
                    Rec."Main Security Deposit" := ContractRec."Security Deposit Amount";
                    Rec."Security Deposit" := ContractRec."Security Balanced Amount";
                    Rec."Contract Start Date" := ContractRec."Contract Start Date";
                    Rec."Contract End Date" := ContractRec."Contract End Date";
                end;
            end;
        }
        field(50102; "Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Security Deposit';
            Editable = false;
        }
        field(50103; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
            Editable = false;
        }
        field(50104; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
            Editable = false;
        }
        field(50105; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,Approved';
            OptionMembers = Pending,Approved;
            Editable = false;
        }
        field(50106; "Security Amount Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Termination Charges';
            OptionMembers = "Termination Charges";
            Editable = false;
            trigger OnValidate()
            var
                TermChargesGrid: Record "Additional Charges Sub";
                TotalAmount: Decimal;
                TotalVATAmount: Decimal;
                TotalAmountInclVAT: Decimal;
            begin
                if Rec."Security Amount Status" = Rec."Security Amount Status"::"Termination Charges" then begin
                    if Rec."Contract ID" = 0 then
                        Error('Please select a Contract ID first');
                    Clear(TotalAmount);
                    Clear(TotalVATAmount);
                    Clear(TotalAmountInclVAT);
                    TermChargesGrid.Reset();
                    TermChargesGrid.SetRange("Contract ID", Rec."Contract ID");
                    if TermChargesGrid.FindSet() then begin
                        repeat
                            TotalAmount += TermChargesGrid.Amount;
                            TotalVATAmount += TermChargesGrid."VAT Amount";
                            TotalAmountInclVAT += TermChargesGrid."Amount Including VAT";
                        until TermChargesGrid.Next() = 0;
                        Rec.Amount := TotalAmount;
                        Rec."VAT Amount" := TotalVATAmount;
                        Rec."Amount Including VAT" := TotalAmountInclVAT;
                    end;
                end;
            end;
        }
        field(50107; "Payment Series"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';
        }
        field(50108; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(50109; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
        }
        field(50110; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
        }
        field(50111; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }
        field(50112; "Main Security Deposit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Main Security Deposit';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }
}
