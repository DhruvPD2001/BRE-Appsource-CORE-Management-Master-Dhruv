page 50122 "Revenue Allocation Card"
{
    PageType = Card;
    SourceTable = "Revenue Allocation Details";
    ApplicationArea = All;
    Caption = 'Revenue Allocation Details';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Revenue Allocation Details';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the revenue allocation record.';
                    trigger OnValidate()
                    begin
                        if xRec."No." <> Rec."No." then
                            ClearSubgridData();
                    end;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the month for which the revenue allocation is being processed.';
                }
                field("Financial Year"; Rec."Financial Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the financial year for the revenue allocation.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the current status of the revenue allocation record.';
                }
            }
            group("Revenue Allocation Report Details")
            {
                Caption = 'Revenue Allocation Report Details';
                part("Revenue Allocation Details"; "Revenue Allocation SubGrid")
                {
                    SubPageLink = "Header No." = field("No.");
                }
            }
            group("Total Calculations")
            {
                Caption = 'Total Calculations(Rent)';
                field(TotalContractAmount; TotalContractAmount)
                {
                    Caption = 'Total Contract Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total contract amount for the revenue allocation.';
                }
                field(TotalAnnualAmount; TotalAnnualAmount)
                {
                    Caption = 'Total Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total annual amount for the revenue allocation.';
                }
                field(TotalFinalAnnualAmount; TotalFinalAnnualAmount)
                {
                    Caption = 'Total Final Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total final annual amount for the revenue allocation.';
                }
                field(TotalValue; TotalValue)
                {
                    Caption = 'Total Value';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total value for the revenue allocation.';
                }
            }

            group("Revenue Recognition Item")
            {
                Caption = 'Revenue Item Details';
                part("Revenue Recognition Item Details"; "Revenue Recognition Item Sub")
                {
                    SubPageLink = "RR_No." = field("No.");
                }
            }

            group("Revenue Recognition Detail")
            {
                Caption = 'Revenue Recognition Details';
                part("Revenue Recognition Details"; "Revenue Recognition Detail Sub")
                {
                    SubPageLink = "RR_No." = field("No.");
                }
            }
            group(" ")
            {
                Caption = 'Total Calculations(Other Charges)';
                field("Total Amount"; totalamounts)
                {
                    ApplicationArea = All;
                    Caption = 'Total Amount';
                    Editable = false;
                    ToolTip = 'Specifies the total amount for other charges in the revenue allocation.';
                }

                field("Total Annual Amount"; TotalAnnualAmounts)
                {
                    Caption = 'Total Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total annual amount for other charges in the revenue allocation.';
                }
                field("Total Final Annual Amount"; TotalFinalAnnualAmounts)
                {
                    Caption = 'Total Final Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total final annual amount for other charges in the revenue allocation.';
                }
                field("Total Contract Amount"; totalcontractAmounts)
                {
                    ApplicationArea = All;
                    Caption = 'Total Contract Amount';
                    Editable = false;
                    ToolTip = 'Specifies the total contract amount for other charges in the revenue allocation.';
                }
            }
            group("Final Amount")
            {
                Caption = 'Final Amount';

                field(TotalAnnualAmounts; totalcombinefinalamount)
                {
                    Caption = 'Total Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total annual amount for the final calculations in the revenue allocation.';
                }
                field(TotalFinalAnnualAmounts; totalcombinefinalannualamount)
                {
                    Caption = 'Total Final Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total final annual amount for the final calculations in the revenue allocation.';
                }
                field("Total Amounts"; totalcombineamounts)
                {
                    ApplicationArea = All;
                    Caption = 'Total Amount';
                    Editable = false;
                    ToolTip = 'Specifies the total amount for the final calculations in the revenue allocation.';
                }
                field("Total Contract Amounts"; totalcombinecontractAmounts)
                {
                    ApplicationArea = All;
                    Caption = 'Total Contract Amount';
                    Editable = false;
                    ToolTip = 'Specifies the total contract amount for the final calculations in the revenue allocation.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(FilterSubgrid)
            {
                ToolTip = 'Filter Subgrid';
                Caption = 'Revenue Allocation-Rent';
                Image = Filter;
                Enabled = Rec.Status = Rec.Status::Pending;
                trigger OnAction()
                var
                    companydata: Record "Company Data";
                begin
                    if companydata.FindFirst() then
                        if companydata."Revenue Methods" <> companydata."Revenue Methods"::" " then begin
                            FetchContracts(companydata."Revenue Methods");
                            CalculateTotals();
                        end
                        else
                            Message('First Select Revenue Method in Company Data Card');
                end;
            }
            action(RevenueAllocation)
            {
                ApplicationArea = All;
                Caption = 'Revenue Allocation Approval';
                Image = PostDocument;
                Enabled = Rec.Status = Rec.Status::Pending;
                ToolTip = 'Send Revenue Allocation Approval Request';

                trigger OnAction()
                var
                    Approvalrevenueallocation: Record "Revenue Allocation Approval";
                begin
                    if Rec."No." = 0 then
                        Error('No must be specified');

                    Approvalrevenueallocation.SetRange("ID", Rec."No.");

                    if Approvalrevenueallocation.FindSet() then begin
                        // Modify existing approval record
                        Approvalrevenueallocation."ID" := Rec."No.";
                        Approvalrevenueallocation."Month" := Rec."Month";
                        Approvalrevenueallocation."Financial Year" := Rec."Financial Year";
                        Approvalrevenueallocation."Status" := Rec."Status";
                        Approvalrevenueallocation.Modify();
                        Message('Approval Request Modified successfully!');
                    end else begin
                        // Insert new approval record
                        Approvalrevenueallocation.Init();
                        Approvalrevenueallocation."ID" := Rec."No.";
                        Approvalrevenueallocation."Financial Year" := Rec."Financial Year";
                        Approvalrevenueallocation."Month" := Rec."Month";
                        Approvalrevenueallocation."Status" := Rec."Status";
                        Approvalrevenueallocation.Insert();
                        Message('Approval Request Sent successfully!');
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearSubgridData();
    end;

    trigger OnAfterGetRecord()
    begin
        CalculateTotals();
        CurrPage."Revenue Recognition Item Details".Page.SetRIID(Rec."No.");
        CurrPage."Revenue Recognition Details".Page.SetRIID(Rec."No.");
    end;

    var
        TotalContractAmount: Decimal;
        TotalAnnualAmount: Decimal;
        TotalFinalAnnualAmount: Decimal;
        TotalValue: Decimal;


    procedure CalculateTotals()
    var
        FilteredContractRec: Record "Revenue Allocation SubGrid";
        SuspensionRec: Record SuspendReasonTable;
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
    begin
        // Reset totals
        TotalContractAmount := 0;
        TotalAnnualAmount := 0;
        TotalFinalAnnualAmount := 0;
        TotalValue := 0;

        // Get first and last day of selected month
        SelectedMonthStart := DMY2Date(1, Rec.Month, Rec."Financial Year");
        SelectedMonthEnd := CALCDATE('<CM>', SelectedMonthStart);

        // Filter records for the current header
        FilteredContractRec.Reset();
        FilteredContractRec.SetRange("Header No.", Rec."No.");

        // Calculate totals
        if FilteredContractRec.FindSet() then
            repeat
                // Check if the contract is suspended during the selected month
                SuspensionRec.Reset();
                SuspensionRec.SetRange("Contract ID", FilteredContractRec."Contract Id");
                SuspensionRec.SetFilter(DateEffective, '..%1', SelectedMonthEnd);
                SuspensionRec.SetFilter(SuspensionEndDate, '%1..', SelectedMonthStart);

                // Only add to totals if the contract is NOT suspended during the selected month
                if not SuspensionRec.FindFirst() then begin
                    TotalContractAmount += FilteredContractRec."Contract Amount";
                    TotalAnnualAmount += FilteredContractRec."Annual Amount";
                    TotalFinalAnnualAmount += FilteredContractRec."Final Annual Amount";
                    TotalValue += FilteredContractRec."Total Value";
                end;
            until FilteredContractRec.Next() = 0;

        CurrPage.Update(false);
    end;

    procedure CalculateDaysInSelectedMonth(
        ContractStartDate: Date;
        ContractEndDate: Date;
        MultiYearStartDate: Date;
        MultiYearEndDate: Date;
        SelectedMonth: Integer;
        SelectedYear: Integer): Integer
    var
        MonthStartDate: Date;
        MonthEndDate: Date;
        EffectiveStartDate: Date;
        EffectiveEndDate: Date;
    begin
        // Get first day of selected month (without +1, assuming SelectedMonth is correct)
        MonthStartDate := DMY2Date(1, SelectedMonth, SelectedYear);
        // Get last day of selected month
        MonthEndDate := CALCDATE('<+1M-1D>', MonthStartDate);

        // Return 0 if multi-year period is completely outside selected month
        if (MultiYearStartDate > MonthEndDate) or (MultiYearEndDate < MonthStartDate) then
            exit(0);

        // Determine effective start date for the month
        // Use the latest of: MonthStart, MultiYearStart, ContractStart
        EffectiveStartDate := MonthStartDate;
        if MultiYearStartDate > EffectiveStartDate then
            EffectiveStartDate := MultiYearStartDate;
        if ContractStartDate > EffectiveStartDate then
            EffectiveStartDate := ContractStartDate;

        // Determine effective end date for the month  
        // Use the earliest of: MonthEnd, MultiYearEnd, ContractEnd
        EffectiveEndDate := MonthEndDate;
        if MultiYearEndDate < EffectiveEndDate then
            EffectiveEndDate := MultiYearEndDate;
        if ContractEndDate < EffectiveEndDate then
            EffectiveEndDate := ContractEndDate;

        // Ensure we don't have invalid date range
        if EffectiveStartDate > EffectiveEndDate then
            exit(0);

        // Calculate inclusive number of days
        exit(EffectiveEndDate - EffectiveStartDate + 1);
    end;

    //---------------Clear Subgrid Data--------------//
    procedure ClearSubgridData()
    var
        FilteredContractRec: Record "Revenue Allocation SubGrid";
        revenueitem: Record "Revenue Recognition Item";
    begin
        FilteredContractRec.Reset();
        FilteredContractRec.SetRange("Header No.", Rec."No.");
        FilteredContractRec.DeleteAll();
        revenueitem.Reset();
        revenueitem.SetRange("RR_No.", Rec."No.");
        revenueitem.DeleteAll();
    end;


    //---------------Get Next LineNo--------------//
    procedure GetNextLineNo(): Integer
    var
        FilteredContractRec: Record "Revenue Allocation SubGrid";
        LastLineNo: Integer;
    begin
        FilteredContractRec.Reset();
        FilteredContractRec.SetRange("Header No.", Rec."No.");
        if FilteredContractRec.FindLast() then
            LastLineNo := FilteredContractRec."Line No."
        else
            LastLineNo := 0;
        exit(LastLineNo + 1);
    end;


    //---------------Should Keep Entry--------------//
    procedure ShouldKeepEntry(StartDate: Date; EndDate: Date): Boolean
    var
        LastDayOfMonth: Date;
        FirstDayOfMonth: Date;
    begin
        // Get first day of selected month
        FirstDayOfMonth := DMY2Date(1, Rec.Month, Rec."Financial Year");

        // Get last day of selected month
        LastDayOfMonth := CALCDATE('<+1M-1D>', FirstDayOfMonth);

        // Check if selected month's date range overlaps with the given date range
        // A period overlaps if:
        if (StartDate <= LastDayOfMonth) and (EndDate >= FirstDayOfMonth) then
            exit(true);

        exit(false);
    end;

    procedure InsertAllocationLine(
     ContractRec: Record "Tenancy Contract";
     MultiYearStartDate: Date;
     MultiYearEndDate: Date;
     NoOfDays: Integer;
     PerDayRent: Decimal;
     pTotalAnnualAmount: Decimal;
     OwnerShareAmount: Decimal;
     TerminationDate: Date;
     MonthNo: Integer;
     FinancialYear: Integer;
     RevenueMethod: Option "Per Day Rent","Fixed Monthly Rent")
    var
        FilteredContractRec: Record "Revenue Allocation SubGrid";
        SuspensionRec: Record SuspendReasonTable;
        CalculatedDays: Integer;
        NewLineNo: Integer;
        PerDayRentWithoutGracePeriod: Decimal;
        PerDayRentWithGracePeriod: Decimal;
        TotalContractDays: Integer;
        TotalContractDaysWithGrace: Integer;
        DifferencePerDayRent: Decimal;
        GracePeriodAdjustmentValue: Decimal;
        GridAnnualAmount: Decimal;
        GraceStartDate: Date;
        GraceEndDate: Date;
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
        ShouldInsertGraceLine: Boolean;
        AdjustedStartDate: Date; // 🔹 new
        AdjustedEndDate: Date;   // 🔹 new        
        SuspensionStartDate: Date;
        SuspensionEndDate: Date;
    begin
        // Check if entry should be kept based on date range
        if not ShouldKeepEntry(MultiYearStartDate, MultiYearEndDate) then
            exit;

        // Calculate selected month date range
        SelectedMonthStart := DMY2Date(1, MonthNo, FinancialYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Calculate grace period dates
        GraceStartDate := ContractRec."Grace Start Date";
        GraceEndDate := ContractRec."Grace End Date";

        ShouldInsertGraceLine := (ContractRec."Grace Period" > 0) and
                                (GraceStartDate <> 0D) and (GraceEndDate <> 0D) and
                                (GraceStartDate <= SelectedMonthEnd) and
                                (GraceEndDate >= SelectedMonthStart);

        // Get new line number
        NewLineNo := GetNextLineNo();

        // 🔹 NEW: Calculate AdjustedStartDate & AdjustedEndDate
        AdjustedStartDate := MultiYearStartDate;
        if AdjustedStartDate < SelectedMonthStart then
            AdjustedStartDate := SelectedMonthStart;

        AdjustedEndDate := MultiYearEndDate;
        if AdjustedEndDate > SelectedMonthEnd then
            AdjustedEndDate := SelectedMonthEnd;

        if (TerminationDate <> 0D) and (AdjustedEndDate > TerminationDate) then
            AdjustedEndDate := TerminationDate;

        // 🔹 Adjust for Suspension Start
        SuspensionRec.Reset();
        SuspensionRec.SetRange("Contract ID", ContractRec."Contract ID");
        if SuspensionRec.FindFirst() then begin
            SuspensionStartDate := SuspensionRec.DateEffective;
            SuspensionEndDate := SuspensionRec.SuspensionEndDate;
            // If suspension start date is within selected month
            if (SuspensionStartDate <> 0D) and
               (SuspensionStartDate >= SelectedMonthStart) and
               (SuspensionStartDate <= SelectedMonthEnd) then
                // Adjust end date to day before suspension
                AdjustedEndDate := SuspensionStartDate;


            // If suspension period overlaps with selected month
            if (SuspensionStartDate <> 0D) and (SuspensionEndDate <> 0D) then
                // Case 1: Suspension starts before selected month and ends during selected month
                if (SuspensionStartDate < SelectedMonthStart) and
                   (SuspensionEndDate >= SelectedMonthStart) and
                   (SuspensionEndDate <= SelectedMonthEnd) then begin
                    // Regular period starts after suspension ends
                    if (SuspensionEndDate + 1) <= SelectedMonthEnd then
                        AdjustedStartDate := SuspensionEndDate + 1
                    else
                        AdjustedStartDate := SelectedMonthEnd + 1; // No regular days
                end
                // Case 2: Suspension starts during selected month and ends after selected month
                else
                    if (SuspensionStartDate >= SelectedMonthStart) and
                            (SuspensionStartDate <= SelectedMonthEnd) and
                            ((SuspensionEndDate > SelectedMonthEnd) or (SuspensionEndDate = 0D)) then begin
                        // Regular period ends before suspension starts
                        if (SuspensionStartDate - 1) >= SelectedMonthStart then
                            AdjustedEndDate := SuspensionStartDate - 1
                        else
                            AdjustedEndDate := SelectedMonthStart - 1; // No regular days
                    end
                    // Case 3: Suspension starts and ends during selected month
                    else
                        if (SuspensionStartDate >= SelectedMonthStart) and
                                (SuspensionStartDate <= SelectedMonthEnd) and
                                (SuspensionEndDate >= SelectedMonthStart) and
                                (SuspensionEndDate <= SelectedMonthEnd) then begin
                            // For this case, we need to handle it differently
                            // This would require splitting into two periods (before and after suspension)
                            // For now, we'll take the period after suspension
                            if (SuspensionEndDate + 1) <= SelectedMonthEnd then
                                AdjustedStartDate := SuspensionEndDate + 1
                            else
                                AdjustedStartDate := SelectedMonthEnd + 1; // No regular days
                        end
                        // Case 4: Suspension covers entire selected month
                        else
                            if (SuspensionStartDate <= SelectedMonthStart) and
                                    (SuspensionEndDate >= SelectedMonthEnd) then begin
                                // No regular days in this month
                                AdjustedStartDate := SelectedMonthEnd + 1;
                                AdjustedEndDate := SelectedMonthStart - 1;
                            end;

        end;

        if (AdjustedStartDate <= AdjustedEndDate) then
            CalculatedDays := AdjustedEndDate - AdjustedStartDate + 1
        else
            CalculatedDays := 0;

        // Get the days in the specific grid record's date range
        TotalContractDays := MultiYearEndDate - MultiYearStartDate + 1;

        // Calculate Total Contract Days (with grace period)
        TotalContractDaysWithGrace := TotalContractDays + ContractRec."Grace Period";

        // Use the annual amount from the grid record instead of the main contract
        GridAnnualAmount := pTotalAnnualAmount;

        // Calculate Per Day Rent without Grace Period (using grid's annual amount)
        PerDayRentWithoutGracePeriod := Round(GridAnnualAmount / TotalContractDays);

        // Calculate Per Day Rent with Grace Period (using grid's annual amount)
        PerDayRentWithGracePeriod := Round(GridAnnualAmount / TotalContractDaysWithGrace);

        // Calculate the difference per day
        DifferencePerDayRent := PerDayRentWithoutGracePeriod - PerDayRentWithGracePeriod;

        // Calculate total adjustment value for the month
        GracePeriodAdjustmentValue := DifferencePerDayRent * CalculatedDays;

        // -----------------------------------------------
        // Insert main allocation line (without grace period adjustment)
        // -----------------------------------------------
        FilteredContractRec.Init();
        FilteredContractRec."Line No." := NewLineNo;
        FilteredContractRec."Header No." := Rec."No.";
        FilteredContractRec."Property Name" := ContractRec."Property Name";
        FilteredContractRec."Contract Id" := ContractRec."Contract ID";
        FilteredContractRec."Contract Tenure" := ContractRec."Contract Tenor";
        FilteredContractRec."Customer Name" := ContractRec."Customer Name";
        FilteredContractRec."Contract Start Date" := ContractRec."Contract Start Date";
        FilteredContractRec."Contract End Date" := ContractRec."Contract End Date";
        FilteredContractRec."Grace Days" := ContractRec."Grace Period";
        FilteredContractRec."Grace Start Date" := ContractRec."Grace Start Date";
        FilteredContractRec."Grace End Date" := ContractRec."Grace End Date";
        FilteredContractRec."Unit Type" := ContractRec."Usage Type";
        FilteredContractRec.Description := 'Regular';

        case
            ContractRec."Praposal Type Selected" of
            ContractRec."Praposal Type Selected"::"Single Unit":
                FilteredContractRec."Single Unit Names" := ContractRec."Unit Name";
            ContractRec."Praposal Type Selected"::"Merge Unit":
                FilteredContractRec."Single Unit Names" := ContractRec."Single Unit Name";
            else
                FilteredContractRec."Single Unit Names" := '';
        end;

        // Add Termination Date
        if TerminationDate = 0D then
            FilteredContractRec."Termination Date" := 0D
        else
            FilteredContractRec."Termination Date" := TerminationDate;

        SuspensionRec.Reset();
        SuspensionRec.SetRange("Contract ID", ContractRec."Contract ID");
        if SuspensionRec.FindFirst() then begin
            FilteredContractRec."Suspension Start Date" := SuspensionRec.DateEffective;
            FilteredContractRec."Suspension End Date" := SuspensionRec.SuspensionEndDate;
        end;

        FilteredContractRec."Multi Year Start Date" := MultiYearStartDate;
        FilteredContractRec."Multi Year End Date" := MultiYearEndDate;
        FilteredContractRec."No Of Days" := CalculatedDays;
        FilteredContractRec."Contract Amount" := ContractRec."Annual Rent Amount"; // Use grid's annual amount
        FilteredContractRec."Annual Amount" := GridAnnualAmount;
        FilteredContractRec."Final Annual Amount" := pTotalAnnualAmount;
        FilteredContractRec."Posting Month" := MonthNo;
        FilteredContractRec."Posting Year" := FinancialYear;

        if RevenueMethod = RevenueMethod::"Per Day Rent" then begin
            FilteredContractRec."Per Day Rent" := Round(PerDayRent); // Use the per day rent passed from the grid
            FilteredContractRec."Total Value" := CalculatedDays * FilteredContractRec."Per Day Rent";
            FilteredContractRec."Owner Share" := CalculatedDays * FilteredContractRec."Per Day Rent";
        end
        else begin
            FilteredContractRec."Per Month Rent" := CalculatePerMonthRent((FilteredContractRec."Final Annual Amount" / 12), CalculatedDays, MonthNo, FinancialYear); // Use the per day rent passed from the grid
            FilteredContractRec."Total Value" := FilteredContractRec."Per Month Rent";
            FilteredContractRec."Owner Share" := FilteredContractRec."Per Month Rent";
        end;


        FilteredContractRec."Posting Period" := Format(FilteredContractRec."Posting Month") +
            ' ' + Format(FilteredContractRec."Posting Year") + ' ' + '-' + ' ' +
            Format(FilteredContractRec."Posting Month") + ' ' + Format(FilteredContractRec."Posting Year");
        FilteredContractRec."Owner Name" := ContractRec."Owner's Name";
        FilteredContractRec.Insert();

        if ShouldInsertGraceLine then begin
            NewLineNo := GetNextLineNo();

            FilteredContractRec.Init();
            FilteredContractRec."Line No." := NewLineNo;
            FilteredContractRec."Header No." := Rec."No.";
            FilteredContractRec."Property Name" := ContractRec."Property Name";
            FilteredContractRec."Contract Id" := ContractRec."Contract ID";
            FilteredContractRec."Contract Tenure" := ContractRec."Contract Tenor";
            FilteredContractRec."Customer Name" := ContractRec."Customer Name";
            FilteredContractRec."Contract Start Date" := ContractRec."Contract Start Date";
            FilteredContractRec."Contract End Date" := ContractRec."Contract End Date";
            FilteredContractRec."Grace Days" := ContractRec."Grace Period";
            FilteredContractRec."Grace Start Date" := ContractRec."Grace Start Date";
            FilteredContractRec."Grace End Date" := ContractRec."Grace End Date";
            FilteredContractRec."Unit Type" := ContractRec."Usage Type";
            FilteredContractRec.Description := 'Grace Period';

            case
                ContractRec."Praposal Type Selected" of
                ContractRec."Praposal Type Selected"::"Single Unit":
                    FilteredContractRec."Single Unit Names" := ContractRec."Unit Name";
                ContractRec."Praposal Type Selected"::"Merge Unit":
                    FilteredContractRec."Single Unit Names" := ContractRec."Single Unit Name";
                else
                    FilteredContractRec."Single Unit Names" := '';
            end;

            // Add Termination Date
            if TerminationDate = 0D then
                FilteredContractRec."Termination Date" := 0D
            else
                FilteredContractRec."Termination Date" := TerminationDate;

            if SuspensionRec.FindFirst() then begin
                FilteredContractRec."Suspension Start Date" := SuspensionRec.DateEffective;
                FilteredContractRec."Suspension End Date" := SuspensionRec.SuspensionEndDate;
            end;

            FilteredContractRec."Multi Year Start Date" := MultiYearStartDate;
            FilteredContractRec."Multi Year End Date" := MultiYearEndDate;
            FilteredContractRec."No Of Days" := CalculatedDays;

            if RevenueMethod = RevenueMethod::"Per Day Rent" then
                FilteredContractRec."Per Day Rent" := -DifferencePerDayRent // Negative value
            else
                FilteredContractRec."Per Month Rent" := -DifferencePerDayRent; // Negative value

            FilteredContractRec."Contract Amount" := ContractRec."Annual Rent Amount"; // Use grid's annual amount
            FilteredContractRec."Annual Amount" := GridAnnualAmount;
            FilteredContractRec."Total Value" := -GracePeriodAdjustmentValue; // Negative adjustment
            FilteredContractRec."Owner Share" := -GracePeriodAdjustmentValue; // Negative adjustment
            FilteredContractRec."Final Annual Amount" := pTotalAnnualAmount;
            FilteredContractRec."Posting Month" := MonthNo;
            FilteredContractRec."Posting Year" := FinancialYear;
            FilteredContractRec."Posting Period" := Format(FilteredContractRec."Posting Month") +
                ' ' + Format(FilteredContractRec."Posting Year") + ' ' + '-' + ' ' +
                Format(FilteredContractRec."Posting Month") + ' ' + Format(FilteredContractRec."Posting Year");
            FilteredContractRec."Owner Name" := ContractRec."Owner's Name";
            // Add a description to indicate this is a grace period adjustment
            // FilteredContractRec."Description" := 'Grace Period Adjustment';
            FilteredContractRec.Insert();
        end;
    end;


    // Add this new helper procedure to handle missed revenue allocations
    procedure HandleMissedAllocation(
     ContractRec: Record "Tenancy Contract";
     MonthNo: Integer;
     FinancialYear: Integer;
     RevenueMethod: Option "Per Day Rent","Fixed Monthly Rent")
    var
        SingleUnitRent: Record "TC Single Unit Rent SubPage";
        MultiUnitRent: Record "TC Single LumAnnualAmnt SP";
        MergedSingleRent: Record "TC Merge SameSqure SubPage";
        MergedMultiRent: Record "TC Merge DifferentSq SubPage";
        SpecialRent: Record "TC Merge LumAnnualAmount SP";
        FinalCalculationRec: Record "Final Calculation";
        PreviousMonthNo: Integer;
        PreviousYearNo: Integer;
        PreviousMonthStart: Date;
        PreviousMonthEnd: Date;
        ContractStartDate: Date;
        TerminationDate: Date;
    begin
        // Calculate previous month and year
        if MonthNo = 1 then begin
            PreviousMonthNo := 12;
            PreviousYearNo := FinancialYear - 1;
        end else begin
            PreviousMonthNo := MonthNo - 1;
            PreviousYearNo := FinancialYear;
        end;

        // Calculate date ranges
        PreviousMonthStart := DMY2Date(1, PreviousMonthNo, PreviousYearNo);
        PreviousMonthEnd := CALCDATE('<CM>', PreviousMonthStart);
        ContractStartDate := ContractRec."Contract Start Date";

        // Check if contract started in previous month
        if (ContractStartDate >= PreviousMonthStart) and (ContractStartDate <= PreviousMonthEnd) then begin

            // Retrieve Termination Date from Final Calculation
            FinalCalculationRec.Reset();
            FinalCalculationRec.SetRange("Contract ID", ContractRec."Contract ID");
            if FinalCalculationRec.FindFirst() then
                TerminationDate := FinalCalculationRec."Termination Date"
            else
                TerminationDate := 0D;

            // Process each rent type for missed allocation
            // Check Single Unit Rent grid
            SingleUnitRent.Reset();
            SingleUnitRent.SetRange("Contract ID", ContractRec."Contract ID");
            if SingleUnitRent.FindSet() then
                repeat
                    if (SingleUnitRent."Start Date" <= PreviousMonthEnd) and (SingleUnitRent."End Date" >= ContractStartDate) then
                        InsertMissedAllocationLine(
                            ContractRec,
                            SingleUnitRent."Start Date",
                            SingleUnitRent."End Date",
                            SingleUnitRent."Number of Days",
                            SingleUnitRent."Per Day Rent",
                            SingleUnitRent."Final Annual Amount",
                            SingleUnitRent."Final Annual Amount",
                            TerminationDate,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd,
                            RevenueMethod);

                until SingleUnitRent.Next() = 0;


            // Check Multi Unit Rent grid
            MultiUnitRent.Reset();
            MultiUnitRent.SetRange("Contract ID", ContractRec."Contract ID");
            if MultiUnitRent.FindSet() then
                repeat
                    if (MultiUnitRent."SL_Start Date" <= PreviousMonthEnd) and (MultiUnitRent."SL_End Date" >= ContractStartDate) then
                        InsertMissedAllocationLine(
                            ContractRec,
                            MultiUnitRent."SL_Start Date",
                            MultiUnitRent."SL_End Date",
                            MultiUnitRent."SL_Number of Days",
                            MultiUnitRent."SL_Per Day Rent",
                            MultiUnitRent."SL_Final Annual Amount",
                            MultiUnitRent."SL_Final Annual Amount",
                            TerminationDate,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd,
                            RevenueMethod);

                until MultiUnitRent.Next() = 0;


            // Check Merged Single Rent grid
            MergedSingleRent.Reset();
            MergedSingleRent.SetRange("Contract ID", ContractRec."Contract ID");
            if MergedSingleRent.FindSet() then
                repeat
                    if (MergedSingleRent."MS_Start Date" <= PreviousMonthEnd) and (MergedSingleRent."MS_End Date" >= ContractStartDate) then
                        InsertMissedAllocationLine(
                            ContractRec,
                            MergedSingleRent."MS_Start Date",
                            MergedSingleRent."MS_End Date",
                            MergedSingleRent."MS_Number of Days",
                            MergedSingleRent."MS_Per Day Rent",
                            MergedSingleRent."MS_Final Annual Amount",
                            MergedSingleRent."MS_Final Annual Amount",
                            TerminationDate,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd,
                            RevenueMethod);

                until MergedSingleRent.Next() = 0;


            // Check Merged Multi Rent grid
            MergedMultiRent.Reset();
            MergedMultiRent.SetRange("Contract ID", ContractRec."Contract ID");
            if MergedMultiRent.FindSet() then
                repeat
                    if (MergedMultiRent."MD_Start Date" <= PreviousMonthEnd) and (MergedMultiRent."MD_End Date" >= ContractStartDate) then
                        InsertMissedAllocationLine(
                            ContractRec,
                            MergedMultiRent."MD_Start Date",
                            MergedMultiRent."MD_End Date",
                            MergedMultiRent."MD_Number of Days",
                            MergedMultiRent."MD_Per Day Rent",
                            MergedMultiRent."MD_Final Annual Amount",
                            MergedMultiRent."MD_Final Annual Amount",
                            TerminationDate,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd,
                            RevenueMethod);

                until MergedMultiRent.Next() = 0;


            // Check Special Rent grid
            SpecialRent.Reset();
            SpecialRent.SetRange("Contract ID", ContractRec."Contract ID");
            if SpecialRent.FindSet() then
                repeat
                    if (SpecialRent."ML_Start Date" <= PreviousMonthEnd) and (SpecialRent."ML_End Date" >= ContractStartDate) then
                        InsertMissedAllocationLine(
                            ContractRec,
                            SpecialRent."ML_Start Date",
                            SpecialRent."ML_End Date",
                            SpecialRent."ML_Number of Days",
                            SpecialRent."ML_Per Day Rent",
                            SpecialRent."ML_Final Annual Amount",
                            SpecialRent."ML_Final Annual Amount",
                            TerminationDate,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd,
                            RevenueMethod);

                until SpecialRent.Next() = 0;

        end;
    end;

    // Helper procedure to insert missed allocation lines
    // Helper procedure to insert missed allocation lines
    procedure InsertMissedAllocationLine(
     ContractRec: Record "Tenancy Contract";
     MultiYearStartDate: Date;
     MultiYearEndDate: Date;
     NoOfDays: Integer;
     PerDayRent: Decimal;
     pTotalAnnualAmount: Decimal;
     OwnerShareAmount: Decimal;
     TerminationDate: Date;
     PreviousMonthNo: Integer;
     PreviousYearNo: Integer;
     ContractStartDate: Date;
     PreviousMonthEnd: Date;
     RevenueMethod: Option "Per Day Rent","Fixed Monthly Rent")
    var
        FilteredContractRec: Record "Revenue Allocation SubGrid";
        SuspensionRec: Record SuspendReasonTable;
        FetchMonth: Codeunit "Fetch Month";
        NewLineNo: Integer;
        PerDayRentWithoutGracePeriod: Decimal;
        PerDayRentWithGracePeriod: Decimal;
        TotalContractDays: Integer;
        TotalContractDaysWithGrace: Integer;
        DifferencePerDayRent: Decimal;
        GracePeriodAdjustmentValue: Decimal;
        GridAnnualAmount: Decimal;
        MissedDays: Integer;
        // New variables for grace period date check
        GraceStartDate: Date;
        GraceEndDate: Date;
        ShouldInsertGraceLine: Boolean;
    begin
        // Calculate missed days
        MissedDays := PreviousMonthEnd - ContractStartDate + 1;

        // Get new line number
        NewLineNo := GetNextLineNo();

        // Use the annual amount from the grid record instead of the main contract
        GridAnnualAmount := pTotalAnnualAmount;

        // Calculate Total Contract Days
        TotalContractDays := MultiYearEndDate - MultiYearStartDate + 1;

        // Calculate Total Contract Days (with grace period)
        TotalContractDaysWithGrace := TotalContractDays + ContractRec."Grace Period";

        // Calculate Per Day Rent without Grace Period (using grid's annual amount)
        PerDayRentWithoutGracePeriod := Round(GridAnnualAmount / TotalContractDays);

        // Calculate Per Day Rent with Grace Period (using grid's annual amount)
        PerDayRentWithGracePeriod := Round(GridAnnualAmount / TotalContractDaysWithGrace);

        // Calculate the difference per day
        DifferencePerDayRent := PerDayRentWithoutGracePeriod - PerDayRentWithGracePeriod;

        // Calculate total adjustment value for the missed days
        GracePeriodAdjustmentValue := DifferencePerDayRent * MissedDays;

        // Calculate grace period dates
        GraceStartDate := ContractRec."Grace Start Date";
        GraceEndDate := ContractRec."Grace End Date";

        // Check if grace period falls within missed allocation period
        // Grace period should be inserted only if grace start date and grace end date 
        // overlap with the missed allocation period (contract start date to previous month end)
        ShouldInsertGraceLine := (ContractRec."Grace Period" > 0) and
                                (GraceStartDate <> 0D) and (GraceEndDate <> 0D) and
                                (GraceStartDate <= PreviousMonthEnd) and
                                (GraceEndDate >= ContractStartDate);

        // -----------------------------------------------
        // Insert missed allocation line (without grace period adjustment)
        // -----------------------------------------------
        FilteredContractRec.Init();
        FilteredContractRec."Line No." := NewLineNo;
        FilteredContractRec."Header No." := Rec."No.";
        FilteredContractRec."Property Name" := ContractRec."Property Name";
        FilteredContractRec."Contract Id" := ContractRec."Contract ID";
        FilteredContractRec."Contract Tenure" := ContractRec."Contract Tenor";
        FilteredContractRec."Customer Name" := ContractRec."Customer Name";
        FilteredContractRec."Contract Start Date" := ContractRec."Contract Start Date";
        FilteredContractRec."Contract End Date" := ContractRec."Contract End Date";
        FilteredContractRec."Grace Days" := ContractRec."Grace Period";
        FilteredContractRec."Grace Start Date" := ContractRec."Grace Start Date";
        FilteredContractRec."Grace End Date" := ContractRec."Grace End Date";
        FilteredContractRec."Unit Type" := ContractRec."Usage Type";
        FilteredContractRec.Description := 'Missed Revenue';

        case
            ContractRec."Praposal Type Selected" of
            ContractRec."Praposal Type Selected"::"Single Unit":
                FilteredContractRec."Single Unit Names" := ContractRec."Unit Name";
            ContractRec."Praposal Type Selected"::"Merge Unit":
                FilteredContractRec."Single Unit Names" := ContractRec."Single Unit Name";
            else
                FilteredContractRec."Single Unit Names" := '';
        end;

        // Add Termination Date
        if TerminationDate = 0D then
            FilteredContractRec."Termination Date" := 0D
        else
            FilteredContractRec."Termination Date" := TerminationDate;

        SuspensionRec.Reset();
        SuspensionRec.SetRange("Contract ID", ContractRec."Contract ID");
        if SuspensionRec.FindFirst() then begin
            FilteredContractRec."Suspension Start Date" := SuspensionRec.DateEffective;
            FilteredContractRec."Suspension End Date" := SuspensionRec.SuspensionEndDate;
        end;

        FilteredContractRec."Multi Year Start Date" := MultiYearStartDate;
        FilteredContractRec."Multi Year End Date" := MultiYearEndDate;
        FilteredContractRec."No Of Days" := MissedDays;
        FilteredContractRec."Contract Amount" := ContractRec."Annual Rent Amount"; // Use grid's annual amount
        FilteredContractRec."Annual Amount" := GridAnnualAmount;
        FilteredContractRec."Final Annual Amount" := pTotalAnnualAmount;

        if RevenueMethod = RevenueMethod::"Per Day Rent" then begin
            FilteredContractRec."Per Day Rent" := Round(PerDayRent);
            FilteredContractRec."Total Value" := MissedDays * FilteredContractRec."Per Day Rent";
            FilteredContractRec."Owner Share" := MissedDays * FilteredContractRec."Per Day Rent";
        end
        else begin
            FilteredContractRec."Per Month Rent" := CalculatePerMonthRent((FilteredContractRec."Final Annual Amount" / 12), MissedDays, PreviousMonthNo, PreviousYearNo);
            FilteredContractRec."Total Value" := FilteredContractRec."Per Month Rent";
            FilteredContractRec."Owner Share" := FilteredContractRec."Per Month Rent";
        end;


        FilteredContractRec."Posting Month" := PreviousMonthNo;
        FilteredContractRec."Posting Year" := PreviousYearNo;
        FilteredContractRec."Posting Period" := FetchMonth.GetMonthName(PreviousMonthNo) + ' ' +
            Format(PreviousYearNo) + ' ' + '-' + ' ' + FetchMonth.GetMonthName(PreviousMonthNo) + ' ' + Format(PreviousYearNo);
        FilteredContractRec."Owner Name" := ContractRec."Owner's Name";
        FilteredContractRec.Insert();

        // -----------------------------------------------
        // Insert grace period adjustment line (negative allocation) for missed days
        // Only if grace period dates overlap with the missed allocation period
        // -----------------------------------------------
        if ShouldInsertGraceLine then begin
            NewLineNo := GetNextLineNo();

            FilteredContractRec.Init();
            FilteredContractRec."Line No." := NewLineNo;
            FilteredContractRec."Header No." := Rec."No.";
            FilteredContractRec."Property Name" := ContractRec."Property Name";
            FilteredContractRec."Contract Id" := ContractRec."Contract ID";
            FilteredContractRec."Contract Tenure" := ContractRec."Contract Tenor";
            FilteredContractRec."Customer Name" := ContractRec."Customer Name";
            FilteredContractRec."Contract Start Date" := ContractRec."Contract Start Date";
            FilteredContractRec."Contract End Date" := ContractRec."Contract End Date";
            FilteredContractRec."Grace Days" := ContractRec."Grace Period";
            FilteredContractRec."Grace Start Date" := ContractRec."Grace Start Date";
            FilteredContractRec."Grace End Date" := ContractRec."Grace End Date";
            FilteredContractRec."Unit Type" := ContractRec."Usage Type";
            FilteredContractRec.Description := 'Grace Period';

            case
                ContractRec."Praposal Type Selected" of
                ContractRec."Praposal Type Selected"::"Single Unit":
                    FilteredContractRec."Single Unit Names" := ContractRec."Unit Name";
                ContractRec."Praposal Type Selected"::"Merge Unit":
                    FilteredContractRec."Single Unit Names" := ContractRec."Single Unit Name";
                else
                    FilteredContractRec."Single Unit Names" := '';
            end;

            // Add Termination Date
            if TerminationDate = 0D then
                FilteredContractRec."Termination Date" := 0D
            else
                FilteredContractRec."Termination Date" := TerminationDate;

            if SuspensionRec.FindFirst() then begin
                FilteredContractRec."Suspension Start Date" := SuspensionRec.DateEffective;
                FilteredContractRec."Suspension End Date" := SuspensionRec.SuspensionEndDate;
            end;

            FilteredContractRec."Multi Year Start Date" := MultiYearStartDate;
            FilteredContractRec."Multi Year End Date" := MultiYearEndDate;
            FilteredContractRec."No Of Days" := MissedDays;

            if RevenueMethod = RevenueMethod::"Per Day Rent" then
                FilteredContractRec."Per Day Rent" := -DifferencePerDayRent
            else
                FilteredContractRec."Per Month Rent" := -DifferencePerDayRent;

            FilteredContractRec."Contract Amount" := ContractRec."Annual Rent Amount";
            FilteredContractRec."Annual Amount" := GridAnnualAmount;
            FilteredContractRec."Total Value" := -GracePeriodAdjustmentValue;
            FilteredContractRec."Owner Share" := -GracePeriodAdjustmentValue;
            FilteredContractRec."Final Annual Amount" := pTotalAnnualAmount;
            FilteredContractRec."Posting Month" := PreviousMonthNo;
            FilteredContractRec."Posting Year" := PreviousYearNo;
            FilteredContractRec."Posting Period" := FetchMonth.GetMonthName(PreviousMonthNo) + ' ' +
                Format(PreviousYearNo) + ' ' + '-' + ' ' + FetchMonth.GetMonthName(PreviousMonthNo) + ' ' + Format(PreviousYearNo);
            FilteredContractRec."Owner Name" := ContractRec."Owner's Name";
            FilteredContractRec.Insert();
        end;
    end;

    //---------------Fetch Contracts--------------//

    // Then modify the FetchContracts procedure to use this
    procedure FetchContracts(RevenueMethod: Option "Per Day Rent","Fixed Monthly Rent")
    var
        ContractRec: Record "Tenancy Contract";                     // Main contract record
        SuspensionRec: Record SuspendReasonTable;                   // Suspension information
        FinalCalculationRec: Record "Final Calculation";            // Final calculation data

        // Rent type record variables
        SingleUnitRent: Record "TC Single Unit Rent SubPage";        // Single unit rent records
        MultiUnitRent: Record "TC Single LumAnnualAmnt SP";         // Multi unit rent records
        MergedSingleRent: Record "TC Merge SameSqure SubPage";      // Merged single rent records
        MergedMultiRent: Record "TC Merge DifferentSq SubPage";     // Merged multi rent records
        SpecialRent: Record "TC Merge LumAnnualAmount SP";          // Special rent records

        // Date and calculation variables
        SelectedMonthStart: Date;                                   // First day of selected month
        SelectedMonthEnd: Date;                                     // Last day of selected month
        MonthNo: Integer;                                           // Selected month number
        FinancialYear: Integer;                                     // Line number for allocations
        TerminationDate: Date;                                      // Contract termination date
        SuspensionDate: Date;
        ShouldProcessContract: Boolean;                             // Flag to determine if contract should be processed
    begin
        // Clear any existing allocation data before processing
        ClearSubgridData();

        // Get month and year from current record
        MonthNo := Rec.Month;
        FinancialYear := Rec."Financial Year";

        // Calculate date range for the selected month
        SelectedMonthStart := DMY2Date(01, MonthNo, FinancialYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Filter contracts to include both Active and Terminated contracts
        ContractRec.SetFilter(ContractRec."Tenant Contract Status", '%1|%2|%3',
            ContractRec."Tenant Contract Status"::Active,
            ContractRec."Tenant Contract Status"::Terminated,
            ContractRec."Tenant Contract Status"::Suspended);

        if ContractRec.FindSet() then
            repeat
                // Flag to determine if contract should be processed
                TerminationDate := 0D;
                SuspensionDate := 0D;
                ShouldProcessContract := false;

                // Get termination date from Final Calculation table first
                FinalCalculationRec.Reset();
                FinalCalculationRec.SetRange("Contract ID", ContractRec."Contract ID");
                if FinalCalculationRec.FindFirst() then
                    TerminationDate := FinalCalculationRec."Termination Date"
                else
                    TerminationDate := 0D;

                // Get Suspension Start Date - FIXED: Better error handling
                SuspensionRec.Reset();
                SuspensionRec.SetRange("Contract ID", ContractRec."Contract ID");
                if SuspensionRec.FindFirst() then
                    SuspensionDate := SuspensionRec.DateEffective
                else
                    SuspensionDate := 0D;  // Explicitly set to 0D if not found

                // Check contract status and decide if it should be processed
                case ContractRec."Tenant Contract Status" of
                    ContractRec."Tenant Contract Status"::Active:
                        ShouldProcessContract := true;

                    ContractRec."Tenant Contract Status"::Terminated:
                        if (TerminationDate >= SelectedMonthStart) and (TerminationDate <= SelectedMonthEnd) then
                            ShouldProcessContract := true;

                    ContractRec."Tenant Contract Status"::Suspended:
                        // FIXED: Added null date check and improved logic
                        if (SuspensionDate <> 0D) and
                           (SuspensionDate >= SelectedMonthStart) and
                           (SuspensionDate <= SelectedMonthEnd) then
                            ShouldProcessContract := true;
                end;

                // Process contract only if it meets the criteria
                if ShouldProcessContract then
                    if ((ContractRec."Contract Start Date" <= SelectedMonthEnd) and
                        (ContractRec."Contract End Date" >= SelectedMonthStart)) then begin

                        // Handle missed allocation from previous month (if contract started mid-month)
                        HandleMissedAllocation(ContractRec, MonthNo, FinancialYear, RevenueMethod);

                        // Handle suspension recovery allocation (new functionality)
                        HandleSuspensionRecoveryAllocation(ContractRec, MonthNo, FinancialYear, RevenueMethod);

                        // Process Single Unit Rent records
                        SingleUnitRent.Reset();
                        SingleUnitRent.SetRange("Contract ID", ContractRec."Contract ID");
                        if SingleUnitRent.FindSet() then
                            repeat
                                // Create allocation line for this Single Unit Rent record
                                InsertAllocationLine(
                                    ContractRec,
                                    SingleUnitRent."Start Date",
                                    SingleUnitRent."End Date",
                                    SingleUnitRent."Number of Days",
                                    SingleUnitRent."Per Day Rent",
                                    SingleUnitRent."Final Annual Amount",
                                    SingleUnitRent."Final Annual Amount",
                                    TerminationDate,
                                    // Use sequential number
                                    MonthNo,
                                    FinancialYear,
                                    RevenueMethod);
                            // LineNo += 1;  // Increment by 1
                            until SingleUnitRent.Next() = 0;


                        // Check Multi Unit Rent grid
                        MultiUnitRent.Reset();
                        MultiUnitRent.SetRange("Contract ID", ContractRec."Contract ID");
                        if MultiUnitRent.FindSet() then
                            repeat
                                // Create allocation line for this Multi Unit Rent record
                                InsertAllocationLine(
                                    ContractRec,
                                    MultiUnitRent."SL_Start Date",
                                    MultiUnitRent."SL_End Date",
                                    MultiUnitRent."SL_Number of Days",
                                    MultiUnitRent."SL_Per Day Rent",
                                    MultiUnitRent."SL_Final Annual Amount",
                                    MultiUnitRent."SL_Final Annual Amount",
                                    TerminationDate,
                                    // Use sequential number
                                    MonthNo,
                                    FinancialYear,
                                    RevenueMethod);
                            // LineNo += 1;  // Increment by 1
                            until MultiUnitRent.Next() = 0;


                        // Check Merged Single Rent grid
                        MergedSingleRent.Reset();
                        MergedSingleRent.SetRange("Contract ID", ContractRec."Contract ID");
                        if MergedSingleRent.FindSet() then
                            repeat
                                // Create allocation line for this Merged Single Rent record
                                InsertAllocationLine(
                                    ContractRec,
                                    MergedSingleRent."MS_Start Date",
                                    MergedSingleRent."MS_End Date",
                                    MergedSingleRent."MS_Number of Days",
                                    MergedSingleRent."MS_Per Day Rent",
                                    MergedSingleRent."MS_Final Annual Amount",
                                    MergedSingleRent."MS_Final Annual Amount",
                                    TerminationDate,
                                    // Use sequential number
                                    MonthNo,
                                    FinancialYear,
                                    RevenueMethod);
                            // LineNo += 1;  // Increment by 1
                            until MergedSingleRent.Next() = 0;


                        // Check Merged Multi Rent grid
                        MergedMultiRent.Reset();
                        MergedMultiRent.SetRange("Contract ID", ContractRec."Contract ID");
                        if MergedMultiRent.FindSet() then
                            repeat
                                // Create allocation line for this Merged Multi Rent record
                                InsertAllocationLine(
                                    ContractRec,
                                    MergedMultiRent."MD_Start Date",
                                    MergedMultiRent."MD_End Date",
                                    MergedMultiRent."MD_Number of Days",
                                    MergedMultiRent."MD_Per Day Rent",
                                    MergedMultiRent."MD_Final Annual Amount",
                                    MergedMultiRent."MD_Final Annual Amount",
                                    TerminationDate,
                                    // Use sequential number
                                    MonthNo,
                                    FinancialYear,
                                    RevenueMethod);
                            // LineNo += 1;  // Increment by 1
                            until MergedMultiRent.Next() = 0;


                        // Check Special Rent grid
                        SpecialRent.Reset();
                        SpecialRent.SetRange("Contract ID", ContractRec."Contract ID");
                        if SpecialRent.FindSet() then
                            repeat
                                // Create allocation line for this Special Rent record
                                InsertAllocationLine(
                                    ContractRec,
                                    SpecialRent."ML_Start Date",
                                    SpecialRent."ML_End Date",
                                    SpecialRent."ML_Number of Days",
                                    SpecialRent."ML_Per Day Rent",
                                    SpecialRent."ML_Final Annual Amount",
                                    SpecialRent."ML_Final Annual Amount",
                                    TerminationDate,
                                    // Use sequential number
                                    MonthNo,
                                    FinancialYear,
                                    RevenueMethod);
                            // LineNo += 1;  // Increment by 1
                            until SpecialRent.Next() = 0;

                    end;

            until ContractRec.Next() = 0;


        ProcessCreditNoteEntries(SelectedMonthStart, SelectedMonthEnd, MonthNo, FinancialYear, RevenueMethod);

        CalculateTotals();
    end;


    // New procedure to process credit note entries with debugging
    procedure ProcessCreditNoteEntries(SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
        MonthNo: Integer;
        FinancialYear: Integer;
        RevenueMethod: Option "Per Day Rent","Fixed Monthly Rent")
    var
        RequestCreditNotegrid: Record "Request Credit Note Grid";
        RequestCreditNotegridFromCN: Record "Request Credit Note Grid";
        RequestCreditNote: Record "Request Credit Note";
        ContractRec: Record "Tenancy Contract";
        FilteredContractRec: Record "Revenue Allocation SubGrid";
        ExistingRevenueRec: Record "Revenue Allocation SubGrid";
        paymentschedule: Record "Payment Schedule2";
        SuspensionRec: Record SuspendReasonTable;
        ShouldProcessCreditNote: Boolean;
        NewLineNo: Integer;
        CalculatedDays: Integer;
        MultiYearStartDate: Date;
        MultiYearEndDate: Date;
        Noofdays: Integer;
        RentReductionAmount: Decimal;
    begin
        // Debug: Check if credit note table has records
        RequestCreditNotegrid.Reset();
        if RequestCreditNotegrid.FindSet() then
            repeat
                if not RequestCreditNote.Get(RequestCreditNotegrid."Request No.") then
                    exit;
                if RequestCreditNote.Status = RequestCreditNote.Status::Approved then begin

                    RentReductionAmount := 0;
                    RequestCreditNotegridFromCN.SetRange("Request No.", RequestCreditNote."Request No.");
                    RequestCreditNotegridFromCN.SetFilter("Secondary Item Type", '%1', 'Rent');
                    if RequestCreditNotegridFromCN.FindFirst() then
                        RentReductionAmount := RequestCreditNotegridFromCN."Total Reduction"
                    else
                        exit;

                    NewLineNo := GetNextLineNo();

                    ShouldProcessCreditNote := false;

                    ContractRec.Reset();
                    ContractRec.SetRange("Contract ID", RequestCreditNotegridFromCN."Contract ID");
                    ContractRec.SetRange("Tenant Contract Status", ContractRec."Tenant Contract Status"::Active);
                    if ContractRec.FindFirst() then
                        paymentschedule.SetRange("Contract ID", ContractRec."Contract ID");
                    paymentschedule.SetRange("Payment Series", RequestCreditNotegridFromCN."Payment Series");
                    paymentschedule.SetRange("Secondary Item Type", 'Rent');
                    if paymentschedule.FindFirst() then
                        if ((ContractRec."Contract Start Date" <= SelectedMonthEnd) and
                                (ContractRec."Contract End Date" >= SelectedMonthStart)) then
                            ShouldProcessCreditNote := true;

                    if ShouldProcessCreditNote then begin
                        FilteredContractRec.Reset();
                        FilteredContractRec.Init();

                        FilteredContractRec."Line No." := NewLineNo;
                        FilteredContractRec."Header No." := Rec."No.";
                        FilteredContractRec."Contract ID" := RequestCreditNotegridFromCN."Contract ID";
                        FilteredContractRec."Property Name" := ContractRec."Property Name";
                        FilteredContractRec."Contract Tenure" := ContractRec."Contract Tenor";
                        FilteredContractRec."Unit Type" := ContractRec."Usage Type";
                        FilteredContractRec."Customer Name" := ContractRec."Customer Name";
                        FilteredContractRec."Contract Start Date" := ContractRec."Contract Start Date";
                        FilteredContractRec."Contract End Date" := ContractRec."Contract End Date";
                        FilteredContractRec."Grace Days" := ContractRec."Grace Period";
                        FilteredContractRec."Grace Start Date" := ContractRec."Grace Start Date";
                        FilteredContractRec."Grace End Date" := ContractRec."Grace End Date";

                        case ContractRec."Praposal Type Selected" of
                            ContractRec."Praposal Type Selected"::"Single Unit":
                                FilteredContractRec."Single Unit Names" := ContractRec."Unit Name";
                            ContractRec."Praposal Type Selected"::"Merge Unit":
                                FilteredContractRec."Single Unit Names" := ContractRec."Single Unit Name";
                            else
                                FilteredContractRec."Single Unit Names" := '';
                        end;

                        FilteredContractRec."Termination Date" := 0D;

                        SuspensionRec.Reset();
                        SuspensionRec.SetRange("Contract ID", ContractRec."Contract ID");
                        if SuspensionRec.FindFirst() then begin
                            FilteredContractRec."Suspension Start Date" := SuspensionRec.DateEffective;
                            FilteredContractRec."Suspension End Date" := SuspensionRec.SuspensionEndDate;
                        end;

                        ExistingRevenueRec.Reset();
                        ExistingRevenueRec.SetRange("Contract ID", FilteredContractRec."Contract ID");
                        if ExistingRevenueRec.FindFirst() then begin
                            MultiYearStartDate := ExistingRevenueRec."Multi Year Start Date";
                            MultiYearEndDate := ExistingRevenueRec."Multi Year End Date";
                            Noofdays := ExistingRevenueRec."No Of Days";
                        end;

                        FilteredContractRec."Multi Year Start Date" := MultiYearStartDate;
                        FilteredContractRec."Multi Year End Date" := MultiYearEndDate;
                        CalculatedDays := (FilteredContractRec."Multi Year End Date" - FilteredContractRec."Multi Year Start Date" + 1);

                        FilteredContractRec."No Of Days" := Noofdays;
                        FilteredContractRec."Posting Month" := MonthNo;
                        FilteredContractRec."Posting Year" := FinancialYear;
                        FilteredContractRec."Posting Period" := Format(FilteredContractRec."Posting Month") +
              ' ' + Format(FilteredContractRec."Posting Year") + ' ' + '-' + ' ' +
              Format(FilteredContractRec."Posting Month") + ' ' + Format(FilteredContractRec."Posting Year");
                        FilteredContractRec."Owner Name" := ContractRec."Owner's Name";
                        FilteredContractRec."Contract Amount" := -RentReductionAmount;
                        FilteredContractRec."Annual Amount" := -RentReductionAmount;
                        FilteredContractRec."Final Annual Amount" := -RentReductionAmount;

                        if RevenueMethod = RevenueMethod::"Per Day Rent" then begin
                            FilteredContractRec."Per Day Rent" := Round(FilteredContractRec."Annual Amount" / CalculatedDays);
                            FilteredContractRec."Total Value" := FilteredContractRec."Per Day Rent" * Noofdays;
                            FilteredContractRec."Owner Share" := FilteredContractRec."Per Day Rent" * Noofdays;
                        end
                        else begin
                            FilteredContractRec."Per Month Rent" := CalculatePerMonthRent((FilteredContractRec."Final Annual Amount" / 12), Noofdays, MonthNo, FinancialYear);
                            FilteredContractRec."Total Value" := FilteredContractRec."Per Month Rent";
                            FilteredContractRec."Owner Share" := FilteredContractRec."Per Month Rent";
                        end;
                        FilteredContractRec."Description" := 'Credit Note';
                        FilteredContractRec.Insert();
                    end;
                end;
            until RequestCreditNotegrid.Next() = 0;
    end;

    procedure HandleSuspensionRecoveryAllocation(
    ContractRec: Record "Tenancy Contract";
    MonthNo: Integer;
    FinancialYear: Integer;
    RevenueMethod: Option "Per Day Rent","Fixed Monthly Rent")
    var
        SuspensionRec: Record SuspendReasonTable;
        SingleUnitRent: Record "TC Single Unit Rent SubPage";
        MultiUnitRent: Record "TC Single LumAnnualAmnt SP";
        MergedSingleRent: Record "TC Merge SameSqure SubPage";
        MergedMultiRent: Record "TC Merge DifferentSq SubPage";
        SpecialRent: Record "TC Merge LumAnnualAmount SP";
        FinalCalculationRec: Record "Final Calculation";
        CurrentMonthStart: Date;
        CurrentMonthEnd: Date;
        SuspensionStartDate: Date;
        SuspensionEndDate: Date;
        RecoveryStartDate: Date;
        RecoveryEndDate: Date;
        TerminationDate: Date;
    begin
        CurrentMonthStart := DMY2Date(1, MonthNo, FinancialYear);
        CurrentMonthEnd := CALCDATE('<CM>', CurrentMonthStart);

        SuspensionRec.Reset();
        SuspensionRec.SetRange("Contract ID", ContractRec."Contract ID");

        if SuspensionRec.FindFirst() then begin
            SuspensionStartDate := SuspensionRec.DateEffective;
            SuspensionEndDate := SuspensionRec.SuspensionEndDate;

            if (SuspensionStartDate <> 0D) and (SuspensionEndDate <> 0D) and
              (((SuspensionEndDate >= CurrentMonthStart) and (SuspensionEndDate < CurrentMonthEnd)) OR
                (SuspensionEndDate = CurrentMonthStart - 1)) then begin

                RecoveryStartDate := SuspensionStartDate;
                RecoveryEndDate := SuspensionEndDate;

                FinalCalculationRec.Reset();
                FinalCalculationRec.SetRange("Contract ID", ContractRec."Contract ID");
                if FinalCalculationRec.FindFirst() then
                    TerminationDate := FinalCalculationRec."Termination Date"
                else
                    TerminationDate := 0D;

                SingleUnitRent.Reset();
                SingleUnitRent.SetRange("Contract ID", ContractRec."Contract ID");
                if SingleUnitRent.FindSet() then
                    repeat
                        if (SingleUnitRent."Start Date" <= RecoveryEndDate) and (SingleUnitRent."End Date" >= RecoveryStartDate) then
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                SingleUnitRent."Start Date",
                                SingleUnitRent."End Date",
                                SingleUnitRent."Number of Days",
                                SingleUnitRent."Per Day Rent",
                                SingleUnitRent."Final Annual Amount",
                                SingleUnitRent."Final Annual Amount",
                                TerminationDate,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Single Unit Rent Recovery',
                                RevenueMethod);

                    until SingleUnitRent.Next() = 0;

                MultiUnitRent.Reset();
                MultiUnitRent.SetRange("Contract ID", ContractRec."Contract ID");
                if MultiUnitRent.FindSet() then
                    repeat
                        if (MultiUnitRent."SL_Start Date" <= RecoveryEndDate) and (MultiUnitRent."SL_End Date" >= RecoveryStartDate) then
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                MultiUnitRent."SL_Start Date",
                                MultiUnitRent."SL_End Date",
                                MultiUnitRent."SL_Number of Days",
                                MultiUnitRent."SL_Per Day Rent",
                                MultiUnitRent."SL_Final Annual Amount",
                                MultiUnitRent."SL_Final Annual Amount",
                                TerminationDate,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Multi Unit Rent Recovery',
                                RevenueMethod);

                    until MultiUnitRent.Next() = 0;

                MergedSingleRent.Reset();
                MergedSingleRent.SetRange("Contract ID", ContractRec."Contract ID");
                if MergedSingleRent.FindSet() then
                    repeat
                        if (MergedSingleRent."MS_Start Date" <= RecoveryEndDate) and (MergedSingleRent."MS_End Date" >= RecoveryStartDate) then
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                MergedSingleRent."MS_Start Date",
                                MergedSingleRent."MS_End Date",
                                MergedSingleRent."MS_Number of Days",
                                MergedSingleRent."MS_Per Day Rent",
                                MergedSingleRent."MS_Final Annual Amount",
                                MergedSingleRent."MS_Final Annual Amount",
                                TerminationDate,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Merged Single Rent Recovery',
                                RevenueMethod);

                    until MergedSingleRent.Next() = 0;

                MergedMultiRent.Reset();
                MergedMultiRent.SetRange("Contract ID", ContractRec."Contract ID");
                if MergedMultiRent.FindSet() then
                    repeat
                        if (MergedMultiRent."MD_Start Date" <= RecoveryEndDate) and (MergedMultiRent."MD_End Date" >= RecoveryStartDate) then
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                MergedMultiRent."MD_Start Date",
                                MergedMultiRent."MD_End Date",
                                MergedMultiRent."MD_Number of Days",
                                MergedMultiRent."MD_Per Day Rent",
                                MergedMultiRent."MD_Final Annual Amount",
                                MergedMultiRent."MD_Final Annual Amount",
                                TerminationDate,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Merged Multi Rent Recovery',
                                RevenueMethod);

                    until MergedMultiRent.Next() = 0;

                SpecialRent.Reset();
                SpecialRent.SetRange("Contract ID", ContractRec."Contract ID");
                if SpecialRent.FindSet() then
                    repeat
                        if (SpecialRent."ML_Start Date" <= RecoveryEndDate) and (SpecialRent."ML_End Date" >= RecoveryStartDate) then
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                SpecialRent."ML_Start Date",
                                SpecialRent."ML_End Date",
                                SpecialRent."ML_Number of Days",
                                SpecialRent."ML_Per Day Rent",
                                SpecialRent."ML_Final Annual Amount",
                                SpecialRent."ML_Final Annual Amount",
                                TerminationDate,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Special Rent Recovery',
                                RevenueMethod);

                    until SpecialRent.Next() = 0;
            end;
        end;
    end;

    procedure InsertSuspensionRecoveryLine(
    ContractRec: Record "Tenancy Contract";
    MultiYearStartDate: Date;
    MultiYearEndDate: Date;
    NoOfDays: Integer;
    PerDayRent: Decimal;
    pTotalAnnualAmount: Decimal;
    OwnerShareAmount: Decimal;
    TerminationDate: Date;
    MonthNo: Integer;
    FinancialYear: Integer;
    RecoveryStartDate: Date;
    RecoveryEndDate: Date;
    RecoveryType: Text;
    RevenueMethod: Option "Per Day Rent","Fixed Monthly Rent")
    var
        FilteredContractRec: Record "Revenue Allocation SubGrid";
        SuspensionRec: Record SuspendReasonTable;
        CalculatedRecoveryDays: Integer;
        NewLineNo: Integer;
        GridAnnualAmount: Decimal;
        RecoveryAmount: Decimal;
        EffectiveStartDate: Date;
        EffectiveEndDate: Date;
    begin
        NewLineNo := GetNextLineNo();
        GridAnnualAmount := pTotalAnnualAmount;

        EffectiveStartDate := RecoveryStartDate;
        if MultiYearStartDate > EffectiveStartDate then
            EffectiveStartDate := MultiYearStartDate;

        EffectiveEndDate := RecoveryEndDate;
        if MultiYearEndDate < EffectiveEndDate then
            EffectiveEndDate := MultiYearEndDate;

        if EffectiveStartDate <= EffectiveEndDate then
            CalculatedRecoveryDays := EffectiveEndDate - EffectiveStartDate + 1
        else
            CalculatedRecoveryDays := 0;

        if CalculatedRecoveryDays > 0 then begin
            RecoveryAmount := CalculatedRecoveryDays * PerDayRent;

            FilteredContractRec.Init();
            FilteredContractRec."Line No." := NewLineNo;
            FilteredContractRec."Header No." := Rec."No.";
            FilteredContractRec."Property Name" := ContractRec."Property Name";
            FilteredContractRec."Contract Id" := ContractRec."Contract ID";
            FilteredContractRec."Contract Tenure" := ContractRec."Contract Tenor";
            FilteredContractRec."Customer Name" := ContractRec."Customer Name";
            FilteredContractRec."Contract Start Date" := ContractRec."Contract Start Date";
            FilteredContractRec."Contract End Date" := ContractRec."Contract End Date";
            FilteredContractRec."Grace Days" := ContractRec."Grace Period";
            FilteredContractRec."Grace Start Date" := ContractRec."Grace Start Date";
            FilteredContractRec."Grace End Date" := ContractRec."Grace End Date";
            FilteredContractRec."Unit Type" := ContractRec."Usage Type";

            case
            ContractRec."Praposal Type Selected" of
                ContractRec."Praposal Type Selected"::"Single Unit":
                    FilteredContractRec."Single Unit Names" := ContractRec."Unit Name";
                ContractRec."Praposal Type Selected"::"Merge Unit":
                    FilteredContractRec."Single Unit Names" := ContractRec."Single Unit Name";
                else
                    FilteredContractRec."Single Unit Names" := '';
            end;

            if TerminationDate = 0D then
                FilteredContractRec."Termination Date" := 0D
            else
                FilteredContractRec."Termination Date" := TerminationDate;

            SuspensionRec.Reset();
            SuspensionRec.SetRange("Contract ID", ContractRec."Contract ID");
            if SuspensionRec.FindFirst() then begin
                FilteredContractRec."Suspension Start Date" := SuspensionRec.DateEffective;
                FilteredContractRec."Suspension End Date" := SuspensionRec.SuspensionEndDate;
            end;

            FilteredContractRec."Multi Year Start Date" := MultiYearStartDate;
            FilteredContractRec."Multi Year End Date" := MultiYearEndDate;
            FilteredContractRec."No Of Days" := CalculatedRecoveryDays;
            FilteredContractRec."Contract Amount" := ContractRec."Annual Rent Amount";
            FilteredContractRec."Annual Amount" := GridAnnualAmount;
            FilteredContractRec."Final Annual Amount" := pTotalAnnualAmount;

            if RevenueMethod = RevenueMethod::"Per Day Rent" then begin
                FilteredContractRec."Per Day Rent" := Round(PerDayRent);
                FilteredContractRec."Total Value" := RecoveryAmount;
                FilteredContractRec."Owner Share" := RecoveryAmount;
            end
            else begin
                FilteredContractRec."Per Month Rent" := CalculatePerMonthRent((FilteredContractRec."Final Annual Amount" / 12), CalculatedRecoveryDays, MonthNo, FinancialYear);
                FilteredContractRec."Total Value" := FilteredContractRec."Per Month Rent";
                FilteredContractRec."Owner Share" := FilteredContractRec."Per Month Rent";
            end;


            FilteredContractRec."Posting Month" := MonthNo;
            FilteredContractRec."Posting Year" := FinancialYear;
            FilteredContractRec.Description := 'Suspension';
            FilteredContractRec."Posting Period" := 'Suspension Recovery - ' + Format(MonthNo) + ' ' + Format(FinancialYear);
            FilteredContractRec."Owner Name" := ContractRec."Owner's Name";

            FilteredContractRec.Insert();
        end;
    end;

    procedure CalculateAndStoreTotalRevenue()
    var
        revenueItemLine: Record "Revenue Recognition Details";
        revenueAllocLine: Record "Revenue Allocation Subgrid";
    begin
        Clear(totalcontractAmounts);
        Clear(totalamounts);

        revenueItemLine.SetRange("RR_No.", Rec."No.");
        if revenueItemLine.FindSet() then
            repeat
                totalcontractAmounts += revenueItemLine."Contract Amount";
                totalamounts += revenueItemLine."Total Value";
                TotalAnnualAmounts += revenueItemLine."Annual Amount";
                TotalFinalAnnualAmounts += revenueItemLine."Final Annual Amount";



            until revenueItemLine.Next() = 0;


        revenueAllocLine.SetRange("Header No.", Rec."No.");
        if revenueAllocLine.FindSet() then
            repeat
                totalcontractAmountsss += revenueAllocLine."Contract Amount";
                totalamountsss += revenueAllocLine."Total Value";
                totalannualamountsss += revenueAllocLine."Annual Amount";
                totalfinalannualamountsss += revenueAllocLine."Final Annual Amount";
            until revenueAllocLine.Next() = 0;


        totalcombinecontractAmounts := totalcontractAmountsss + totalcontractAmounts;
        totalcombineamounts := totalamountsss + totalamounts;
        totalcombinefinalamount := TotalAnnualAmounts + totalannualamountsss;
        totalcombinefinalannualamount := TotalFinalAnnualAmounts + totalfinalannualamountsss;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CalculateAndStoreTotalRevenue();
    end;

    procedure CalculatePerMonthRent(permonthrent: Decimal; CalculatedDays: Integer; MonthNo: Integer; FinancialYear: Integer): Decimal
    var
        revenuerecognition: Record "Revenue Recognition";
        MonthlyRate: Decimal;
    begin
        if CalculatedDays < revenuerecognition.GetDaysInMonthss(DMY2Date(1, MonthNo, FinancialYear)) then
            MonthlyRate := Round(permonthrent / revenuerecognition.GetDaysInMonthss(DMY2Date(1, MonthNo, FinancialYear)) * CalculatedDays)
        else
            MonthlyRate := permonthrent;

        exit(MonthlyRate);
    end;

    var
        totalcontractAmountsss: Decimal;
        totalamountsss: Decimal;
        totalannualamountsss: Decimal;
        totalfinalannualamountsss: Decimal;
        totalcontractAmounts: Decimal;
        totalamounts: Decimal;
        totalcombinecontractAmounts: Decimal;
        totalcombineamounts: Decimal;
        totalcombinefinalamount: Decimal;
        totalcombinefinalannualamount: Decimal;
        TotalAnnualAmounts: Decimal;
        TotalFinalAnnualAmounts: Decimal;

    trigger OnModifyRecord(): Boolean
    begin
        CurrPage."Revenue Recognition Item Details".Page.SetRIID(Rec."No.");
        CurrPage."Revenue Recognition Details".Page.SetRIID(Rec."No.");
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage."Revenue Recognition Item Details".Page.SetRIID(Rec."No.");
        CurrPage."Revenue Recognition Details".Page.SetRIID(Rec."No.");
        CalculateAndStoreTotalRevenue();
    end;
}