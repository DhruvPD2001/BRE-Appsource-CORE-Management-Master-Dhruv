tableextension 50506 "Sales Cr. Memo Header Ext" extends "Sales Cr.Memo Header"
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

        field(50109; "Contract Period"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Period';
        }
        field(50111; "View Invoice"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Invoice';
        }
        field(50115; "Property Classification"; Text[40])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Classification';
        }
        field(50116; "Approval Status for CreditNote"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Approved,Rejected;
            Caption = 'Approval Status for CreditNote';
        }
        field(50117; "Rejection Reason CreditNote"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rejection Reason CreditNote';
        }
        field(50118; "Credit Memo Document"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Memo Document';
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

    trigger OnAfterInsert()
    var
        Requestcreditnotegrid: Record "Request Credit Note Grid";
        Requestcreditnotegrid1: Record "Request Credit Note Grid";
        Requestcreditnotegrid2: Record "Request Credit Note Grid";
        paymentmodegrid: Record "Payment Mode2";
        paymentschedulegrid: Record "Payment Schedule2";
    begin
        Requestcreditnotegrid.SetRange("Credit Note No.", "Pre-Assigned No.");
        Requestcreditnotegrid.SetRange("Contract ID", "Contract ID");
        Requestcreditnotegrid.SetRange("Credit Memo Generated", true);
        if Requestcreditnotegrid.FindSet() then
            repeat
                Requestcreditnotegrid."Credit Note No." := "No.";
                Requestcreditnotegrid.Modify();
            until Requestcreditnotegrid.Next() = 0;

        paymentmodegrid.SetRange("Contract ID", "Contract ID");
        if paymentmodegrid.FindSet() then
            repeat
                paymentmodegrid."Credit Note Amount" := 0;
                Requestcreditnotegrid1.SetRange("Contract ID", paymentmodegrid."Contract ID");
                Requestcreditnotegrid1.SetRange("Payment Series", paymentmodegrid."Payment Series");
                Requestcreditnotegrid1.SetRange("Credit Memo Generated", true);
                if Requestcreditnotegrid1.FindSet() then
                    repeat
                        paymentmodegrid."Credit Note No." := Requestcreditnotegrid1."Credit Note No.";
                        paymentmodegrid."Credit Note Amount" += Requestcreditnotegrid1."Total Reduction";
                        paymentmodegrid.Modify();
                    until Requestcreditnotegrid1.Next() = 0;
            until paymentmodegrid.Next() = 0;

        paymentschedulegrid.SetRange("Contract ID", "Contract ID");
        if paymentschedulegrid.FindSet() then
            repeat
                Requestcreditnotegrid2.SetRange("Contract ID", paymentschedulegrid."Contract ID");
                Requestcreditnotegrid2.SetRange("Payment Series", paymentschedulegrid."Payment Series");
                Requestcreditnotegrid2.SetRange(Charges, paymentschedulegrid."Secondary Item Type");
                Requestcreditnotegrid2.SetRange("Credit Memo Generated", true);
                if Requestcreditnotegrid2.FindFirst() then begin
                    paymentschedulegrid."Credit Note No." := Requestcreditnotegrid2."Credit Note No.";
                    paymentschedulegrid."Credit Note Amount" := Requestcreditnotegrid2."Total Reduction";
                    paymentschedulegrid.Modify();
                end;
            until paymentschedulegrid.Next() = 0;
    end;
}
