table 50967 "Request Credit Note"
{
    DataClassification = ToBeClassified;
    Caption = 'Request Credit Note';
    fields
    {
        field(50958; "Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Request No.';
        }
        field(50960; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(50961; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';
        }
        field(50962; "Tenant No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant No.';
        }
        field(50963; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';
        }
        field(50964; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Request Date';
        }
        field(50965; "Credit Note Start Month"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note Start Month';
        }
        field(50966; "Credit Note End Month"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note End Month';
        }
        field(50967; "Payment Frequency"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Frequency';
        }
        field(50968; "Monthly Reduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Monthly Reduction';
        }
        field(50969; "Reason"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reason';
        }
        field(50970; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Pending,Approved,Rejected;
            Caption = 'Status';
        }
        field(50971; "Request Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Email,Phone,WalkIn,Other;
            Caption = 'Request Source';
        }
        field(50972; "Total Reduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Reduction';
        }
        field(50973; "Payment Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';
        }
        field(50974; "Current Rent Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Current Rent Amount';
        }
        field(50975; "Reason for Rejection"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reason for Rejection';
        }
        field(50976; "Property Classification"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Classification';
        }
        field(50977; "Adjust with Invoice"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,Adjusted;
        }
    }
    trigger OnInsert()
    var
        NoSeriesManagement: Codeunit "No. Series";
        Requestno: Code[20];
    begin
        Requestno := NoSeriesManagement.GetNextNo('RCNID', 0D, true);
        "Request No." := Requestno;
    end;

    trigger OnDelete()
    var
    begin
        Deletepaymetnscheudlesubpage();
    end;

    procedure Deletepaymetnscheudlesubpage()
    var
        RequestCreditNoteGrid: Record "Request Credit Note Grid";
    begin
        RequestCreditNoteGrid.SetRange("Request No.", Rec."Request No.");
        if RequestCreditNoteGrid.FindSet() then
            repeat
                RequestCreditNoteGrid.DeleteAll();
            until RequestCreditNoteGrid.Next() = 0;
    end;
}