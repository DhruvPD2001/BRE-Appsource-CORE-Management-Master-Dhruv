table 50704 "ContractEndProcessApproval"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = SystemId, "ID";

    fields
    {
        field(50101; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            // Editable = false;
            AutoIncrement = true;
        }
        field(50102; "Property_M Status"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Manager Approval Status';
            //Editable = false;
        }
        field(50111; "Lease_M Status"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lease Manager Approval Status';



        }
        field(50103; "Contract Id"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Id';
            //Editable = false;
        }
        field(50104; "Tenant Id"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Id';
            //Editable = false;
        }
        field(50105; "Tenant Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Name';
            //Editable = false;
        }
        field(50106; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';
            // Editable = false;
        }
        field(50107; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';
            // Editable = false;
        }
        field(50108; "Tenant Email"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Email';
            // Editable = false;
        }

        field(50109; "Lease Manager Remark"; Text[400])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lease Manager Remark';
            //Editable = false;
        }
        field(50110; "Property Manager Remark"; Text[400])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Manager Remark';
            //Editable = false;
        }

        field(50112; "Value"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Value';
            //Editable = false;
        }

        field(50113; "Renewal Notification to Tenant"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal Notification to Tenant';
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