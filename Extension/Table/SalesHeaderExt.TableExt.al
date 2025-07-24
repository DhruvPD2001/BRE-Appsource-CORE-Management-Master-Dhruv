tableextension 50502 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50101; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(50102; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';
        }
        field(50103; "Unit Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Name';
        }
        field(50104; "Contract Tenure"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Tenure';
        }
        field(50105; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Approved,Rejected;
            Caption = 'Approval Status';
        }
        field(50106; "Tenant Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Name';
        }
        field(50107; "Customer P.O"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer P.O';
        }
        field(50108; "Customer P.O Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer P.O Date';
        }
        field(50109; "Contract Period"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Period';
        }
        field(50110; "Reason for Rejection"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reason for Rejection';
        }
        field(50111; "View Invoice"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Invoice';
        }
        field(50112; "View Document URL"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Document URL';
        }
        field(50113; "Overdue Invoice"; Text[20])
        {
            Caption = 'Overdue Invoice';
            DataClassification = ToBeClassified;
        }
        field(50114; "FC ID"; Integer)
        {
            Caption = 'FC ID';
            DataClassification = ToBeClassified;
        }
        field(50115; "Property Classification"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Classification';
        }
        field(50116; "Approval Status for CreditNote"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Status';
            OptionMembers = " ",Approved,Rejected;
        }
        field(50117; "Rejection Reason CreditNote"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rejection Reason';
        }
        field(50118; "Credit Memo Document"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Memo ID';
        }
        field(50119; "Credit Memo URL"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Memo No';
        }
        field(50120; "Contract Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount';
        }
        field(50121; "Terminated Credit Note"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Terminated Credit Note';
        }
    }
}
