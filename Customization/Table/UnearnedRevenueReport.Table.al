table 50116 "Unearned Revenue Report"
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
        field(50101; "Starting Date Year"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Starting Date Year';

            trigger OnValidate()
            begin
                if (Date2DMY("Starting Date Year", 1) <> 1) or (Date2DMY("Starting Date Year", 2) <> 1) then
                    Error('Starting Date must be 1st January of the year.');

                if ("Starting Date Year" <> 0D) and ("Ending Date Year" <> 0D) then
                    if "Starting Date Year" > "Ending Date Year" then
                        Error('Starting Date Year cannot be greater than Ending Date Year.');
            end;
        }
        field(50103; "Ending Date Year"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ending Date Year';

            trigger OnValidate()
            begin
                if "Ending Date Year" < "Starting Date Year" then
                    Error('Ending Date Year cannot be less than Starting Date Year.');
            end;
        }

        field(50; "R_Total Contract Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Contract Value';
            Editable = false;
        }

        field(51; "R_Total Opening Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Opening Balance';
            Editable = false;
        }

        field(52; "R_T_Invoice Raised During Year"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Invoice Raised During Year';
            Editable = false;
        }

        field(53; "R_T_Revenue Allocated During Y"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Revenue Allocated During Year';
            Editable = false;
        }

        field(54; "R_T_Unearned Revenue Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Unearned Revenue Balance';
            Editable = false;
        }

        field(55; "R_T_Cal Unearned RevBalance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Calculated Unearned Rev Balance';
            Editable = false;
        }

        field(56; "R_Total Shortfall Excess"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Shortfall/Excess';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.") { Clustered = true; }
    }


    trigger OnDelete()
    var
    begin
        Deleteunearnedrentrevenue();
        Deleteunearnedrevenueotherrevenue();
        Deletesubunearnedrevenuereportitem();

    end;

    procedure Deleteunearnedrentrevenue()
    var
        unearnedrevenuerentsubgrid: Record "Sub Unearned Revenue Report";
    begin
        unearnedrevenuerentsubgrid.SetRange("Header No.", Rec."No.");
        if unearnedrevenuerentsubgrid.FindSet() then
            unearnedrevenuerentsubgrid.DeleteAll();
    end;

    procedure Deletesubunearnedrevenuereportitem()
    var
        unearnedrevenuereportitem: Record "Other Charges UnearnedRevenue";
    begin
        unearnedrevenuereportitem.SetRange("No.", Rec."No.");
        if unearnedrevenuereportitem.FindSet() then
            unearnedrevenuereportitem.DeleteAll();
    end;

    procedure Deleteunearnedrevenueotherrevenue()
    var
        unearnedrevenueothercharges: Record "Sub Unearned Charges";
    begin
        unearnedrevenueothercharges.SetRange("Header No.", Rec."No.");
        if unearnedrevenueothercharges.FindSet() then
            unearnedrevenueothercharges.DeleteAll();
    end;
}