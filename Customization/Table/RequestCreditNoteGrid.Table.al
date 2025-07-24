table 50968 "Request Credit Note Grid"
{
    DataClassification = ToBeClassified;
    Caption = 'Request Credit Note Grid';
    fields
    {
        field(50958; "Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Request No.';
        }
        field(50960; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(50961; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';
        }
        field(50962; "Tenant No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant No.';
        }
        field(50963; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';
        }
        field(50964; "Payment Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';
        }
        field(50974; "Current Charges Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Current Rent Amount';
        }
        field(50972; "Total Reduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Reduction';
        }
        field(50965; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(50966; "Credit Note No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note No.';
        }
        field(50967; "Total Pay Rent Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Pay Rent Amount';
        }
        field(50968; "Property Classification"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Classification';
        }
        field(50969; "Credit Memo Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Memo Generated';
        }
        field(50970; "Secondary Item Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item Type';
        }
        field(50971; Charges; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Charges';
        }
    }
    keys
    {
        key(Key1; "Line No.", "Request No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        requestcreditnote: Record "Request Credit Note";
    begin
        requestcreditnote.SetRange("Contract ID", Rec."Contract ID");
        if requestcreditnote.FindFirst() then begin
            Rec."Customer Name" := requestcreditnote."Customer Name";
            Rec."Tenant No." := requestcreditnote."Tenant No.";
            Rec."Property Classification" := requestcreditnote."Property Classification";
        end else
            Error('No Request Credit Note found for the specified Request No.');
    end;
}