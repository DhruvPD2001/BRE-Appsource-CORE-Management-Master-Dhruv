table 50966 "Revenue Allocation Approval"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "RA_ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'RA_ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(50101; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(50102; "Financial Year"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Financial Year';
        }
        field(50103; "Month"; Option)
        {
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
            Caption = 'Month';
        }
        field(50104; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            OptionMembers = "Pending","Approved","Reject";
        }
    }
    keys
    {
        key(PK; "RA_ID")
        {
            Clustered = false;
        }
    }

    trigger OnInsert()
    var
        approvalRevenuerequest: Codeunit "Approval Revenue Allocation";
    begin
        approvalRevenuerequest.SendRevenueApprovalrequest(Rec);
    end;
}
