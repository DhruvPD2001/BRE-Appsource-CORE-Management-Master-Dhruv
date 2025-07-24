table 50329 "TC Merge LumAnnualAmount SP"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "ML_Merged Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LeaseProposal: Record "Contract Renewal";
            begin
                if LeaseProposal.Get("ID", "ML_Merged Unit ID") then begin
                    Rec."ML_Start Date" := LeaseProposal."Contract Start Date";
                    Rec."ML_End Date" := LeaseProposal."Contract End Date";
                    Rec."ML_Unit Sq Ft" := LeaseProposal."Unit Sq. Feet";
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
            CalcFormula = sum("TC Merge LumAnnualAmount SP"."ML_Final Annual Amount" where("Id" = field(ID)));


        }
        field(50117; "TotalAnnualAmount"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = sum("TC Merge LumAnnualAmount SP"."ML_Annual Amount" where("Id" = field("Id")));

        }
        field(50118; "TotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("TC Merge LumAnnualAmount SP"."ML_Round off" where("Id" = field("Id")));

        }

        field(50119; "TotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("TC Merge LumAnnualAmount SP"."ML_Final Annual Amount" where("Id" = field("Id"), ML_Year = const(1)));
        }
        field(50121; "Contract Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "ID", "ML_Line No.")
        {
            Clustered = true;
        }
    }
}
