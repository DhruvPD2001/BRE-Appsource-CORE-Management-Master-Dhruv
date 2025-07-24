table 50955 "Invoice-Credit Note"
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

        field(50103; "Invoice ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice ID';
        }
        field(50104; "Item Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Name';
        }
        field(50105; "Item Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Amount';
        }
        field(50106; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            OptionMembers = " ","Complete","Partial";
        }
        field(50107; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(50108; "Remark"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Remark';
        }
        field(50109; "Reference"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reference';
        }
        field(50110; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }


    }


    keys
    {
        key(PK; "Entry No.", "ID")
        {
            Clustered = true;
        }
    }
}
