table 50109 "Revenue Allocation Details"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "No.";
    fields
    {
        field(50100; "No."; Integer)
        {
            DataClassification = SystemMetadata;
            Editable = false;
            AutoIncrement = true;
            Caption = 'ID';
        }
        field(50101; "Financial Year"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Financial Year';
        }
        field(50102; "Month"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Month';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(50103; "Status"; Option)
        {
            OptionMembers = "Pending","Approve","Reject";
            Caption = 'Status';
        }
    }
    keys
    {
        key(PK; "No.") { Clustered = true; }
    }
    trigger OnDelete()
    var
    begin
        Deletesubrevenueallocation();
        Deletesubrevenueallocationotherrevenue();
        Deletesubrevenueallocationitem();
    end;

    procedure Deletesubrevenueallocation()
    var
        revenueallocationsubgrid: Record "Revenue Allocation SubGrid";
    begin
        revenueallocationsubgrid.SetRange("Header No.", Rec."No.");
        if revenueallocationsubgrid.FindSet() then
            revenueallocationsubgrid.DeleteAll();
    end;

    procedure Deletesubrevenueallocationitem()
    var
        revenueallocationitem: Record "Revenue Recognition Item";
    begin
        revenueallocationitem.SetRange("RR_No.", Rec."No.");
        if revenueallocationitem.FindSet() then
            revenueallocationitem.DeleteAll();
    end;

    procedure Deletesubrevenueallocationotherrevenue()
    var
        revenueallocationothercharges: Record "Revenue Recognition Details";
    begin
        revenueallocationothercharges.SetRange("RR_No.", Rec."No.");
        if revenueallocationothercharges.FindSet() then
            revenueallocationothercharges.DeleteAll();
    end;
}
