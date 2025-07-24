table 50928 "Management Fee MasterData"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Vendor ID";
    fields
    {
        field(50100; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor ID';
            Editable = false;
        }
        field(50101; "Property ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property ID';
            Editable = false;
        }
        field(50102; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Name';
        }
        field(50103; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';
        }
        field(50104; "Property Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Type';
        }
        field(50105; "Calculation Method"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Calculation Method';
            TableRelation = "Calculation Type"."Calculation Type";
        }
        field(50106; "Percentage Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage Type';
            OptionMembers = " ","Fixed","Variable";
        }
        field(50108; "Base Amount"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Base Amount';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
        }
        field(50109; "Frequency Of Payment"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Frequency Of Payment';
            OptionMembers = " ","Monthly","Quaterly","Half Yearly","Yearly";
        }
        field(50110; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }
        field(50111; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }
        field(50112; "Contract Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Status';
            OptionMembers = " ","Active","Terminate";
        }
        field(50113; "Company ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Company ID';
            Editable = false;
        }
        field(50114; "Percentage"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage';
        }
        field(50115; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
    }
    keys
    {
        key(PK; "Vendor ID", "Vendor Name", "Property ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Vendor ID", "Vendor Name", "Property ID")
        {
        }
    }
}
