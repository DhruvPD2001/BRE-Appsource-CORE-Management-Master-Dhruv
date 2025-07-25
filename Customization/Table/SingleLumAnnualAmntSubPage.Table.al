table 50316 "Single Lum_AnnualAmnt SubPage"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "Proposal ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "SL_Merged Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LeaseProposal: Record "Lease Proposal Details";
            begin
                if LeaseProposal.Get("Proposal ID", "SL_Merged Unit ID") then begin
                    Rec."SL_Start Date" := LeaseProposal."Lease Start Date";
                    Rec."SL_End Date" := LeaseProposal."Lease End Date";
                    Rec."SL_Unit Sq Ft" := LeaseProposal."Unit Size";
                    Rec."SL_Rate per Sq.Ft" := LeaseProposal."Rent Amount";
                    Rec."SL_Merged Unit ID" := LeaseProposal."Unit Name";
                    Rec."SL_Number of Days" := Rec."SL_End Date" - Rec."SL_Start Date";
                    Modify(true);
                end else
                    Error('No matching Lease Proposal found for the selected Unit ID.');
            end;
        }
        field(50102; "SL_Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "SL_Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "SL_Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "SL_End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "SL_Number of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "SL_Unit Sq Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "SL_Rate per Sq.Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "SL_Rent Increase %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "SL_Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50111; "SL_Round off"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50112; "SL_Final Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "SL_Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Single Lumpsum Rent1"; Code[100])
        {
            DataClassification = ToBeClassified;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
        field(50115; "SL_Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50116; "TotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Single Lum_AnnualAmnt SubPage"."SL_Final Annual Amount" where("Proposal Id" = field("Proposal Id")));
        }
        field(50117; "TotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Single Lum_AnnualAmnt SubPage"."SL_Annual Amount" where("Proposal Id" = field("Proposal Id")));
        }
        field(50118; "TotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Single Lum_AnnualAmnt SubPage"."SL_Round off" where("Proposal Id" = field("Proposal Id")));
        }
        field(50119; "TotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Single Lum_AnnualAmnt SubPage"."SL_Final Annual Amount" where("Proposal Id" = field("Proposal Id"), SL_Year = const(1)));
        }
    }
    keys
    {
        key(PK; "Proposal ID", "SL_Line No.")
        {
            Clustered = true;
        }
    }
}
