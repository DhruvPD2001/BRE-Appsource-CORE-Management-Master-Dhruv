tableextension 50504 "Sales Invoice Header Ext" extends "Sales Invoice Header"
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
        field(50110; "Reason For Rejection"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reason For Rejection';
        }
        field(50111; "View Invoice"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Invoice';
        }
        field(50112; "View Document URL"; Text[250])
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
    }
    trigger OnAfterInsert()
    var
        paymentschedule2: Record "Payment Schedule2";
        additionalcharges: Record "Additional Charges Sub";
        billingcalculationgrid: Record "Final Billing Calculation Grid";
    begin
        paymentschedule2.SetRange("Contract ID", Rec."Contract ID");
        paymentschedule2.SetRange("Invoice ID", Rec."Pre-Assigned No.");
        if paymentschedule2.FindSet() then
            repeat
                paymentschedule2."Invoice ID" := Rec."No.";
                paymentschedule2.Modify();
            until paymentschedule2.Next() = 0;

        additionalcharges.SetRange("Contract ID", Rec."Contract ID");
        additionalcharges.SetRange("Invoiced ID", Rec."Pre-Assigned No.");
        if additionalcharges.FindSet() then
            repeat
                additionalcharges."Invoiced ID" := Rec."No.";
                additionalcharges."Posted Invoice ID" := Rec."No.";
                additionalcharges."Invoice Document" := Rec."View Invoice";
                additionalcharges."Invoice Document URL" := Rec."View Document URL";
                additionalcharges.Modify();
            until additionalcharges.Next() = 0;

        billingcalculationgrid.SetRange("Contract ID", Rec."Contract ID");
        billingcalculationgrid.SetRange("Invoice ID", Rec."Pre-Assigned No.");
        if billingcalculationgrid.FindSet() then
            repeat
                billingcalculationgrid."Invoice ID" := Rec."No.";
                billingcalculationgrid."Posted Invoice ID" := Rec."No.";
                billingcalculationgrid."Invoice Document" := Rec."View Invoice";
                billingcalculationgrid."Invoice Document URL" := Rec."View Document URL";
                billingcalculationgrid.Modify();
            until billingcalculationgrid.Next() = 0;
    end;
}