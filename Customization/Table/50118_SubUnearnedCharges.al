table 50118 "Sub Unearned Charges"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
            Editable = false;
        }
        field(50101; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }

        field(50102; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';
        }

        field(50103; "Unit Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Name';
        }

        field(50104; "Property"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property';
        }

        field(50105; "Owner Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner Name';
        }

        field(50106; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }

        field(50107; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }

        field(50108; "Termination Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Termination Date';
        }

        field(50109; "Suspension Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Suspension Date';
        }

        field(50110; "Other Charges Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Charges Value';
        }

        field(50111; "Contract Status"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Status';
        }

        field(50112; "Opening Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Opening Balance';
        }
        field(50113; "Invoice Raised During the Year"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice Raised During the Year';
        }
        field(50114; "RevenueAllocated DuringtheYear"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revenue Allocated During the Year';
        }
        field(50115; "Unearned Revenue Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Unearned Revenue Balance';
        }
        field(50116; "CalculatedUnearnedRevBalance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Calculated Unearned Revenue Balance';
        }
        field(50117; "Shortfall/Excess"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Shortfall/Excess';
        }
        field(50118; "Header No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Header No.';
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Header No.", "Line No.")
        {
            Clustered = true;
        }

    }
}