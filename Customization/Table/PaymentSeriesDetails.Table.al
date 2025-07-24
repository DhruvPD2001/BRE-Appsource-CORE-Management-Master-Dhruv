table 50511 "Payment Series Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50501; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50502; "payment Series"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';
        }
        field(50503; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(50504; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }

        field(50505; "Payment Mode"; Text[100])
        {

            TableRelation = "Payment Type"."Payment Method";
            Caption = 'Payment Mode';
        }

        field(50506; "Cheque Number"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Number';
        }
        field(50507; "Deposite Bank"; Code[100])
        {
            Caption = 'Deposite Bank';
            TableRelation = "Bank Account"."No.";
        }
        field(50508; "Deposite Status"; Option)
        {
            OptionMembers = "-","N","Y";
            Caption = 'Deposit Status';
        }
        field(50509; "Payment Status"; Enum "Payment Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Status';
        }
        field(50510; "Cheque Status"; Enum "PDC Status Type Enum")
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Status';
        }
        field(50511; "Old Cheque"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Old Cheque';
        }
        field(50512; "View"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'View';
            InitValue = 'View';
        }
        field(50513; "View Document URL"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Document URL';
        }

        field(50514; "Approval Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50515; "Payment Transaction Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50516; "Contract Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50517; "Tenant Id"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

}