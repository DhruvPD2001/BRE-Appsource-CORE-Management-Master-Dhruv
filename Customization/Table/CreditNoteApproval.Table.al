table 50957 "Credit Note Approval"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            Editable = false;
        }
        field(50101; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(50102; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(50103; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';
        }
        field(50104; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';
        }
        field(50106; "Credit Note Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note Amount';
        }
        field(50116; "Tenant Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Name';
        }
        field(50117; "Credit Note Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note Type';
            OptionMembers = " ","Standard Credit Note","Termination Credit Note";
        }
        field(50121; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            OptionMembers = "Pending","Approved","Reject";
        }
        field(50122; "FC ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'FC ID';
        }
    }
    keys
    {
        key(PK; "ID")
        {
            Clustered = false;
        }
    }
}
