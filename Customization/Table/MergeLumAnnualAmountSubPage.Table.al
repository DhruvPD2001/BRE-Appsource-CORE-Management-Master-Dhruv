table 50107 "Merge Lum_AnnualAmount SubPage"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "Proposal ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "ML_Merged Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LeaseProposal: Record "Lease Proposal Details";
            begin
                if LeaseProposal.Get("Proposal ID", "ML_Merged Unit ID") then begin
                    Rec."ML_Start Date" := LeaseProposal."Lease Start Date";
                    Rec."ML_End Date" := LeaseProposal."Lease End Date";
                    Rec."ML_Unit Sq Ft" := LeaseProposal."Unit Size";
                    Rec."ML_Rate per Sq.Ft" := LeaseProposal."Rent Amount";
                    Rec."ML_Merged Unit ID" := LeaseProposal."Unit Name";
                    Rec."ML_Number of Days" := Rec."ML_End Date" - Rec."ML_Start Date";
                    Modify(true);
                end else
                    Error('No matching Lease Proposal found for the selected Unit ID.');
            end;
        }
        field(50102; "ML_Unit ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "ML_Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "ML_Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "ML_End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "ML_Number of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "ML_Unit Sq Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "ML_Rate per Sq.Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "ML_Rent Increase %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "ML_Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50111; "ML_Round off"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50112; "ML_Final Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "ML_Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Merge Lumpsum Rent1"; Code[100])
        {
            DataClassification = ToBeClassified;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
        field(50115; "ML_Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50116; "TotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Merge Lum_AnnualAmount SubPage"."ML_Final Annual Amount" where("Proposal Id" = field("Proposal Id")));
        }
        field(50117; "TotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Merge Lum_AnnualAmount SubPage"."ML_Annual Amount" where("Proposal Id" = field("Proposal Id")));
        }
        field(50118; "TotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Merge Lum_AnnualAmount SubPage"."ML_Round off" where("Proposal Id" = field("Proposal Id")));
        }
        field(50119; "TotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Merge Lum_AnnualAmount SubPage"."ML_Final Annual Amount" where("Proposal Id" = field("Proposal Id"), ML_Year = const(1)));
        }
    }
    keys
    {
        key(PK; "Proposal ID", "ML_Line No.")
        {
            Clustered = true;
        }
    }
}
