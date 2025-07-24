table 50707 "finalcalculation_refunApproval"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = SystemId, "ID";

    fields
    {
        field(50101; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            Editable = false;
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

        field(50118; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }

        field(50112; "Account Number"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Account Number';
        }
        field(50120; "Account Holder Name"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Account Holder Name';
        }
        field(50114; "Swift Code"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Swift Code';
        }

        field(50121; "IBAN number"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'IBAN number';
        }
        field(50115; "Bank Name"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Name';
        }
        field(50116; "Branch Address"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Branch Name';
        }
        Field(50110; "Description"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';

        }
        Field(50124; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Request Date';

        }
        Field(50125; "fcID"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'fcID';

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

