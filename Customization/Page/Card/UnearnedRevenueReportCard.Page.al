page 50139 "Unearned Revenue Report Card"
{
    PageType = Card;
    SourceTable = "Unearned Revenue Report";
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Unearned Revenue Report';

    layout
    {
        area(Content)
        {
            group("Unearned Revenue Report")
            {
                Caption = 'Unearned Revenue Report';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the unearned revenue report.';
                }
                field("Starting Date Year"; Rec."Starting Date Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'The starting date for the report, typically set to the first day of the year.';
                }
                field("Ending Date Year"; Rec."Ending Date Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'The ending date for the report, typically set to the last day of the year.';
                }
            }
            group("Unearned Rent Revenue Report Report Details")
            {
                Caption = 'Unearned Rent Revenue Report Details';
                part("Unearned Rent Revenue Report Details"; "Sub Unearned Revenue Card")
                {
                    SubPageLink = "Header No." = field("No.");
                }
            }

            group("Total For Rent Charges")
            {
                Caption = 'Total For Rent Charges';
                field("Total Contract Value"; Rec."R_Total Contract Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total contract value for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Opening Balance"; Rec."R_Total Opening Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total opening balance for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Invoice Raised During Year"; Rec."R_T_Invoice Raised During Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total invoice raised during the year for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Revenue Allocated During Year"; Rec."R_T_Revenue Allocated During Y")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total revenue allocated during the year for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Unearned Revenue Balance"; Rec."R_T_Unearned Revenue Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total unearned revenue balance for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Calculated Unearned Rev Balance"; Rec."R_T_Cal Unearned RevBalance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total calculated unearned revenue balance for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Shortfall Excess"; Rec."R_Total Shortfall Excess")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total shortfall or excess for the unearned revenue report.';
                    Editable = false;
                }
            }

            group("Other Charges Details")
            {
                Caption = 'Other Charges Details';
                part("Other Charges Unearned Revenue"; "OtherCharges-UnearnedRevenue")
                {
                    SubPageLink = "No." = field("No.");
                }
            }
            group("Unearned Other Charges Revenue Report Report Details")
            {
                Caption = 'Unearned Other Charges Revenue Report Details';
                part("Unearned Other Charges Revenue Report Details"; "Sub Unearned Charges")
                {
                    SubPageLink = "Header No." = field("No.");
                }
            }

            group("Total For Other Charges")
            {
                Caption = 'Total For Other Charges';

                field(TotalOtherCharges; TotalOtherCharges)
                {
                    Caption = 'Total Other Charges';
                    Editable = false;
                    ToolTip = 'Total other charges for the unearned revenue report.';
                    ApplicationArea = All;
                }
                field(TotalOpeningBalance; TotalOpeningBalance)
                {
                    Caption = 'Total Opening Balance';
                    Editable = false;
                    ToolTip = 'Total opening balance for other charges in the unearned revenue report.';
                    ApplicationArea = All;
                }
                field(TotalInvoiceraisedduringtheyear; TotalInvoiceraisedduringtheyear)
                {
                    ApplicationArea = All;
                    Caption = 'Total Invoice Raised During the Year';
                    ToolTip = 'Total invoice raised during the year for other charges in the unearned revenue report.';
                    Editable = false;
                }
                field(Totalrevenueallocatedduringtheyear; Totalrevenueallocatedduringtheyear)
                {
                    ApplicationArea = All;
                    Caption = 'Total Revenue Allocation During the Year';
                    ToolTip = 'Total revenue allocated during the year for other charges in the unearned revenue report.';
                    Editable = false;
                }
                field(Totalunearnedrevenuebalance; Totalunearnedrevenuebalance)
                {
                    Caption = 'Total Unearned Revenue Balance';
                    Editable = false;
                    ToolTip = 'Total unearned revenue balance for other charges in the unearned revenue report.';
                    ApplicationArea = All;
                }
                field(Totalcalculatedunearnedrevenuebalance; Totalcalculatedunearnedrevenuebalance)
                {
                    Caption = 'Total Calculated Unearned Revenue Balance';
                    Editable = false;
                    ToolTip = 'Total calculated unearned revenue balance for other charges in the unearned revenue report.';
                    ApplicationArea = All;
                }
                field(Totalshortfall; Totalshortfall)
                {
                    ApplicationArea = All;
                    Caption = 'Total Shortfall/Excess';
                    ToolTip = 'Total shortfall or excess for other charges in the unearned revenue report.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Unearned Rent Revenue Report")
            {
                ApplicationArea = All;
                Caption = 'Unearned Rent Revenue Report';
                Image = Revenue;
                ToolTip = 'Fetch unearned rent revenue data for the selected period.';

                trigger OnAction()
                begin
                    UnearnedRevenueRent();
                    CalculateAndUpdateTotals();
                    Message('All data for Unearned Rent Revenue has been fetched.');
                end;
            }

            action("Unearned Other Charges Revenue Report")
            {
                ApplicationArea = All;
                Caption = 'Unearned Other Charges Revenue Report';
                Image = Revenue;
                ToolTip = 'Fetch unearned other charges revenue data for the selected period.';

                trigger OnAction()
                begin
                    UnearnedRevenueOtherCharges();
                    Message('All data for Other Charges Revenue has been fetched.');
                end;
            }
        }

        area(Promoted)
        {
            actionref("UnearnedRentRevenueReport"; "Unearned Rent Revenue Report") { }
            actionref("UnearnedOtherChargesRevenueReport"; "Unearned Other Charges Revenue Report") { }
        }
    }

    procedure CalculateAndUpdateTotals()
    var
        unearnedRevenueBuffer: Record "Sub Unearned Revenue Report";
        TotalContractValue: Decimal;
        lTotalOpeningBalance: Decimal;
        TotalInvoiceRaised: Decimal;
        TotalRevenueAllocated: Decimal;
        TotalUnearnedRevBalance: Decimal;
        TotalCalculatedUnearnedRevBalance: Decimal;
        TotalShortfallExcess: Decimal;
    begin
        // Initialize totals
        TotalContractValue := 0;
        lTotalOpeningBalance := 0;
        TotalInvoiceRaised := 0;
        TotalRevenueAllocated := 0;
        TotalUnearnedRevBalance := 0;
        TotalCalculatedUnearnedRevBalance := 0;
        TotalShortfallExcess := 0;

        // Calculate totals from buffer table
        unearnedRevenueBuffer.Reset();
        unearnedRevenueBuffer.SetRange("Header No.", Rec."No.");

        if unearnedRevenueBuffer.FindSet() then
            repeat
                TotalContractValue += unearnedRevenueBuffer."Contract Value";
                lTotalOpeningBalance += unearnedRevenueBuffer."Opening Balance";
                TotalInvoiceRaised += unearnedRevenueBuffer."Invoice Raised During the Year";
                TotalRevenueAllocated += unearnedRevenueBuffer."RevenueAllocated DuringtheYear";
                TotalUnearnedRevBalance += unearnedRevenueBuffer."Unearned Revenue Balance";
                TotalCalculatedUnearnedRevBalance += unearnedRevenueBuffer.CalculatedUnearnedRevBalance;
                TotalShortfallExcess += unearnedRevenueBuffer."Shortfall/Excess";
            until unearnedRevenueBuffer.Next() = 0;

        // Update header record with totals
        Rec."R_Total Contract Value" := TotalContractValue;
        Rec."R_Total Opening Balance" := lTotalOpeningBalance;
        Rec."R_T_Invoice Raised During Year" := TotalInvoiceRaised;
        Rec."R_T_Revenue Allocated During Y" := TotalRevenueAllocated;
        Rec."R_T_Unearned Revenue Balance" := TotalUnearnedRevBalance;
        Rec."R_T_Cal Unearned RevBalance" := TotalCalculatedUnearnedRevBalance;
        Rec."R_Total Shortfall Excess" := TotalShortfallExcess;

        Rec.Modify();
        CurrPage.Update();
    end;

    procedure UnearnedRevenueRent()
    var
        tenancyContract: Record "Tenancy Contract";
        unearnedRevenueBuffer: Record "Sub Unearned Revenue Report"; // your buffer table
        SuspendedReasonRec: Record SuspendReasonTable; // Replace with actual table name
        FinalCalculationRec: Record "Final Calculation"; // Replace with actual table name
        paymentSchedule: Record "Payment Schedule2"; // Assumed name
        NewLineNo: Integer;
        StartDate, EndDate : Date;
        SuspendedDate: Date;
        TerminationDate: Date;
        TotalPaidAmount: Decimal;
        TotalInvoicedAmount: Decimal;
        TotalNoofDays: Integer;
        UnearnedNoofday: Integer;
        PerDayrent: Decimal;
        TotalMonthlyRevenue: Decimal;
        RevenueAllocatedDuringYear: Decimal;
        RevenueAllocation: Decimal;
        TotalEarnedAmount: Decimal;
        TotalCreditnode: Decimal;
        TotalCreditAmountIssued: Decimal;
        UnearnedRevenueAllocation: Decimal;
    begin
        ClearSubgridData(); // Always clear before inserting

        StartDate := Rec."Starting Date Year";
        EndDate := Rec."Ending Date Year";

        tenancyContract.Reset();
        tenancyContract.SetFilter("Tenant Contract Status", '%1|%2|%3|%4',
            tenancyContract."Tenant Contract Status"::Active,
            tenancyContract."Tenant Contract Status"::Terminated,
            tenancyContract."Tenant Contract Status"::Suspended,
            tenancyContract."Tenant Contract Status"::"Active-Contract Renewed",
            tenancyContract."Tenant Contract Status"::"Contract Renewed");

        // ✅ Filter contracts that fall within OR span the date range
        tenancyContract.SetFilter("Contract Start Date", '..%1', EndDate); // starts on or before end date
        tenancyContract.SetFilter("Contract End Date", '%1..', StartDate); // ends on or after start date

        if tenancyContract.FindSet() then
            repeat
                Clear(unearnedRevenueBuffer);
                Clear(SuspendedReasonRec);
                Clear(FinalCalculationRec);
                TotalPaidAmount := 0;
                TotalInvoicedAmount := 0;
                TotalMonthlyRevenue := 0;
                RevenueAllocatedDuringYear := 0;


                // 🔹1. Calculate Total Paid before Start Date
                paymentSchedule.Reset();
                paymentSchedule.SetRange("Contract ID", tenancyContract."Contract ID");
                paymentSchedule.SetRange("Secondary Item Type", 'Rent');
                paymentSchedule.SetRange("Due Date", tenancyContract."Contract Start Date", StartDate - 1);
                paymentSchedule.SetRange("Invoiced", true);

                if paymentSchedule.FindSet() then
                    repeat
                        TotalPaidAmount += paymentSchedule."Amount Including VAT";
                    until paymentSchedule.Next() = 0;


                paymentSchedule.Reset();
                paymentSchedule.SetRange("Contract ID", tenancyContract."Contract ID");
                paymentSchedule.SetRange("Secondary Item Type", 'Rent');
                paymentSchedule.SetRange("Due Date", tenancyContract."Contract Start Date", StartDate - 1);
                paymentSchedule.SetRange("Payment Status", 'Received');

                if paymentSchedule.FindSet() then
                    repeat
                        TotalEarnedAmount += paymentSchedule."Amount Including VAT";
                    until paymentSchedule.Next() = 0;

                paymentSchedule.Reset();
                paymentSchedule.SetRange("Contract ID", tenancyContract."Contract ID");
                paymentSchedule.SetRange("Secondary Item Type", 'Rent');
                paymentSchedule.SetRange("Due Date", tenancyContract."Contract Start Date", StartDate - 1);

                if paymentSchedule.FindSet() then
                    repeat
                        TotalCreditnode += paymentSchedule."Credit Note Amount";
                    until paymentSchedule.Next() = 0;

                paymentSchedule.Reset();
                paymentSchedule.SetRange("Contract ID", tenancyContract."Contract ID");
                paymentSchedule.SetRange("Secondary Item Type", 'Rent');
                paymentSchedule.SetRange("Due Date", StartDate, EndDate);
                paymentSchedule.SetRange("Invoiced", true);

                if paymentSchedule.FindSet() then
                    repeat
                        TotalInvoicedAmount += paymentSchedule."Amount Including VAT";
                    until paymentSchedule.Next() = 0;

                paymentSchedule.Reset();
                paymentSchedule.SetRange("Contract ID", tenancyContract."Contract ID");
                paymentSchedule.SetRange("Secondary Item Type", 'Rent');
                paymentSchedule.SetRange("Due Date", StartDate, EndDate);
                paymentSchedule.SetRange("Invoiced", true);

                if paymentSchedule.FindSet() then
                    repeat
                        TotalCreditAmountIssued += paymentSchedule."Credit Note Amount";
                    until paymentSchedule.Next() = 0;

                NewLineNo := GetNextLineNo();

                SuspendedDate := 0D;
                if tenancyContract."Tenant Contract Status" = tenancyContract."Tenant Contract Status"::Suspended then begin
                    SuspendedReasonRec.Reset();
                    SuspendedReasonRec.SetRange("Contract ID", tenancyContract."Contract ID");
                    if SuspendedReasonRec.FindLast() then
                        SuspendedDate := SuspendedReasonRec.DateEffective;
                end;

                TerminationDate := 0D;
                if tenancyContract."Tenant Contract Status" = tenancyContract."Tenant Contract Status"::Terminated then begin
                    FinalCalculationRec.Reset();
                    FinalCalculationRec.SetRange("Contract ID", tenancyContract."Contract ID");
                    if FinalCalculationRec.FindLast() then
                        TerminationDate := FinalCalculationRec."Termination Date";
                end;

                unearnedRevenueBuffer.Init();
                unearnedRevenueBuffer."Header No." := Rec."No.";
                unearnedRevenueBuffer."Line No." := NewLineNo;
                unearnedRevenueBuffer."Contract ID" := tenancyContract."Contract ID";
                unearnedRevenueBuffer."Start Date" := tenancyContract."Contract Start Date";
                unearnedRevenueBuffer."End Date" := tenancyContract."Contract End Date";
                unearnedRevenueBuffer."Customer Name" := tenancyContract."Customer Name";
                unearnedRevenueBuffer.Property := tenancyContract."Property Name";
                unearnedRevenueBuffer."Owner Name" := tenancyContract."Owner's Name";
                unearnedRevenueBuffer."Contract Value" := tenancyContract."Annual Rent Amount";
                unearnedRevenueBuffer."Contract Status" := Format(tenancyContract."Tenant Contract Status");
                unearnedRevenueBuffer."Opening Balance" := (TotalPaidAmount + TotalCreditnode) - TotalEarnedAmount;
                unearnedRevenueBuffer."Invoice Raised During the Year" := TotalInvoicedAmount + TotalCreditAmountIssued;
                unearnedRevenueBuffer."Suspension Date" := SuspendedDate;
                unearnedRevenueBuffer."Termination Date" := TerminationDate;

                if (tenancyContract."Tenant Contract Status" <> tenancyContract."Tenant Contract Status"::Terminated) and (tenancyContract."Tenant Contract Status" <> tenancyContract."Tenant Contract Status"::"Contract Renewed") then begin

                    TotalNoofDays := unearnedRevenueBuffer."End Date" - unearnedRevenueBuffer."Start Date" + 1;
                    PerDayrent := unearnedRevenueBuffer."Contract Value" / TotalNoofDays;
                    UnearnedNoofday := unearnedRevenueBuffer."End Date" - EndDate;
                    unearnedRevenueBuffer.CalculatedUnearnedRevBalance := PerDayrent * UnearnedNoofday;
                end else
                    unearnedRevenueBuffer.CalculatedUnearnedRevBalance := 0;

                case tenancyContract."Praposal Type Selected" of
                    tenancyContract."Praposal Type Selected"::"Single Unit":
                        unearnedRevenueBuffer."Unit Name" := COPYSTR(tenancyContract."Unit Name", 1, MAXSTRLEN(unearnedRevenueBuffer."Unit Name"));
                    tenancyContract."Praposal Type Selected"::"Merge Unit":
                        unearnedRevenueBuffer."Unit Name" := COPYSTR(tenancyContract."Single Unit Name", 1, MAXSTRLEN(unearnedRevenueBuffer."Unit Name"));
                    else
                        unearnedRevenueBuffer."Unit Name" := '';
                end;

                RevenueAllocation := CalculateRevenueAllocation(tenancyContract."Contract ID", Rec."Starting Date Year");
                UnearnedRevenueAllocation := CalculateUnearnedRevenueAllocation(tenancyContract."Contract ID");
                unearnedRevenueBuffer."RevenueAllocated DuringtheYear" := RevenueAllocation;
                unearnedRevenueBuffer."Unearned Revenue Balance" := UnearnedRevenueAllocation;
                unearnedRevenueBuffer."Shortfall/Excess" := unearnedRevenueBuffer."Unearned Revenue Balance" - unearnedRevenueBuffer.CalculatedUnearnedRevBalance;
                unearnedRevenueBuffer.Insert();
            until tenancyContract.Next() = 0;
    end;

    local procedure CalculateRevenueAllocation(ContractID: Integer; StartDate: Date): Decimal
    var
        RevenueAllocationRec: Record "Revenue Allocation SubGrid";
        TotalRevenueAllocated: Decimal;
        StartYear: Integer;
    begin
        TotalRevenueAllocated := 0;

        StartYear := Date2DMY(StartDate, 3);

        RevenueAllocationRec.Reset();
        RevenueAllocationRec.SetRange("Contract ID", ContractID);
        RevenueAllocationRec.SetRange("Posting Year", StartYear);
        RevenueAllocationRec.SetFilter(Description, '(%1|%2)', 'Regular', 'Credit Note');
        RevenueAllocationRec.SetFilter("Posting Month", GetMonthFilter(Rec."Starting Date Year", Rec."Ending Date Year"));

        if RevenueAllocationRec.FindSet() then
            repeat
                TotalRevenueAllocated += RevenueAllocationRec."Total Value";
            until RevenueAllocationRec.Next() = 0;

        exit(TotalRevenueAllocated);
    end;

    local procedure CalculateUnearnedRevenueAllocation(ContractID: Integer): Decimal
    var
        RevenueAllocationRec: Record "Revenue Allocation SubGrid";
        RevenueAllocation: Record "Revenue Allocation Details";
        TotalEarnedRevenueAllocated: Decimal;
    begin
        TotalEarnedRevenueAllocated := 0;

        RevenueAllocation.Reset();
        RevenueAllocation.SetRange("Status", RevenueAllocation."Status"::Pending);

        if RevenueAllocation.FindSet() then
            repeat
                RevenueAllocationRec.Reset();
                RevenueAllocationRec.SetRange("Header No.", RevenueAllocation."No.");
                RevenueAllocationRec.SetRange("Contract ID", ContractID);
                RevenueAllocationRec.SetFilter(Description, '(%1|%2)', 'Regular', 'Credit Note');
                if RevenueAllocationRec.FindSet() then
                    repeat
                        if (Rec."Starting Date Year" >= RevenueAllocationRec."Contract Start Date") and
                           (Rec."Starting Date Year" <= RevenueAllocationRec."Contract End Date") or
                           (Rec."Ending Date Year" >= RevenueAllocationRec."Contract Start Date") and
                           (Rec."Ending Date Year" <= RevenueAllocationRec."Contract End Date") then
                            TotalEarnedRevenueAllocated += RevenueAllocationRec."Total Value";

                    until RevenueAllocationRec.Next() = 0;
            until RevenueAllocation.Next() = 0;

        exit(TotalEarnedRevenueAllocated);
    end;


    // ✅ Helper procedure to create month filter
    local procedure GetMonthFilter(StartDate: Date; EndDate: Date): Text
    var
        FetchMonth: Codeunit "Fetch Month";
        EndMonth: Integer;
        MonthFilter: Text;
        CurrentDate: Date;
        MonthName: Text;
    begin
        EndMonth := Date2DMY(EndDate, 2);

        MonthFilter := '';
        CurrentDate := StartDate;

        while CurrentDate <= EndDate do begin
            MonthName := FetchMonth.GetMonthName(Date2DMY(CurrentDate, 2));

            if MonthFilter = '' then
                MonthFilter := MonthName
            else
                MonthFilter += '|' + MonthName;

            // Move to next month
            CurrentDate := CalcDate('<1M>', DMY2Date(1, Date2DMY(CurrentDate, 2), Date2DMY(CurrentDate, 3)));

            // Break if we've gone past the end date
            if Date2DMY(CurrentDate, 2) > EndMonth then
                break;
        end;

        exit(MonthFilter);
    end;

    procedure GetNextLineNo(): Integer
    var
        unearnedRevenueBuffer: Record "Sub Unearned Revenue Report";
        LastLineNo: Integer;
    begin
        unearnedRevenueBuffer.Reset();
        unearnedRevenueBuffer.SetRange("Header No.", Rec."No."); // ✅ filter by Header No.
        if unearnedRevenueBuffer.FindLast() then
            LastLineNo := unearnedRevenueBuffer."Line No."
        else
            LastLineNo := 0;

        exit(LastLineNo + 1);
    end;

    procedure ClearSubgridData()
    var
        RevenueItemDetail: Record "Sub Unearned Revenue Report";
    begin
        RevenueItemDetail.SetRange("Header No.", Rec."No."); // ✅ Clear only for this header
        RevenueItemDetail.DeleteAll(true);
    end;


    procedure UnearnedRevenueOtherCharges()
    var
        tenancyContract: Record "Tenancy Contract";
        unearnedRevenueBuffer: Record "Sub Unearned Charges";
        SuspendedReasonRec: Record SuspendReasonTable;
        FinalCalculationRec: Record "Final Calculation";
        paymentSchedule: Record "Payment Schedule2";
        revenueStructure: Record "Revenue Structure";
        NewLineNo: Integer;
        StartDate, EndDate : Date;
        SuspendedDate, TerminationDate : Date;
        TotalPaidAmount, TotalInvoicedAmount, otherchargesvalue : Decimal;
        ItemTypes: List of [Text];
        ItemTypeFilter: Text;
        HasMatchingData: Boolean;
        TotalNoofDays: Integer;
        UnearnedNoofday: Integer;
        PerDayrent: Decimal;
        TotalMonthlyRevenue: Decimal;
        RevenueAllocatedDuringYear: Decimal;
        RevenueAllocation: Decimal;
        TotalEarnedAmount: Decimal;
        TotalCreditnode: Decimal;
        TotalCreditAmountIssued: Decimal;
        UnearnedRevenueAllocations: Decimal;
    begin
        ClearSubgridDataParking();

        StartDate := Rec."Starting Date Year";
        EndDate := Rec."Ending Date Year";

        GetSelectedItemTypes(ItemTypes);

        if ItemTypes.Count() = 0 then
            Error('Please select at least one Item Type before running the report.');

        ItemTypeFilter := GetItemTypeFilter(ItemTypes);

        tenancyContract.Reset();
        tenancyContract.SetFilter("Tenant Contract Status", '%1|%2|%3|%4|%5',
            tenancyContract."Tenant Contract Status"::Active,
            tenancyContract."Tenant Contract Status"::Terminated,
            tenancyContract."Tenant Contract Status"::Suspended,
            tenancyContract."Tenant Contract Status"::"Active-Contract Renewed",
            tenancyContract."Tenant Contract Status"::"Contract Renewed");

        tenancyContract.SetFilter("Contract Start Date", '..%1', EndDate);
        tenancyContract.SetFilter("Contract End Date", '%1..', StartDate);

        if tenancyContract.FindSet() then
            repeat
                Clear(unearnedRevenueBuffer);
                Clear(SuspendedReasonRec);
                Clear(FinalCalculationRec);
                TotalPaidAmount := 0;
                TotalInvoicedAmount := 0;
                TotalMonthlyRevenue := 0;
                RevenueAllocatedDuringYear := 0;
                otherchargesvalue := 0;
                HasMatchingData := false;

                // 🔹 If not found in payment schedule, check Revenue Structure
                if not HasMatchingData then begin
                    revenueStructure.Reset();
                    revenueStructure.SetRange("Contract ID", tenancyContract."Contract ID");
                    revenueStructure.SetFilter("Secondary Item Type", ItemTypeFilter);
                    if revenueStructure.FindFirst() then
                        HasMatchingData := true;
                end;

                // 🔹 Skip contract if no match found
                if not HasMatchingData then
                    continue;

                // 🔹 Sum Revenue Structure
                revenueStructure.Reset();
                revenueStructure.SetRange("Contract ID", tenancyContract."Contract ID");
                revenueStructure.SetFilter("Secondary Item Type", ItemTypeFilter);
                if revenueStructure.FindSet() then
                    repeat
                        otherchargesvalue := revenueStructure."Amount Including VAT";
                    until revenueStructure.Next() = 0;

                // 🔹 Sum Paid Amount before Start Date
                paymentSchedule.Reset();
                paymentSchedule.SetRange("Contract ID", tenancyContract."Contract ID");
                paymentSchedule.SetFilter("Secondary Item Type", ItemTypeFilter);
                paymentSchedule.SetRange("Due Date", tenancyContract."Contract Start Date", StartDate - 1);
                paymentSchedule.SetRange("Invoiced", true);
                if paymentSchedule.FindSet() then
                    repeat
                        TotalPaidAmount += paymentSchedule."Amount Including VAT";
                    until paymentSchedule.Next() = 0;



                paymentSchedule.Reset();
                paymentSchedule.SetRange("Contract ID", tenancyContract."Contract ID");
                paymentSchedule.SetFilter("Secondary Item Type", ItemTypeFilter);
                paymentSchedule.SetRange("Due Date", tenancyContract."Contract Start Date", StartDate - 1);
                paymentSchedule.SetRange("Payment Status", 'Received');
                if paymentSchedule.FindSet() then
                    repeat
                        TotalEarnedAmount += paymentSchedule."Amount Including VAT";
                    until paymentSchedule.Next() = 0;

                paymentSchedule.Reset();
                paymentSchedule.SetRange("Contract ID", tenancyContract."Contract ID");
                paymentSchedule.SetFilter("Secondary Item Type", ItemTypeFilter);
                paymentSchedule.SetRange("Due Date", tenancyContract."Contract Start Date", StartDate - 1);
                if paymentSchedule.FindSet() then
                    repeat
                        TotalCreditnode += paymentSchedule."Credit Note Amount";
                    until paymentSchedule.Next() = 0;


                // 🔹 Sum Invoiced Amount between StartDate and EndDate
                paymentSchedule.Reset();
                paymentSchedule.SetRange("Contract ID", tenancyContract."Contract ID");
                paymentSchedule.SetFilter("Secondary Item Type", ItemTypeFilter);
                paymentSchedule.SetRange("Due Date", StartDate, EndDate);
                paymentSchedule.SetRange("Invoiced", true);
                if paymentSchedule.FindSet() then
                    repeat
                        TotalInvoicedAmount += paymentSchedule."Amount Including VAT";
                    until paymentSchedule.Next() = 0;


                paymentSchedule.Reset();
                paymentSchedule.SetRange("Contract ID", tenancyContract."Contract ID");
                paymentSchedule.SetFilter("Secondary Item Type", ItemTypeFilter);
                paymentSchedule.SetRange("Due Date", StartDate, EndDate);
                paymentSchedule.SetRange("Invoiced", true);
                if paymentSchedule.FindSet() then
                    repeat
                        TotalCreditAmountIssued += paymentSchedule."Credit Note Amount";
                    until paymentSchedule.Next() = 0;

                // 🔹 Suspension and Termination Logic
                SuspendedDate := 0D;
                TerminationDate := 0D;
                if tenancyContract."Tenant Contract Status" = tenancyContract."Tenant Contract Status"::Suspended then begin
                    SuspendedReasonRec.Reset();
                    SuspendedReasonRec.SetRange("Contract ID", tenancyContract."Contract ID");
                    if SuspendedReasonRec.FindLast() then
                        SuspendedDate := SuspendedReasonRec.DateEffective;
                end;

                if tenancyContract."Tenant Contract Status" = tenancyContract."Tenant Contract Status"::Terminated then begin
                    FinalCalculationRec.Reset();
                    FinalCalculationRec.SetRange("Contract ID", tenancyContract."Contract ID");
                    if FinalCalculationRec.FindLast() then
                        TerminationDate := FinalCalculationRec."Termination Date";
                end;

                // 🔹 Insert into Buffer
                NewLineNo := GetNextLineNum();
                unearnedRevenueBuffer.Init();
                unearnedRevenueBuffer."Header No." := Rec."No.";
                unearnedRevenueBuffer."Line No." := NewLineNo;
                unearnedRevenueBuffer."Contract ID" := tenancyContract."Contract ID";
                unearnedRevenueBuffer."Start Date" := tenancyContract."Contract Start Date";
                unearnedRevenueBuffer."End Date" := tenancyContract."Contract End Date";
                unearnedRevenueBuffer."Customer Name" := tenancyContract."Customer Name";
                unearnedRevenueBuffer.Property := tenancyContract."Property Name";
                unearnedRevenueBuffer."Owner Name" := tenancyContract."Owner's Name";
                unearnedRevenueBuffer."Other Charges Value" := otherchargesvalue;
                unearnedRevenueBuffer."Contract Status" := Format(tenancyContract."Tenant Contract Status");
                unearnedRevenueBuffer."Opening Balance" := (TotalPaidAmount + TotalCreditnode) - TotalEarnedAmount;
                unearnedRevenueBuffer."Invoice Raised During the Year" := TotalInvoicedAmount + TotalCreditAmountIssued;
                unearnedRevenueBuffer."Suspension Date" := SuspendedDate;
                unearnedRevenueBuffer."Termination Date" := TerminationDate;

                case tenancyContract."Praposal Type Selected" of
                    tenancyContract."Praposal Type Selected"::"Single Unit":
                        unearnedRevenueBuffer."Unit Name" := COPYSTR(tenancyContract."Unit Name", 1, MAXSTRLEN(unearnedRevenueBuffer."Unit Name"));
                    tenancyContract."Praposal Type Selected"::"Merge Unit":
                        unearnedRevenueBuffer."Unit Name" := COPYSTR(tenancyContract."Single Unit Name", 1, MAXSTRLEN(unearnedRevenueBuffer."Unit Name"));
                    else
                        unearnedRevenueBuffer."Unit Name" := '';
                end;

                RevenueAllocation := CalculateRevenueAllocations(tenancyContract."Contract ID", Rec."Starting Date Year");
                unearnedRevenueBuffer."RevenueAllocated DuringtheYear" := RevenueAllocation;

                UnearnedRevenueAllocations := CalculateUnearnedRevenueAllocations(tenancyContract."Contract ID");
                unearnedRevenueBuffer."Unearned Revenue Balance" := UnearnedRevenueAllocations;

                if (tenancyContract."Tenant Contract Status" <> tenancyContract."Tenant Contract Status"::Terminated) and
   (tenancyContract."Tenant Contract Status" <> tenancyContract."Tenant Contract Status"::"Contract Renewed") then begin

                    TotalNoofDays := unearnedRevenueBuffer."End Date" - unearnedRevenueBuffer."Start Date" + 1;
                    PerDayrent := unearnedRevenueBuffer."Other Charges Value" / TotalNoofDays;
                    UnearnedNoofday := unearnedRevenueBuffer."End Date" - EndDate;
                    unearnedRevenueBuffer.CalculatedUnearnedRevBalance := PerDayrent * UnearnedNoofday;

                end else
                    unearnedRevenueBuffer.CalculatedUnearnedRevBalance := 0;

                unearnedRevenueBuffer."Shortfall/Excess" := unearnedRevenueBuffer."Unearned Revenue Balance" - unearnedRevenueBuffer.CalculatedUnearnedRevBalance;

                unearnedRevenueBuffer.Insert();
            until tenancyContract.Next() = 0;
    end;

    local procedure CalculateRevenueAllocations(ContractID: Integer; StartDate: Date): Decimal
    var
        RevenueAllocationRec: Record "Revenue Recognition Details"; // Replace with your actual table name
        TotalRevenueAllocated: Decimal;
        StartYear: Integer;
        ItemTypes: List of [Text];
        ItemTypeFilter: Text;
    begin
        TotalRevenueAllocated := 0;

        StartYear := Date2DMY(StartDate, 3);

        GetSelectedItemTypes(ItemTypes);
        ItemTypeFilter := GetItemTypeFilter(ItemTypes);


        // Method 1: If Revenue Allocation table has Contract ID field
        RevenueAllocationRec.Reset();
        RevenueAllocationRec.SetRange("Contract ID", ContractID);
        RevenueAllocationRec.SetRange("Posting Year", StartYear);
        RevenueAllocationRec.SetFilter(Description, '(%1|%2)', 'Regular', 'Credit Note');

        // Filter for months within the date range
        RevenueAllocationRec.SetFilter("Posting Month", GetMonthFilters(Rec."Starting Date Year", Rec."Ending Date Year"));
        RevenueAllocationRec.SetFilter("Item Type", ItemTypeFilter);
        if RevenueAllocationRec.FindSet() then
            repeat
                TotalRevenueAllocated += RevenueAllocationRec."Total Value";
            until RevenueAllocationRec.Next() = 0;

        exit(TotalRevenueAllocated);
    end;


    local procedure CalculateUnearnedRevenueAllocations(ContractID: Integer): Decimal
    var
        RevenueAllocationRec: Record "Revenue Recognition Details";
        RevenueAllocation: Record "Revenue Allocation Details";
        TotalEarnedRevenueAllocateds: Decimal;
        ItemTypes: List of [Text];
        ItemTypeFilter: Text;
    begin
        TotalEarnedRevenueAllocateds := 0;

        GetSelectedItemTypes(ItemTypes);
        ItemTypeFilter := GetItemTypeFilter(ItemTypes);

        // Step 1: Loop through Revenue Allocation Details with Status = Approve
        RevenueAllocation.Reset();
        RevenueAllocation.SetRange("Status", RevenueAllocation."Status"::Pending);

        if RevenueAllocation.FindSet() then
            repeat
                // Step 2: For each approved record, get related SubGrid records
                RevenueAllocationRec.Reset();
                RevenueAllocationRec.SetRange("RR_No.", RevenueAllocation."No."); // assuming this is the link
                RevenueAllocationRec.SetRange("Contract ID", ContractID);
                // RevenueAllocationRec.SetRange("Posting Year", StartYear);
                // RevenueAllocationRec.SetFilter("Posting Month", GetMonthFilter(Rec."Starting Date Year", Rec."Ending Date Year"));
                RevenueAllocationRec.SetFilter(Description, '(%1|%2)', 'Regular', 'Credit Note');


                if RevenueAllocationRec.FindSet() then
                    repeat
                        // Compare against Contract Start and End Date stored in RevenueAllocationRec
                        if (Rec."Starting Date Year" >= RevenueAllocationRec."Contract Start Date") and
                           (Rec."Starting Date Year" <= RevenueAllocationRec."Contract End Date") or
                           (Rec."Ending Date Year" >= RevenueAllocationRec."Contract Start Date") and
                           (Rec."Ending Date Year" <= RevenueAllocationRec."Contract End Date") then
                            TotalEarnedRevenueAllocateds += RevenueAllocationRec."Total Value";

                    until RevenueAllocationRec.Next() = 0;
            until RevenueAllocation.Next() = 0;

        exit(TotalEarnedRevenueAllocateds);
    end;

    local procedure GetMonthFilters(StartDate: Date; EndDate: Date): Text
    var
        FetchMonth: Codeunit "Fetch Month";
        EndMonth: Integer;
        MonthFilter: Text;
        CurrentDate: Date;
        MonthName: Text;
    begin
        EndMonth := Date2DMY(EndDate, 2);

        MonthFilter := '';
        CurrentDate := StartDate;

        while CurrentDate <= EndDate do begin
            MonthName := FetchMonth.GetMonthName(Date2DMY(CurrentDate, 2));

            if MonthFilter = '' then
                MonthFilter := MonthName
            else
                MonthFilter += '|' + MonthName;

            CurrentDate := CalcDate('<1M>', DMY2Date(1, Date2DMY(CurrentDate, 2), Date2DMY(CurrentDate, 3)));

            if Date2DMY(CurrentDate, 2) > EndMonth then
                break;
        end;

        exit(MonthFilter);
    end;

    local procedure GetSelectedItemTypes(var pItemTypes: List of [Text])
    var
        UnearnedRevenueItem: Record "Other Charges UnearnedRevenue";
    begin
        UnearnedRevenueItem.SetRange("No.", Rec."No.");
        if UnearnedRevenueItem.FindSet() then
            repeat
                if UnearnedRevenueItem."Item Type" <> '' then
                    if not pItemTypes.Contains(UnearnedRevenueItem."Item Type") then
                        pItemTypes.Add(UnearnedRevenueItem."Item Type");
            until UnearnedRevenueItem.Next() = 0;
    end;

    local procedure GetItemTypeFilter(pItemTypes: List of [Text]): Text
    var
        FilterText: Text;
        ItemType: Text;
    begin
        foreach ItemType in pItemTypes do
            if FilterText = '' then
                FilterText := ItemType
            else
                FilterText += '|' + ItemType;

        exit(FilterText);
    end;


    procedure GetNextLineNum(): Integer
    var
        unearnedRevenueBuffer: Record "Sub Unearned Charges";
        LastLineNo: Integer;
    begin
        unearnedRevenueBuffer.Reset();
        unearnedRevenueBuffer.SetRange("Header No.", Rec."No.");
        if unearnedRevenueBuffer.FindLast() then
            LastLineNo := unearnedRevenueBuffer."Line No."
        else
            LastLineNo := 0;

        exit(LastLineNo + 1);
    end;

    procedure ClearSubgridDataParking()
    var
        RevenueItemDetail: Record "Sub Unearned Charges";
    begin
        RevenueItemDetail.SetRange("Header No.", Rec."No."); // ✅ Clear only for this header
        RevenueItemDetail.DeleteAll(true);
    end;

    procedure CalculateAndStoreTotalRevenue()
    var
        SubUnearnedParkingReport: Record "Sub Unearned Charges";
    begin
        Clear(TotalOtherCharges);
        Clear(TotalOpeningBalance);
        Clear(TotalInvoiceraisedduringtheyear);
        Clear(Totalrevenueallocatedduringtheyear);
        Clear(Totalunearnedrevenuebalance);
        Clear(Totalcalculatedunearnedrevenuebalance);
        Clear(Totalshortfall);

        SubUnearnedParkingReport.SetRange("Header No.", Rec."No.");
        if SubUnearnedParkingReport.FindSet() then
            repeat
                TotalOtherCharges += SubUnearnedParkingReport."Other Charges Value";
                TotalOpeningBalance += SubUnearnedParkingReport."Opening Balance";
                TotalInvoiceraisedduringtheyear += SubUnearnedParkingReport."Invoice Raised During the Year";
                Totalrevenueallocatedduringtheyear += SubUnearnedParkingReport."RevenueAllocated DuringtheYear";
                Totalunearnedrevenuebalance += SubUnearnedParkingReport."Unearned Revenue Balance";
                Totalcalculatedunearnedrevenuebalance += SubUnearnedParkingReport.CalculatedUnearnedRevBalance;
                Totalshortfall += SubUnearnedParkingReport."Shortfall/Excess";
            until SubUnearnedParkingReport.Next() = 0;
    end;

    var
        TotalOpeningBalance: Decimal;
        TotalOtherCharges: Decimal;
        TotalInvoiceraisedduringtheyear: Decimal;
        Totalrevenueallocatedduringtheyear: Decimal;
        Totalunearnedrevenuebalance: Decimal;
        Totalcalculatedunearnedrevenuebalance: Decimal;
        Totalshortfall: Decimal;


    trigger OnAfterGetRecord()
    begin
        CurrPage."Other Charges Unearned Revenue".Page.SetNo(Rec."No.");
        CalculateAndStoreTotalRevenue();
    end;


    trigger OnModifyRecord(): Boolean
    begin
        CurrPage."Other Charges Unearned Revenue".Page.SetNo(Rec."No.");
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage."Other Charges Unearned Revenue".Page.SetNo(Rec."No.");
    end;
}