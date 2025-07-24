table 50706 "finalPaymentApproval"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = SystemId, "ID";

    fields
    {
        field(50101; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            Editable = true;
            AutoIncrement = true;
        }
        field(50108; "Status"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(50107; "Tenant ID"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(50119; "Tenant Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Name';
        }
        field(50104; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }

        field(50113; "Total Amount"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Amount';
        }
        field(50121; "Payment transaction ID"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment transaction ID';
        }
        field(50118; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }
        field(50117; "Payment Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Date';
        }
        field(50112; "Payment Mode"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Mode';
        }
        Field(50110; "Description"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
            Editable = true;
        }
    }

    keys
    {
        key(PrimaryKey; "ID")
        {
            Clustered = false;
        }
        key(PK; SystemId)
        {
            Clustered = true;
        }
    }



}

