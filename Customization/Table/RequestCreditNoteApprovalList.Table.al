table 50969 "RequestCreditNoteApprovalList"
{
    Caption = 'Request Credit Note Approval List';
    DataClassification = ToBeClassified;
    fields
    {
        field(50970; "Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Request No.';
        }
        field(50971; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(50973; "Tenant No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant No.';
        }
        field(50974; "Total Rent Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Rent Amount';
        }
        field(50975; "Total Reduction Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Reduction Amount';
        }
        field(50976; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Request Date';
        }
        field(50977; "Status"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(50978; Remark; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remark';
        }
        field(50979; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            AutoIncrement = true;
        }

    }
}