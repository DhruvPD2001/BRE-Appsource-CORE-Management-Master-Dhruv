table 50330 "TC Single Unit Rent SubPage"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "Merged Unit ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LeaseProposal: Record "Contract Renewal";
            begin
                if LeaseProposal.Get("Id", "Unit ID") then begin
                    Rec."Unit ID" := LeaseProposal."Unit Name";
                    Rec."Start Date" := LeaseProposal."Contract Start Date";
                    Rec."End Date" := LeaseProposal."Contract End Date";
                    Rec."Unit Sq Ft" := LeaseProposal."Unit Sq. Feet";
                    Rec."Rate per Sq.Ft" := LeaseProposal."Rent Amount";
                    Rec."Number of Days" := Rec."End Date" - Rec."Start Date";
                    Modify(true);
                end else
                    Error('No matching Lease Proposal found for the selected Unit ID.');
            end;
        }
        field(50103; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "Number of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Unit Sq Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Rate per Sq.Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Rent Increase %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(50111; "Round off"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50112; "Final Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Single Unit Rent1"; Code[100])
        {
            DataClassification = ToBeClassified;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
        field(50115; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50116; "TotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("TC Single Unit Rent SubPage"."Final Annual Amount" where("Id" = field("Id")));
        }
        field(50117; "TotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("TC Single Unit Rent SubPage"."Annual Amount" where("Id" = field("Id")));
        }
        field(50118; "TotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("TC Single Unit Rent SubPage"."Round off" where("Id" = field("Id")));
        }
        field(50119; "TotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("TC Single Unit Rent SubPage"."Final Annual Amount" where("Id" = field("Id"), Year = const(1)));
        }
        field(50121; "Contract Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Id", "Line No.")
        {
            Clustered = true;
        }
    }
}
