table 50331 "TC Single LumAnnualAmnt SP"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "SL_Merged Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LeaseProposal: Record "Contract Renewal";
            begin
                if LeaseProposal.Get("ID", "SL_Merged Unit ID") then begin
                    Rec."SL_Start Date" := LeaseProposal."Contract Start Date";
                    Rec."SL_End Date" := LeaseProposal."Contract End Date";
                    Rec."SL_Unit Sq Ft" := LeaseProposal."Unit Sq. Feet";
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
            CalcFormula = sum("TC Single LumAnnualAmnt SP"."SL_Final Annual Amount" where("Id" = field("Id")));
        }

        field(50117; "TotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("TC Single LumAnnualAmnt SP"."SL_Annual Amount" where("Id" = field("Id")));
        }

        field(50118; "TotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("TC Single LumAnnualAmnt SP"."SL_Round off" where("Id" = field("Id")));
        }


        field(50119; "TotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("TC Single LumAnnualAmnt SP"."SL_Final Annual Amount" where("Id" = field("Id"), SL_Year = const(1)));
        }
        field(50121; "Contract Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; "ID", "SL_Line No.")
        {
            Clustered = true;
        }
    }
}
