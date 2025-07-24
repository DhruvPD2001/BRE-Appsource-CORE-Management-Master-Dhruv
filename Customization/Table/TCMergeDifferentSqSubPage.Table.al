table 50328 "TC Merge DifferentSq SubPage"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "MD_Merged Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                LeaseProposal: Record "Contract Renewal";
            begin
                if LeaseProposal.Get("ID", "MD_Merged Unit ID") then begin
                    Rec."MD_Merged Unit ID" := LeaseProposal."Unit Name";
                    Rec."MD_Start Date" := LeaseProposal."Contract Start Date";
                    Rec."MD_End Date" := LeaseProposal."Contract End Date";
                    Rec."MD_Unit Sq Ft" := LeaseProposal."Unit Sq. Feet";
                    Rec."MD_Rate per Sq.Ft" := LeaseProposal."Rent Amount";
                    Rec."MD_Number of Days" := Rec."MD_End Date" - Rec."MD_Start Date";
                    Modify(true);
                end else
                    Error('No matching Lease Proposal found for the selected Unit ID.');
            end;
        }
        field(50102; "MD_Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "MD_Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "MD_Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "MD_End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "MD_Number of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "MD_Unit Sq Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "MD_Rate per Sq.Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "MD_Rent Increase %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "MD_Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50111; "MD_Round off"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50112; "MD_Final Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "MD_Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Merge DifferentSqure Rent1"; Code[100])
        {
            DataClassification = ToBeClassified;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }

        field(50115; "MD_Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }


        field(50117; "TotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("TC Merge DifferentSq SubPage"."MD_Final Annual Amount" where("Id" = field("Id")));

        }
        field(50118; "TotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("TC Merge DifferentSq SubPage"."MD_Annual Amount" where("Id" = field("Id")));

        }
        field(50119; "TotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("TC Merge DifferentSq SubPage"."MD_Round off" where("Id" = field("Id")));

        }


        field(50120; "TotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("TC Merge DifferentSq SubPage"."MD_Final Annual Amount" where("Id" = field(ID), MD_Year = const(1)));

        }
        field(50121; "Contract Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "ID", "MD_Line No.")
        {
            Clustered = true;
        }
    }
}
