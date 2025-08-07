page 50973 "Revenue Recognition Item Sub"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Revenue Recognition Item";
    Caption = 'Revenue Item';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("RR_No."; Rec."RR_No.")
                {
                    ToolTip = 'The unique identifier for the revenue recognition record.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item Type"; Rec."Item Type")
                {
                    ToolTip = 'The type of item associated with the revenue recognition.';
                    ApplicationArea = All;
                    Caption = 'Item Type';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'The unique entry number for the revenue recognition item.';
                    ApplicationArea = All;
                    Caption = 'Entry No.';
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(FetchRevenueDetails)
            {
                ToolTip = 'Fetches revenue details for the selected item types.';
                Caption = 'Revenue Allocation-Other Charges';
                ApplicationArea = All;
                Image = List;
                trigger OnAction()
                var
                    revenueAllocation: Record "Revenue Allocation Details";
                    companydata: Record "Company Data";
                    ConfirmFetch: Boolean;
                begin
                    if companydata.FindFirst() then
                        if companydata."Revenue Methods" = companydata."Revenue Methods"::"Per Day Rent" then begin
                            // Get the current Revenue Allocation record details
                            if not GetCurrentRevenueAllocation(RevenueAllocation) then begin
                                Message('Unable to get Revenue Allocation details. Please ensure you are on a valid record.');
                                exit;
                            end;

                            // Confirm before fetching details
                            ConfirmFetch := Confirm('Do you want to fetch revenue details for the selected Item Type(s) for %1 %2?',
                                false, Format(RevenueAllocation.Month), RevenueAllocation."Financial Year");

                            if ConfirmFetch then begin
                                // Call the fetch procedure with current allocation details
                                FetchContractDetails(RevenueAllocation);

                                // Show message about fetched details
                                Message('Revenue details have been fetched successfully.');
                            end;
                        end else
                            if companydata."Revenue Methods" = companydata."Revenue Methods"::"Fixed Monthly Rent" then begin
                                if not GetCurrentRevenueAllocation(RevenueAllocation) then begin
                                    Message('Unable to get Revenue Allocation details. Please ensure you are on a valid record.');
                                    exit;
                                end;

                                // Confirm before fetching details
                                ConfirmFetch := Confirm('Do you want to fetch revenue details for the selected Item Type(s) for %1 %2?',
                                    false, Format(RevenueAllocation.Month), RevenueAllocation."Financial Year");

                                if ConfirmFetch then begin
                                    // Call the fetch procedure with current allocation details
                                    FetchContractDetailss(RevenueAllocation);

                                    // Show message about fetched details
                                    Message('Revenue details have been fetched successfully.');
                                end else
                                    Message('First Select Revenue Method in Company Data Card');
                            end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearSubgridData();
    end;

    // Get current Revenue Allocation record
    local procedure GetCurrentRevenueAllocation(var RevenueAllocation: Record "Revenue Allocation Details"): Boolean
    begin
        // Get the current RR_No from the record
        if Rec."RR_No." = 0 then
            exit(false);

        // Find the Revenue Allocation record using RR_No
        RevenueAllocation.Reset();
        RevenueAllocation.SetRange("No.", Rec."RR_No.");
        if RevenueAllocation.FindFirst() then
            exit(true);

        exit(false);
    end;

    procedure ClearSubgridData()
    var
        RevenueItemDetail: Record "Revenue Recognition Details";
    begin
        // Clear existing details for this Revenue Recognition record
        RevenueItemDetail.SetRange("RR_No.", Rec."RR_No.");
        RevenueItemDetail.DeleteAll(true);
    end;

    procedure FetchContractDetails(RevenueAllocation: Record "Revenue Allocation Details")
    var
        TenancyContract: Record "Tenancy Contract";
        RevenueStructure: Record "Revenue Structure";
        SelectedItemTypes: List of [Text];
        ProcessedContractCount: Integer;
        ContractProcessed: Boolean;
        RevenueAllocationStartDate: Date;
        RevenueAllocationEndDate: Date;
    begin
        // Clear existing data
        ClearSubgridData();

        // Get selected Item Types for this Revenue Recognition Item
        GetSelectedItemTypes(SelectedItemTypes);

        // If no item types are selected, exit
        if SelectedItemTypes.Count = 0 then begin
            Message('Please select at least one Item Type.');
            exit;
        end;

        // Reset processed contract counter
        ProcessedContractCount := 0;

        // Calculate month start and end dates
        RevenueAllocationStartDate := DMY2Date(1, RevenueAllocation.Month, RevenueAllocation."Financial Year");
        RevenueAllocationEndDate := CalcDate('<CM>', RevenueAllocationStartDate);

        // Process active contracts directly from Revenue Structure
        if TenancyContract.FindSet() then
            repeat
                // NEW: Check if contract should be processed based on status and dates
                if ShouldProcessContract(TenancyContract, RevenueAllocation.Month, RevenueAllocation."Financial Year") then
                    // Check if contract is active during the selected period
                    if (TenancyContract."Contract Start Date" <= RevenueAllocationEndDate) and
                       (TenancyContract."Contract End Date" >= RevenueAllocationStartDate) then begin

                        // Reset flag for each contract
                        ContractProcessed := false;

                        // Get revenue structure details directly for this contract
                        RevenueStructure.Reset();
                        RevenueStructure.SetRange("Contract ID", TenancyContract."Contract ID");

                        // Filter by selected Item Types
                        RevenueStructure.SetFilter("Secondary Item Type", GetItemTypeFilter(SelectedItemTypes));

                        if RevenueStructure.FindSet() then
                            repeat
                                // Create Revenue Recognition Detail directly from Revenue Structure
                                CreateRevenueRecognitionDetailDirect(TenancyContract, RevenueStructure, RevenueAllocation);

                                // Mark contract as processed
                                ContractProcessed := true;
                            until RevenueStructure.Next() = 0;
                        // Increment processed contract counter if at least one structure was found
                        if ContractProcessed then
                            ProcessedContractCount += 1;
                    end;
            until TenancyContract.Next() = 0;

        // Process MISSED REVENUE for contracts that started in previous month
        ProcessAllMissedRevenueAllocations(RevenueAllocation);

        ProcessCreditNoteEntries(RevenueAllocationStartDate, RevenueAllocationEndDate, RevenueAllocation.Month, RevenueAllocation."Financial Year");

        // Refresh the page to show new details
        CurrPage.Update(false);

        // Show summary message
        Message(
            'Revenue Details Fetched Summary:\' +
            'Item Types: %1\' +
            'Contracts Processed (Active/Suspended/Terminated): %2',
            GetItemTypeFilter(SelectedItemTypes),
            ProcessedContractCount
        );
    end;

    // Enhanced procedure to process ALL missed revenue allocations dynamically
    local procedure ProcessAllMissedRevenueAllocations(pCurrentAllocation: Record "Revenue Allocation Details")
    var
        TenancyContract: Record "Tenancy Contract";
        RevenueStructure: Record "Revenue Structure";
        RevenueAllocation: Record "Revenue Allocation Details";
        PreviousAllocationMonth: Integer;
        PreviousAllocationYear: Integer;
        PreviousAllocationStartDate: Date;
        PreviousAllocationEndDate: Date;
        SelectedItemTypes: List of [Text];
        MissedContractCount: Integer;
    begin
        // Get selected item types
        GetSelectedItemTypes(SelectedItemTypes);

        // Calculate previous month dynamically
        PreviousAllocationMonth := pCurrentAllocation.Month - 1;
        PreviousAllocationYear := pCurrentAllocation."Financial Year";

        // Handle year transition
        if PreviousAllocationMonth = 0 then begin
            PreviousAllocationMonth := 12;
            PreviousAllocationYear := PreviousAllocationYear - 1;
        end;

        // Calculate dates for the previous month
        PreviousAllocationStartDate := DMY2Date(1, PreviousAllocationMonth, PreviousAllocationYear);
        PreviousAllocationEndDate := CalcDate('<CM>', PreviousAllocationStartDate);

        // Initialize missed contract counter
        MissedContractCount := 0;

        // Find ALL contracts that started in previous month (date 2-31)
        TenancyContract.Reset();
        TenancyContract.SetFilter("Contract Start Date", '%1..%2',
            DMY2Date(2, PreviousAllocationMonth, PreviousAllocationYear),
            PreviousAllocationEndDate);

        if TenancyContract.FindSet() then
            repeat
                // Additional check: Contract should be active during previous month
                if (TenancyContract."Contract Start Date" <= PreviousAllocationEndDate) and
                   (TenancyContract."Contract End Date" >= PreviousAllocationStartDate) then

                    // Check if this contract was missed in previous allocation
                    if IsMissedRevenueAllocationForContract(
                        TenancyContract."Contract ID",
                        PreviousAllocationMonth,
                        PreviousAllocationYear,
                        pCurrentAllocation.Month,
                        pCurrentAllocation."Financial Year"
                    ) then begin

                        // Get revenue structure for this contract
                        RevenueStructure.Reset();
                        RevenueStructure.SetRange("Contract ID", TenancyContract."Contract ID");
                        RevenueStructure.SetFilter("Secondary Item Type", GetItemTypeFilter(SelectedItemTypes));

                        if RevenueStructure.FindFirst() then begin
                            // Create temporary allocation record for missed month
                            RevenueAllocation := pCurrentAllocation;
                            RevenueAllocation.Month := PreviousAllocationMonth;
                            RevenueAllocation."Financial Year" := PreviousAllocationYear;

                            // Create missed revenue allocation for this contract
                            CreateMissedRevenueAllocationForContract(
                                TenancyContract,
                                RevenueAllocation
                            );

                            MissedContractCount += 1;
                        end;
                    end;
            until TenancyContract.Next() = 0;

        // Optional: Show message about missed contracts processed
        if MissedContractCount > 0 then
            Message('Processed %1 missed revenue allocations for previous month (%2/%3)',
                MissedContractCount, PreviousAllocationMonth, PreviousAllocationYear);
    end;

    // Enhanced check for missed revenue allocation - more dynamic
    local procedure IsMissedRevenueAllocationForContract(
        ContractID: Integer;
        CheckMonth: Integer;
        CheckYear: Integer;
        currentMonth: Integer;
        currentYear: Integer
    ): Boolean
    var
        ExistingRevenue: Record "Revenue Recognition Details";
        RegularAllocationExists: Boolean;
        MissedAllocationExists: Boolean;
    begin
        // Check if regular revenue was already allocated for this contract in this month
        ExistingRevenue.Reset();
        ExistingRevenue.SetRange("Contract Id", ContractID);
        ExistingRevenue.SetRange("Posting Month", currentMonth);
        ExistingRevenue.SetRange("Posting Year", currentYear);
        ExistingRevenue.SetFilter("Posting Period", '<>%1', 'MISSED*'); // Exclude missed allocations

        RegularAllocationExists := not ExistingRevenue.IsEmpty;

        // Check if missed allocation already exists for this contract
        ExistingRevenue.Reset();
        ExistingRevenue.SetRange("Contract Id", ContractID);
        ExistingRevenue.SetRange("Posting Month", CheckMonth);
        ExistingRevenue.SetRange("Posting Year", CheckYear);
        ExistingRevenue.SetFilter("Posting Period", '%1', 'MISSED*'); // Only missed allocations

        MissedAllocationExists := not ExistingRevenue.IsEmpty;

        // Return true if no regular allocation exists AND no missed allocation exists
        exit(RegularAllocationExists and not MissedAllocationExists);
    end;

    // Create missed revenue allocation for a specific contract
    local procedure CreateMissedRevenueAllocationForContract(
        pTenancyContract: Record "Tenancy Contract";
        pMissedAllocation: Record "Revenue Allocation Details"
    )
    var
        RevenueStructureSubpage: Record "Revenue Structure Subpage";
        SelectedItemTypes: List of [Text];
        ItemType: Text;
    begin
        // Get selected item types
        GetSelectedItemTypes(SelectedItemTypes);

        // Process each selected item type for this contract
        foreach ItemType in SelectedItemTypes do begin
            // Get revenue structure subpage for this item type
            RevenueStructureSubpage.Reset();
            RevenueStructureSubpage.SetRange("Contract ID", pTenancyContract."Contract ID");
            RevenueStructureSubpage.SetRange("Secondary Item Type", ItemType);

            if RevenueStructureSubpage.FindFirst() then
                // Create missed revenue allocation record
                CreateSingleMissedRevenueAllocation(pTenancyContract, RevenueStructureSubpage, pMissedAllocation, ItemType);
        end;
    end;

    // Enhanced missed revenue allocation creation with better contract detection
    local procedure CreateSingleMissedRevenueAllocation(
        pTenancyContract: Record "Tenancy Contract";
        pRevenueStructureSubpage: Record "Revenue Structure Subpage";
        pMissedAllocation: Record "Revenue Allocation Details";
        pItemType: Text
    )
    var
        FinalCalculation: Record "Final Calculation";
        RevenueRecognitionDetails: Record "Revenue Recognition Details";
        NextEntryNo: Integer;
        NoOfDays: Integer;
        TerminationDate: Date;
        SuspensionDate: Date;
        IsContractSuspended: Boolean;
        Yearlydays: Integer;
        ContractStartInMonth: Integer;
        ContractStartDay: Integer;
    begin

        // Get contract start day to verify it's in range 2-31
        ContractStartDay := Date2DMY(pTenancyContract."Contract Start Date", 1);
        ContractStartInMonth := Date2DMY(pTenancyContract."Contract Start Date", 2);

        // Only process if contract started on day 2-31 of the previous month
        if (ContractStartInMonth = pMissedAllocation.Month) and (ContractStartDay >= 2) then begin

            // Get termination date for this contract
            FinalCalculation.Reset();
            FinalCalculation.SetRange("Contract ID", pTenancyContract."Contract ID");
            if FinalCalculation.FindFirst() then
                TerminationDate := FinalCalculation."Termination Date"
            else
                TerminationDate := 0D;

            // Check if contract was suspended in the missed month
            IsContractSuspended := IsContractSuspendedInPeriod(
                pTenancyContract."Contract ID",
                pMissedAllocation.Month,
                pMissedAllocation."Financial Year",
                SuspensionDate
            );

            // Calculate number of days for missed allocation
            NoOfDays := CalculatePerfectNoOfDays(
                pTenancyContract."Contract Start Date",
                pTenancyContract."Contract End Date",
                pMissedAllocation.Month,
                pMissedAllocation."Financial Year",
                TerminationDate,
                IsContractSuspended,
                SuspensionDate
            );

            // Create missed revenue record only if there are days to allocate
            if NoOfDays > 0 then begin
                // Get next entry number
                RevenueRecognitionDetails.Reset();
                if RevenueRecognitionDetails.FindLast() then
                    NextEntryNo := RevenueRecognitionDetails."Entry No." + 1
                else
                    NextEntryNo := 1;

                // Create new Revenue Recognition Detail record for missed allocation
                RevenueRecognitionDetails.Init();
                RevenueRecognitionDetails."Entry No." := NextEntryNo;
                RevenueRecognitionDetails."RR_No." := Rec."RR_No.";

                // Copy contract details
                RevenueRecognitionDetails."Contract Id" := pTenancyContract."Contract ID";
                RevenueRecognitionDetails."Property Name" := pTenancyContract."Property Name";
                RevenueRecognitionDetails."Customer Name" := pTenancyContract."Customer Name";
                RevenueRecognitionDetails."Contract Start Date" := pTenancyContract."Contract Start Date";
                RevenueRecognitionDetails."Contract End Date" := pTenancyContract."Contract End Date";
                RevenueRecognitionDetails."Owner Name" := pTenancyContract."Owner's Name";
                RevenueRecognitionDetails."Contract Tenure" := pTenancyContract."Contract Tenor";
                RevenueRecognitionDetails."Grace Days" := pTenancyContract."Grace Period";
                RevenueRecognitionDetails."Grace Start Date" := pTenancyContract."Grace Start Date";
                RevenueRecognitionDetails."Grace End Date" := pTenancyContract."Grace End Date";
                RevenueRecognitionDetails."Unit Type" := pTenancyContract."Usage Type";
                RevenueRecognitionDetails."Description" := 'Missed Revenue';

                case
                    pTenancyContract."Praposal Type Selected" of
                    pTenancyContract."Praposal Type Selected"::"Single Unit":
                        RevenueRecognitionDetails."Single Unit Names" := pTenancyContract."Unit Name";
                    pTenancyContract."Praposal Type Selected"::"Merge Unit":
                        RevenueRecognitionDetails."Single Unit Names" := pTenancyContract."Single Unit Name";
                    else
                        RevenueRecognitionDetails."Single Unit Names" := '';
                end;

                // Add missed allocation period details
                RevenueRecognitionDetails."Posting Month" := pMissedAllocation.Month;
                RevenueRecognitionDetails."Posting Year" := pMissedAllocation."Financial Year";

                // Mark as missed revenue allocation with contract start date info
                // RevenueRecognitionDetails."Posting Period" :=
                //     'MISSED: ' + FORMAT(pMissedAllocation.Month) + '/' + FORMAT(pMissedAllocation."Financial Year") +
                //     ' (Started: ' + FORMAT(pTenancyContract."Contract Start Date") + ')';

                RevenueRecognitionDetails."Posting Period" := GetMonthName(pMissedAllocation.Month) + ' ' +
                                      Format(pMissedAllocation."Financial Year") + ' ' + '-' + ' ' + GetMonthName(pMissedAllocation.Month) + ' ' + Format(pMissedAllocation."Financial Year");

                // Set termination date and number of days
                RevenueRecognitionDetails."Termination Date" := TerminationDate;
                RevenueRecognitionDetails."No Of Days" := NoOfDays;

                // Get suspension details
                GetSuspensionDetails(pTenancyContract."Contract ID", RevenueRecognitionDetails);

                // Set revenue structure details from subpage
                RevenueRecognitionDetails."Multi Year Start Date" := pRevenueStructureSubpage."Period Start Date";
                RevenueRecognitionDetails."Multi Year End Date" := pRevenueStructureSubpage."Period End Date";
                RevenueRecognitionDetails."Annual Amount" := pRevenueStructureSubpage."Final Annual Amount" + pRevenueStructureSubpage."Final Annual Amount" * 5 / 100;
                RevenueRecognitionDetails."Final Annual Amount" := RevenueRecognitionDetails."Annual Amount";
                RevenueRecognitionDetails."Item Type" := CopyStr(pItemType, 1, StrLen(pItemType));
                RevenueRecognitionDetails."Contract Amount" := pRevenueStructureSubpage."Final Annual Amount";

                // Calculate amounts
                Yearlydays := RevenueRecognitionDetails."Multi Year End Date" - RevenueRecognitionDetails."Multi Year Start Date" + 1;
                if Yearlydays > 0 then
                    RevenueRecognitionDetails."Per Day Rent" := RevenueRecognitionDetails."Annual Amount" / Yearlydays
                else
                    RevenueRecognitionDetails."Per Day Rent" := 0;

                RevenueRecognitionDetails."Total Value" := RevenueRecognitionDetails."No Of Days" * RevenueRecognitionDetails."Per Day Rent";
                RevenueRecognitionDetails."Owner Share" := RevenueRecognitionDetails."Total Value";

                // Insert the missed revenue record
                RevenueRecognitionDetails.Insert(true);
            end;
        end;
    end;

    procedure GetMonthName(MonthNo: Integer): Text
    begin
        case MonthNo of
            1:
                exit('January');
            2:
                exit('February');
            3:
                exit('March');
            4:
                exit('April');
            5:
                exit('May');
            6:
                exit('June');
            7:
                exit('July');
            8:
                exit('August');
            9:
                exit('September');
            10:
                exit('October');
            11:
                exit('November');
            12:
                exit('December');
            else
                exit(Format(MonthNo)); // Fallback to number if invalid
        end;
    end;

    // Perfect calculation of number of days - enhanced for missed allocations
    local procedure CalculatePerfectNoOfDays(
        ContractStartDate: Date;
        ContractEndDate: Date;
        ProcessMonth: Integer;
        ProcessYear: Integer;
        TerminationDate: Date;
        IsContractSuspended: Boolean;
        SuspensionDate: Date
    ): Integer
    var
        MonthStartDate: Date;
        MonthEndDate: Date;
        EffectiveStartDate: Date;
        EffectiveEndDate: Date;
        NoOfDays: Integer;
    begin
        // Calculate month boundaries
        MonthStartDate := DMY2Date(1, ProcessMonth, ProcessYear);
        MonthEndDate := CalcDate('<CM>', MonthStartDate);

        // For missed allocations, use the actual contract start date if it's within the month
        if (ContractStartDate >= MonthStartDate) and (ContractStartDate <= MonthEndDate) then
            EffectiveStartDate := ContractStartDate
        else
            EffectiveStartDate := MonthStartDate;

        // Determine effective end date (earlier of contract end, month end, or termination date)
        EffectiveEndDate := MonthEndDate;

        if ContractEndDate < EffectiveEndDate then
            EffectiveEndDate := ContractEndDate;

        if (TerminationDate <> 0D) and (TerminationDate < EffectiveEndDate) then
            EffectiveEndDate := TerminationDate;

        // Handle suspension
        if IsContractSuspended and (SuspensionDate <> 0D) and (SuspensionDate < EffectiveEndDate) then
            EffectiveEndDate := SuspensionDate;

        // Calculate number of days
        if EffectiveEndDate >= EffectiveStartDate then
            NoOfDays := EffectiveEndDate - EffectiveStartDate + 1
        else
            NoOfDays := 0;

        exit(NoOfDays);
    end;



    // UPDATED: Function to check if contract should be processed
    local procedure ShouldProcessContract(pTenancyContract: Record "Tenancy Contract"; pAllocationMonth: Integer; pAllocationYear: Integer): Boolean
    begin
        // 1. If Active - Always process
        if pTenancyContract."Tenant Contract Status" = pTenancyContract."Tenant Contract Status"::Active then
            exit(true);

        // 2. If Suspended - Check if suspension date falls in selected month/year
        if pTenancyContract."Tenant Contract Status" = pTenancyContract."Tenant Contract Status"::Suspended then
            if HasSuspensionInSelectedPeriod(pTenancyContract."Contract ID", pAllocationMonth, pAllocationYear) then
                exit(true);

        // 3. If Terminated - Check if termination date falls in selected month/year
        if pTenancyContract."Tenant Contract Status" = pTenancyContract."Tenant Contract Status"::Terminated then
            if HasTerminationInSelectedPeriod(pTenancyContract."Contract ID", pAllocationMonth, pAllocationYear) then
                exit(true);

        // Default: Don't process
        exit(false);
    end;

    // NEW: Check if suspension date falls in selected month/year
    local procedure HasSuspensionInSelectedPeriod(pContractID: Integer; pAllocationMonth: Integer; pAllocationYear: Integer): Boolean
    var
        SuspendedReasonList: Record SuspendReasonTable;
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
    begin
        // Calculate selected month start and end dates
        SelectedMonthStart := DMY2Date(1, pAllocationMonth, pAllocationYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Check if suspension date falls within selected period
        SuspendedReasonList.Reset();
        SuspendedReasonList.SetRange("Contract ID", pContractID);
        if SuspendedReasonList.FindFirst() then
            if (SuspendedReasonList.DateEffective >= SelectedMonthStart) and
               (SuspendedReasonList.DateEffective <= SelectedMonthEnd) then
                exit(true);

        exit(false);
    end;

    // NEW: Check if termination date falls in selected month/year
    local procedure HasTerminationInSelectedPeriod(pContractID: Integer; pAllocationMonth: Integer; pAllocationYear: Integer): Boolean
    var
        FinalCalculation: Record "Final Calculation";
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
    begin
        // Calculate selected month start and end dates
        SelectedMonthStart := DMY2Date(1, pAllocationMonth, pAllocationYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Check if termination date falls within selected period
        FinalCalculation.Reset();
        FinalCalculation.SetRange("Contract ID", pContractID);
        if FinalCalculation.FindFirst() then
            if (FinalCalculation."Termination Date" <> 0D) and
               (FinalCalculation."Termination Date" >= SelectedMonthStart) and
               (FinalCalculation."Termination Date" <= SelectedMonthEnd) then
                exit(true);

        exit(false);
    end;


    local procedure GetSelectedItemTypes(var pItemTypes: List of [Text])
    var
        RevenueRecognitionItem: Record "Revenue Recognition Item";
    begin
        // Set filter to get all selected Item Types
        RevenueRecognitionItem.SetRange("RR_No.", Rec."RR_No.");

        // Find all records for this Revenue Recognition
        if RevenueRecognitionItem.FindSet() then
            repeat
                // Only add non-empty Item Types
                if RevenueRecognitionItem."Item Type" <> '' then
                    // Check if Item Type is not already in the list
                    if not pItemTypes.Contains(RevenueRecognitionItem."Item Type") then
                        pItemTypes.Add(RevenueRecognitionItem."Item Type");
            until RevenueRecognitionItem.Next() = 0;
    end;

    local procedure GetItemTypeFilter(pItemTypes: List of [Text]): Text
    var
        FilterText: Text;
        ItemType: Text;
    begin
        // Build filter text
        foreach ItemType in pItemTypes do
            if FilterText = '' then
                FilterText := ItemType
            else
                FilterText += '|' + ItemType;

        exit(FilterText);
    end;

    procedure CalculateNoOfDays(
           pContractStartDate: Date;
           pContractEndDate: Date;
           pAllocationMonth: Integer;
           pAllocationYear: Integer;
           pTerminationDate: Date
       ): Integer
    var
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
        EffectiveStartDate: Date;
        EffectiveEndDate: Date;
        NoOfDays: Integer;
        TerminationDay: Integer;
    begin
        // Start and end of the selected month
        SelectedMonthStart := DMY2Date(1, pAllocationMonth, pAllocationYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Special Termination case:
        if (pTerminationDate <> 0D) then
            if (pTerminationDate < pContractEndDate) and
            (Date2DMY(pTerminationDate, 2) = pAllocationMonth) and
            (Date2DMY(pTerminationDate, 3) = pAllocationYear) then begin
                TerminationDay := Date2DMY(pTerminationDate, 1); // e.g., 3
                // Message('%1 - %2', pTerminationDate, TerminationDay);
                exit(TerminationDay);
            end;

        // Return 0 if contract is outside of the selected month
        if (pContractStartDate > SelectedMonthEnd) or (pContractEndDate < SelectedMonthStart) then
            exit(0);

        // Determine the effective start date
        if pContractStartDate > SelectedMonthStart then
            EffectiveStartDate := pContractStartDate
        else
            EffectiveStartDate := SelectedMonthStart;

        // Determine the effective end date
        if pContractEndDate < SelectedMonthEnd then
            EffectiveEndDate := pContractEndDate
        else
            EffectiveEndDate := SelectedMonthEnd;

        // Calculate inclusive number of days
        NoOfDays := EffectiveEndDate - EffectiveStartDate + 1;

        exit(NoOfDays);
    end;

    local procedure CalculateSuspendedPeriodDays(
        pSuspensionStartDate: Date;
        pSuspensionEndDate: Date
    ): Integer
    var
        NoOfDays: Integer;
    begin
        // If no suspension dates, return 0
        if (pSuspensionStartDate = 0D) or (pSuspensionEndDate = 0D) then
            exit(0);

        // આ આખો suspension period return કરે છે
        // તમારા case માં: 04/11/2025 - 05/10/2025 + 1 = 31 days
        NoOfDays := pSuspensionEndDate - pSuspensionStartDate + 1;

        exit(NoOfDays);
    end;

    // Also need to add a separate function for active period after suspension
    local procedure CalculateActivePeriodDaysAfterSuspension(
        pSuspensionStartDate: Date;
        pSuspensionEndDate: Date;
        pAllocationEndDate: Date
    ): Integer
    var
        EffectiveStartDate: Date;
        EffectiveEndDate: Date;
        NoOfDays: Integer;
    begin
        // If no suspension dates, return 0
        if (pSuspensionStartDate = 0D) or (pSuspensionEndDate = 0D) then
            exit(0);

        // Start from the day AFTER suspension ends
        EffectiveStartDate := pSuspensionEndDate + 1;

        // End at allocation end date
        EffectiveEndDate := pAllocationEndDate;

        // Calculate inclusive number of active days after suspension
        if EffectiveEndDate >= EffectiveStartDate then
            NoOfDays := EffectiveEndDate - EffectiveStartDate + 1
        else
            NoOfDays := 0;

        exit(NoOfDays);
    end;

    // NEW: Check if contract has suspension to active scenario
    local procedure HasSuspensionToActiveScenario(
        pContractID: Integer;
        pAllocationStartDate: Date;
        pAllocationEndDate: Date;
        var pSuspensionStartDate: Date;
        var pSuspensionEndDate: Date
    ): Boolean
    var
        SuspendedReasonList: Record SuspendReasonTable;
    begin
        SuspendedReasonList.Reset();
        SuspendedReasonList.SetRange("Contract ID", pContractID);
        if SuspendedReasonList.FindFirst() then begin
            pSuspensionStartDate := SuspendedReasonList.DateEffective;
            pSuspensionEndDate := SuspendedReasonList.SuspensionEndDate;

            // Check if contract was suspended and then became active within the allocation period
            if (pSuspensionStartDate <> 0D) and (pSuspensionEndDate <> 0D) then
                // Check if suspension ended before allocation end date
                if (pSuspensionEndDate < pAllocationEndDate) and
                // (pSuspensionStartDate <= pAllocationEndDate) and 
                (pSuspensionEndDate >= pAllocationStartDate) then
                    exit(true);
        end;

        exit(false);
    end;

    // NEW: Function to check if contract is suspended in selected month/year
    // MODIFIED: IsContractSuspendedInPeriod - Remove duplicate status check
    local procedure IsContractSuspendedInPeriod(
        pContractID: Integer;
        pAllocationMonth: Integer;
        pAllocationYear: Integer;
        var pSuspensionDate: Date
    ): Boolean
    var
        SuspendedReasonList: Record SuspendReasonTable;
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
    begin
        // Calculate selected month start and end dates
        SelectedMonthStart := DMY2Date(1, pAllocationMonth, pAllocationYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Check if contract is suspended
        SuspendedReasonList.Reset();
        SuspendedReasonList.SetRange("Contract ID", pContractID);
        if SuspendedReasonList.FindFirst() then
            // Check if suspension date falls within selected month/year
            if (SuspendedReasonList.DateEffective >= SelectedMonthStart) and
               (SuspendedReasonList.DateEffective <= SelectedMonthEnd) then begin
                pSuspensionDate := SuspendedReasonList.DateEffective;
                exit(true);
            end;

        exit(false);
    end;

    // NEW: Calculate days for suspended contract (only till suspension date)
    local procedure CalculateSuspendedContractDays(
         pContractStartDate: Date;
         pContractEndDate: Date;
         pAllocationMonth: Integer;
         pAllocationYear: Integer;
         pSuspensionDate: Date
     ): Integer
    var
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
        EffectiveStartDate: Date;
        EffectiveEndDate: Date;
        NoOfDays: Integer;
    begin
        // Start and end of the selected month
        SelectedMonthStart := DMY2Date(1, pAllocationMonth, pAllocationYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Return 0 if contract is outside of the selected month
        if (pContractStartDate > SelectedMonthEnd) or (pContractEndDate < SelectedMonthStart) then
            exit(0);

        // Determine the effective start date
        if pContractStartDate > SelectedMonthStart then
            EffectiveStartDate := pContractStartDate
        else
            EffectiveStartDate := SelectedMonthStart;

        // For suspended contracts, effective end date is the suspension date
        // (not the full month or contract end date)
        EffectiveEndDate := pSuspensionDate;

        // Make sure suspension date is not before the effective start
        if EffectiveEndDate < EffectiveStartDate then
            exit(0);

        // Calculate inclusive number of days till suspension date
        // Adding 1 to include both start and end dates
        NoOfDays := EffectiveEndDate - EffectiveStartDate;

        exit(NoOfDays);
    end;

    // MODIFIED: Update your existing CreateRevenueRecognitionDetailDirect procedure
    local procedure CreateRevenueRecognitionDetailDirect(
           pTenancyContract: Record "Tenancy Contract";
           pRevenueStructure: Record "Revenue Structure";
           pRevenueAllocation: Record "Revenue Allocation Details"
       )
    var
        revenuestructuredetails: Record "Revenue Structure Subpage";
        FinalCalculation: Record "Final Calculation";
        NoOfDays: Integer;
        RevenueAllocationStartDate: Date;
        RevenueAllocationEndDate: Date;
        SuspensionStartDate: Date;
        SuspensionEndDate: Date;
        SuspendedPeriodDays: Integer;
        SuspendedActivePeriodDays: Integer;
        TerminationDate: Date;
        SuspensionDate: Date;
        IsContractSuspended: Boolean;
    begin
        // Calculate month start and end dates
        RevenueAllocationStartDate := DMY2Date(1, pRevenueAllocation.Month, pRevenueAllocation."Financial Year");
        RevenueAllocationEndDate := CalcDate('<CM>', RevenueAllocationStartDate);

        // Get termination date for this contract
        FinalCalculation.Reset();
        FinalCalculation.SetRange("Contract ID", pTenancyContract."Contract ID");
        if FinalCalculation.FindFirst() then
            TerminationDate := FinalCalculation."Termination Date"
        else
            TerminationDate := 0D;

        // NEW: Check if contract is suspended in selected month/year
        IsContractSuspended := IsContractSuspendedInPeriod(
            pTenancyContract."Contract ID",
            pRevenueAllocation.Month,
            pRevenueAllocation."Financial Year",
            SuspensionDate
        );

        // Calculate number of days based on suspension status
        if IsContractSuspended then
            NoOfDays := CalculateSuspendedContractDays(
            pTenancyContract."Contract Start Date",
            pTenancyContract."Contract End Date",
            pRevenueAllocation.Month,
            pRevenueAllocation."Financial Year", SuspensionDate)
        else
            // For normal contracts, use existing logic
            NoOfDays := CalculateNoOfDays(
                pTenancyContract."Contract Start Date",
                pTenancyContract."Contract End Date",
                pRevenueAllocation.Month,
                pRevenueAllocation."Financial Year",
                TerminationDate);

        // Keep existing logic for suspension to active scenario
        if HasSuspensionToActiveScenario(
            pTenancyContract."Contract ID",
            RevenueAllocationStartDate,
            RevenueAllocationEndDate,
            SuspensionStartDate,
            SuspensionEndDate
        ) then begin
            SuspendedPeriodDays := CalculateSuspendedPeriodDays(
                SuspensionStartDate,
                SuspensionEndDate
            );
            SuspendedActivePeriodDays := CalculateActivePeriodDaysAfterSuspension(
                SuspensionStartDate,
                SuspensionEndDate,
                RevenueAllocationEndDate
            );

            if SuspendedPeriodDays > 0 then
                CreateRevenueRecord(
                    pTenancyContract,
                    pRevenueStructure,
                    pRevenueAllocation,
                    revenuestructuredetails,
                    SuspendedPeriodDays,
                    true);

            if SuspendedActivePeriodDays > 0 then
                CreateRevenueRecord(
                    pTenancyContract,
                    pRevenueStructure,
                    pRevenueAllocation,
                    revenuestructuredetails,
                    SuspendedActivePeriodDays,
                    true);

        end else
            if NoOfDays > 0 then
                CreateRevenueRecord(
                    pTenancyContract,
                    pRevenueStructure,
                    pRevenueAllocation,
                    revenuestructuredetails,
                    NoOfDays,
                    IsContractSuspended);

    end;

    // NEW: Common procedure to create revenue record
    local procedure CreateRevenueRecord(
        pTenancyContract: Record "Tenancy Contract";
        pRevenueStructure: Record "Revenue Structure";
        pRevenueAllocation: Record "Revenue Allocation Details";
        var revenuestructuredetails: Record "Revenue Structure Subpage";
        NoOfDays: Integer;
        IsSuspendedPeriodAllocation: Boolean
    )
    var
        RevenueRecognitionDetails: Record "Revenue Recognition Details";
        NextEntryNo: Integer;
        ActualNoOfDays: Integer;
        Yearlydays: Integer;
        FirstDayOfTargetMonth: Date;
        LastDayOfTargetMonth: Date;
    begin
        // Get next entry number
        RevenueRecognitionDetails.Reset();
        if RevenueRecognitionDetails.FindLast() then
            NextEntryNo := RevenueRecognitionDetails."Entry No." + 1
        else
            NextEntryNo := 1;

        FirstDayOfTargetMonth := DMY2Date(1, pRevenueAllocation.Month, pRevenueAllocation."Financial Year");
        LastDayOfTargetMonth := CALCDATE('<CM>', FirstDayOfTargetMonth) - 1;

        // Create new Revenue Recognition Detail record
        RevenueRecognitionDetails.Init();
        RevenueRecognitionDetails."Entry No." := NextEntryNo;
        RevenueRecognitionDetails."RR_No." := Rec."RR_No.";

        // Copy contract details
        RevenueRecognitionDetails."Contract Id" := pTenancyContract."Contract ID";
        RevenueRecognitionDetails."Property Name" := pTenancyContract."Property Name";
        RevenueRecognitionDetails."Customer Name" := pTenancyContract."Customer Name";
        RevenueRecognitionDetails."Contract Start Date" := pTenancyContract."Contract Start Date";
        RevenueRecognitionDetails."Contract End Date" := pTenancyContract."Contract End Date";
        RevenueRecognitionDetails."Contract Amount" := pRevenueStructure."Amount Including VAT";
        RevenueRecognitionDetails."Owner Name" := pTenancyContract."Owner's Name";
        RevenueRecognitionDetails."Contract Tenure" := pTenancyContract."Contract Tenor";
        RevenueRecognitionDetails."Grace Days" := pTenancyContract."Grace Period";
        RevenueRecognitionDetails."Grace Start Date" := pTenancyContract."Grace Start Date";
        RevenueRecognitionDetails."Grace End Date" := pTenancyContract."Grace End Date";
        RevenueRecognitionDetails."Unit Type" := pTenancyContract."Usage Type";
        RevenueRecognitionDetails."Item Type" := pRevenueStructure."Secondary Item Type";
        RevenueRecognitionDetails."Description" := 'Regular';

        case
                    pTenancyContract."Praposal Type Selected" of
            pTenancyContract."Praposal Type Selected"::"Single Unit":
                RevenueRecognitionDetails."Single Unit Names" := pTenancyContract."Unit Name";
            pTenancyContract."Praposal Type Selected"::"Merge Unit":
                RevenueRecognitionDetails."Single Unit Names" := pTenancyContract."Single Unit Name";
            else
                RevenueRecognitionDetails."Single Unit Names" := '';
        end;

        // Add allocation period details
        RevenueRecognitionDetails."Posting Month" := pRevenueAllocation.Month;
        RevenueRecognitionDetails."Posting Year" := pRevenueAllocation."Financial Year";

        // NEW: Add Description to differentiate regular vs suspended period allocation
        if IsSuspendedPeriodAllocation then
            RevenueRecognitionDetails."Posting Period" := Format(RevenueRecognitionDetails."Posting Month") +
           ' ' + Format(RevenueRecognitionDetails."Posting Year") + ' ' + '-' + ' ' +
           Format(RevenueRecognitionDetails."Posting Month") + ' ' + Format(RevenueRecognitionDetails."Posting Year")
        else
            RevenueRecognitionDetails."Posting Period" := Format(RevenueRecognitionDetails."Posting Month") +
            ' ' + Format(RevenueRecognitionDetails."Posting Year") + ' ' + '-' + ' ' +
            Format(RevenueRecognitionDetails."Posting Month") + ' ' + Format(RevenueRecognitionDetails."Posting Year");

        // Get termination date from Final Calculation by Contract ID match
        GetTerminationDate(pTenancyContract."Contract ID", RevenueRecognitionDetails);

        // IMPORTANT: For suspension scenarios, use the passed NoOfDays directly
        // For regular scenarios, recalculate using the standard function
        if IsSuspendedPeriodAllocation then
            // Use the suspension-specific calculation result
            ActualNoOfDays := NoOfDays
        else
            // Use the standard calculation for regular allocation
            ActualNoOfDays := CalculateNoOfDays(
                pTenancyContract."Contract Start Date",
                pTenancyContract."Contract End Date",
                pRevenueAllocation.Month,
                pRevenueAllocation."Financial Year",
                RevenueRecognitionDetails."Termination Date");

        RevenueRecognitionDetails."No Of Days" := ActualNoOfDays;

        // Get suspension details from Suspended Reason List by Contract ID match
        GetSuspensionDetails(pTenancyContract."Contract ID", RevenueRecognitionDetails);

        revenuestructuredetails.Reset();
        revenuestructuredetails.SetRange("Contract ID", RevenueRecognitionDetails."Contract ID");
        revenuestructuredetails.SetRange("Secondary Item Type", pRevenueStructure."Secondary Item Type");
        if revenuestructuredetails.FindSet() then
            repeat
                // if (revenuestructuredetails."Period Start Date" <= PostingDate) and
                //    (revenuestructuredetails."Period End Date" >= PostingDate) then begin
                if ((revenuestructuredetails."Period Start Date" >= FirstDayOfTargetMonth) and
       (revenuestructuredetails."Period Start Date" <= LastDayOfTargetMonth)) OR
        ((revenuestructuredetails."Period End Date" <= LastDayOfTargetMonth) and
       (revenuestructuredetails."Period End Date" >= FirstDayOfTargetMonth)) OR
       ((revenuestructuredetails."Period Start Date" <= FirstDayOfTargetMonth) and
       (revenuestructuredetails."Period End Date" >= LastDayOfTargetMonth)) then begin
                    RevenueRecognitionDetails."Multi Year Start Date" := revenuestructuredetails."Period Start Date";
                    RevenueRecognitionDetails."Multi Year End Date" := revenuestructuredetails."Period End Date";


                    if revenuestructuredetails."VAT %" = 1 then
                        revenuestructuredetails."VAT %" := 5
                    else
                        revenuestructuredetails."VAT %" := 0;

                    RevenueRecognitionDetails."Annual Amount" := revenuestructuredetails."Final Annual Amount" + revenuestructuredetails."Final Annual Amount" * revenuestructuredetails."VAT %" / 100;
                    // RevenueRecognitionDetails."Annual Amount" := revenuestructuredetails."Final Annual Amount" + revenuestructuredetails."Final Annual Amount" * 5 / 100;
                    RevenueRecognitionDetails."Final Annual Amount" := RevenueRecognitionDetails."Annual Amount";
                end;
            until revenuestructuredetails.Next() = 0;

        Yearlydays := RevenueRecognitionDetails."Multi Year End Date" - RevenueRecognitionDetails."Multi Year Start Date" + 1;
        RevenueRecognitionDetails."Per Day Rent" := RevenueRecognitionDetails."Annual Amount" / Yearlydays;
        RevenueRecognitionDetails."Total Value" := RevenueRecognitionDetails."No Of Days" * RevenueRecognitionDetails."Per Day Rent";
        RevenueRecognitionDetails."Owner Share" := RevenueRecognitionDetails."Total Value";

        // Insert the record
        RevenueRecognitionDetails.Insert(true);
    end;


    // New procedure to process credit note entries with debugging
    procedure ProcessCreditNoteEntries(SelectedMonthStart: Date; SelectedMonthEnd: Date; MonthNo: Integer; FinancialYear: Integer)
    var
        RequestCreditNotegrid: Record "Request Credit Note Grid";
        RequestCreditNote: Record "Request Credit Note";
        ContractRec: Record "Tenancy Contract";
        RevenueRecognitionDetails: Record "Revenue Recognition Details";
        ExistingRevenueRec: Record "Revenue Recognition Details";
        paymentschedule: Record "Payment Schedule2";
        SuspensionRec: Record SuspendReasonTable;
        ShouldProcessCreditNote: Boolean;
        CalculatedDays: Integer;
        Noofdays: Integer;
        NextEntryNo: Integer;
        RentReductionAmount: Decimal;
        SelectedItemTypes: List of [Text];
        itemTypeFilter: Text;
    begin
        GetSelectedItemTypes(SelectedItemTypes);
        itemTypeFilter := GetItemTypeFilter(SelectedItemTypes);

        // Debug: Check if credit note table has records
        // RequestCreditNotegrid.Reset();
        // if RequestCreditNotegrid.FindSet() then begin
        //     repeat
        RequestCreditNote.SetRange(Status, RequestCreditNote.Status::Approved);
        if RequestCreditNote.FindSet() then
            repeat
                RentReductionAmount := 0;
                RequestCreditNotegrid.SetRange("Request No.", RequestCreditNote."Request No.");
                RequestCreditNotegrid.SetFilter(Charges, itemTypeFilter);
                if RequestCreditNotegrid.FindSet() then
                    repeat
                        RentReductionAmount := RequestCreditNotegrid."Total Reduction";
                        // else
                        //     // Skip processing if Rent line is not found
                        //     exit;

                        if RevenueRecognitionDetails.FindLast() then
                            NextEntryNo := RevenueRecognitionDetails."Entry No." + 1
                        else
                            NextEntryNo := 1;

                        // LineNo += 1;
                        ShouldProcessCreditNote := false;

                        // Get contract details for this credit note
                        ContractRec.Reset();
                        ContractRec.SetRange("Contract ID", RequestCreditNotegrid."Contract ID");
                        ContractRec.SetRange("Tenant Contract Status", ContractRec."Tenant Contract Status"::Active);
                        if ContractRec.FindFirst() then begin
                            paymentschedule.SetRange("Contract ID", ContractRec."Contract ID");
                            paymentschedule.SetRange("Payment Series", RequestCreditNotegrid."Payment Series");
                            //  paymentschedule.SetRange("Secondary Item Type", 'Rent');
                            if paymentschedule.FindFirst() then
                                // Check if contract dates overlap with selected month
                                if ((ContractRec."Contract Start Date" <= SelectedMonthEnd) and
                                    (ContractRec."Contract End Date" >= SelectedMonthStart)) then
                                    ShouldProcessCreditNote := true;
                        end;


                        // If contract dates match the posting month/year duration, create negative revenue entry
                        if ShouldProcessCreditNote then begin

                            // Initialize the record properly
                            RevenueRecognitionDetails.Reset();
                            RevenueRecognitionDetails.Init();

                            // Set primary key fields first
                            RevenueRecognitionDetails."Entry No." := NextEntryNo;
                            RevenueRecognitionDetails."RR_No." := Rec."RR_No.";
                            RevenueRecognitionDetails."Contract ID" := RequestCreditNotegrid."Contract ID";
                            RevenueRecognitionDetails."Property Name" := ContractRec."Property Name";
                            RevenueRecognitionDetails."Contract Tenure" := ContractRec."Contract Tenor";
                            RevenueRecognitionDetails."Unit Type" := ContractRec."Usage Type";
                            RevenueRecognitionDetails."Customer Name" := ContractRec."Customer Name";
                            RevenueRecognitionDetails."Contract Start Date" := ContractRec."Contract Start Date";
                            RevenueRecognitionDetails."Contract End Date" := ContractRec."Contract End Date";
                            RevenueRecognitionDetails."Grace Days" := ContractRec."Grace Period";
                            RevenueRecognitionDetails."Grace Start Date" := ContractRec."Grace Start Date";
                            RevenueRecognitionDetails."Grace End Date" := ContractRec."Grace End Date";
                            RevenueRecognitionDetails."Owner Name" := ContractRec."Owner's Name";

                            case
                            ContractRec."Praposal Type Selected" of
                                ContractRec."Praposal Type Selected"::"Single Unit":
                                    RevenueRecognitionDetails."Single Unit Names" := ContractRec."Unit Name";
                                ContractRec."Praposal Type Selected"::"Merge Unit":
                                    RevenueRecognitionDetails."Single Unit Names" := ContractRec."Single Unit Name";
                                else
                                    RevenueRecognitionDetails."Single Unit Names" := '';
                            end;

                            RevenueRecognitionDetails."Termination Date" := 0D;

                            // Add suspension information
                            SuspensionRec.Reset();
                            SuspensionRec.SetRange("Contract ID", ContractRec."Contract ID");
                            if SuspensionRec.FindFirst() then begin
                                RevenueRecognitionDetails."Suspension Start Date" := SuspensionRec.DateEffective;
                                RevenueRecognitionDetails."Suspension End Date" := SuspensionRec.SuspensionEndDate;
                            end;

                            ExistingRevenueRec.Reset();
                            ExistingRevenueRec.SetRange("Contract ID", RevenueRecognitionDetails."Contract ID");
                            if ExistingRevenueRec.FindFirst() then begin
                                Noofdays := ExistingRevenueRec."No Of Days";
                                RevenueRecognitionDetails."Multi Year Start Date" := ExistingRevenueRec."Multi Year Start Date";
                                RevenueRecognitionDetails."Multi Year End Date" := ExistingRevenueRec."Multi Year End Date";
                                RevenueRecognitionDetails."Item Type" := ExistingRevenueRec."Item Type";
                            end;


                            CalculatedDays := (RevenueRecognitionDetails."Multi Year End Date" - RevenueRecognitionDetails."Multi Year Start Date" + 1);

                            RevenueRecognitionDetails."No Of Days" := Noofdays;
                            RevenueRecognitionDetails."Posting Month" := MonthNo;
                            RevenueRecognitionDetails."Posting Year" := FinancialYear;
                            RevenueRecognitionDetails."Posting Period" := Format(RevenueRecognitionDetails."Posting Month") +
                  ' ' + Format(RevenueRecognitionDetails."Posting Year") + ' ' + '-' + ' ' +
                  Format(RevenueRecognitionDetails."Posting Month") + ' ' + Format(RevenueRecognitionDetails."Posting Year");
                            RevenueRecognitionDetails."Owner Name" := ContractRec."Owner's Name";
                            RevenueRecognitionDetails."Contract Amount" := -RentReductionAmount;
                            RevenueRecognitionDetails."Annual Amount" := -RentReductionAmount;
                            RevenueRecognitionDetails."Final Annual Amount" := -RentReductionAmount;
                            RevenueRecognitionDetails."Per Day Rent" := Round(RevenueRecognitionDetails."Annual Amount" / CalculatedDays);
                            RevenueRecognitionDetails."Total Value" := RevenueRecognitionDetails."Per Day Rent" * Noofdays;
                            RevenueRecognitionDetails."Owner Share" := RevenueRecognitionDetails."Per Day Rent" * Noofdays;
                            RevenueRecognitionDetails."Description" := 'Credit Note'; // Or whatever indicates this is a credit note entry
                            RevenueRecognitionDetails.Insert();
                        end;
                    until RequestCreditNotegrid.Next() = 0;
            until RequestCreditNote.Next() = 0;
        // until RequestCreditNotegrid.Next() = 0;
        // end;
    end;







    // Get termination date from Final Calculation table
    local procedure GetTerminationDate(ContractID: Integer; var RevenueRecognitionDetails: Record "Revenue Recognition Details")
    var
        FinalCalculation: Record "Final Calculation";
    begin
        FinalCalculation.Reset();
        FinalCalculation.SetRange("Contract ID", ContractID);
        if FinalCalculation.FindFirst() then
            RevenueRecognitionDetails."Termination Date" := FinalCalculation."Termination Date";
    end;

    // Get suspension details from Suspended Reason table
    local procedure GetSuspensionDetails(ContractID: Integer; var RevenueRecognitionDetails: Record "Revenue Recognition Details")
    var
        SuspendedReasonList: Record SuspendReasonTable;
    begin
        SuspendedReasonList.Reset();
        SuspendedReasonList.SetRange("Contract ID", ContractID);
        if SuspendedReasonList.FindFirst() then begin
            RevenueRecognitionDetails."Suspension Start Date" := SuspendedReasonList.DateEffective;
            RevenueRecognitionDetails."Suspension End Date" := SuspendedReasonList.SuspensionEndDate;
        end;
    end;

    ///////////////////////////////////////////////////////FIXEDMONTHRENT////////////////////////////////////////////////////////////

    procedure FetchContractDetailss(RevenueAllocation: Record "Revenue Allocation Details")
    var
        TenancyContract: Record "Tenancy Contract";
        RevenueStructure: Record "Revenue Structure";
        SelectedItemTypes: List of [Text];
        RevenueAllocationStartDate: Date;
        RevenueAllocationEndDate: Date;
    begin
        // Clear existing data
        ClearSubgridData();

        // Get selected Item Types for this Revenue Recognition Item
        GetSelectedItemTypess(SelectedItemTypes);

        // If no item types are selected, exit
        if SelectedItemTypes.Count = 0 then begin
            Message('Please select at least one Item Type.');
            exit;
        end;

        // Calculate month start and end dates
        RevenueAllocationStartDate := DMY2Date(1, RevenueAllocation.Month, RevenueAllocation."Financial Year");
        RevenueAllocationEndDate := CalcDate('<CM>', RevenueAllocationStartDate);

        // Process active contracts directly from Revenue Structure
        if TenancyContract.FindSet() then
            repeat
                // NEW: Check if contract should be processed based on status and dates
                if ShouldProcessContracts(TenancyContract, RevenueAllocation.Month, RevenueAllocation."Financial Year") then
                    // Check if contract is active during the selected period
                    if (TenancyContract."Contract Start Date" <= RevenueAllocationEndDate) and
                       (TenancyContract."Contract End Date" >= RevenueAllocationStartDate) then begin
                        // Get revenue structure details directly for this contract
                        RevenueStructure.Reset();
                        RevenueStructure.SetRange("Contract ID", TenancyContract."Contract ID");

                        // Filter by selected Item Types
                        RevenueStructure.SetFilter("Secondary Item Type", GetItemTypeFilters(SelectedItemTypes));

                        if RevenueStructure.FindSet() then
                            repeat
                                // Create Revenue Recognition Detail directly from Revenue Structure
                                CreateRevenueRecognitionDetailDirects(TenancyContract, RevenueStructure, RevenueAllocation);

                            until RevenueStructure.Next() = 0;
                    end;
            until TenancyContract.Next() = 0;

        // Process MISSED REVENUE for contracts that started in previous month
        ProcessAllMissedRevenueAllocationss(RevenueAllocation);

        ProcessCreditNoteEntriess(RevenueAllocationStartDate, RevenueAllocationEndDate, RevenueAllocation.Month, RevenueAllocation."Financial Year");

        // Refresh the page to show new details
        CurrPage.Update(false);
    end;

    // Enhanced procedure to process ALL missed revenue allocations dynamically
    local procedure ProcessAllMissedRevenueAllocationss(pCurrentAllocation: Record "Revenue Allocation Details")
    var
        TenancyContract: Record "Tenancy Contract";
        RevenueStructure: Record "Revenue Structure";
        RevenueAllocation: Record "Revenue Allocation Details";
        PreviousAllocationMonth: Integer;
        PreviousAllocationYear: Integer;
        PreviousAllocationStartDate: Date;
        PreviousAllocationEndDate: Date;
        SelectedItemTypes: List of [Text];
        MissedContractCount: Integer;
    begin
        // Get selected item types
        GetSelectedItemTypess(SelectedItemTypes);

        // Calculate previous month dynamically
        PreviousAllocationMonth := pCurrentAllocation.Month - 1;
        PreviousAllocationYear := pCurrentAllocation."Financial Year";

        // Handle year transition
        if PreviousAllocationMonth = 0 then begin
            PreviousAllocationMonth := 12;
            PreviousAllocationYear := PreviousAllocationYear - 1;
        end;

        // Calculate dates for the previous month
        PreviousAllocationStartDate := DMY2Date(1, PreviousAllocationMonth, PreviousAllocationYear);
        PreviousAllocationEndDate := CalcDate('<CM>', PreviousAllocationStartDate);

        // Initialize missed contract counter
        MissedContractCount := 0;

        // Find ALL contracts that started in previous month (date 2-31)
        TenancyContract.Reset();
        TenancyContract.SetFilter("Contract Start Date", '%1..%2',
            DMY2Date(2, PreviousAllocationMonth, PreviousAllocationYear),
            PreviousAllocationEndDate);

        if TenancyContract.FindSet() then
            repeat
                // Additional check: Contract should be active during previous month
                if (TenancyContract."Contract Start Date" <= PreviousAllocationEndDate) and
                   (TenancyContract."Contract End Date" >= PreviousAllocationStartDate) then

                    // Check if this contract was missed in previous allocation
                    if IsMissedRevenueAllocationForContracts(
                        TenancyContract."Contract ID",
                        PreviousAllocationMonth,
                        PreviousAllocationYear,
                        pCurrentAllocation.Month,
                        pCurrentAllocation."Financial Year"
                    ) then begin

                        // Get revenue structure for this contract
                        RevenueStructure.Reset();
                        RevenueStructure.SetRange("Contract ID", TenancyContract."Contract ID");
                        RevenueStructure.SetFilter("Secondary Item Type", GetItemTypeFilter(SelectedItemTypes));

                        if RevenueStructure.FindFirst() then begin
                            // Create temporary allocation record for missed month
                            RevenueAllocation := pCurrentAllocation;
                            RevenueAllocation.Month := PreviousAllocationMonth;
                            RevenueAllocation."Financial Year" := PreviousAllocationYear;

                            // Create missed revenue allocation for this contract
                            CreateMissedRevenueAllocationForContracts(
                                TenancyContract,
                                RevenueAllocation
                            );

                            MissedContractCount += 1;
                        end;
                    end;
            until TenancyContract.Next() = 0;

        // Optional: Show message about missed contracts processed
        if MissedContractCount > 0 then
            Message('Processed %1 missed revenue allocations for previous month (%2/%3)',
                MissedContractCount, PreviousAllocationMonth, PreviousAllocationYear);
    end;

    // Enhanced check for missed revenue allocation - more dynamic
    local procedure IsMissedRevenueAllocationForContracts(
        ContractID: Integer;
        CheckMonth: Integer;
        CheckYear: Integer;
        currentMonth: Integer;
        currentYear: Integer
    ): Boolean
    var
        ExistingRevenue: Record "Revenue Recognition Details";
        RegularAllocationExists: Boolean;
        MissedAllocationExists: Boolean;
    begin
        // Check if regular revenue was already allocated for this contract in this month
        ExistingRevenue.Reset();
        ExistingRevenue.SetRange("Contract Id", ContractID);
        ExistingRevenue.SetRange("Posting Month", currentMonth);
        ExistingRevenue.SetRange("Posting Year", currentYear);
        ExistingRevenue.SetFilter("Posting Period", '<>%1', 'MISSED*'); // Exclude missed allocations

        RegularAllocationExists := not ExistingRevenue.IsEmpty;

        // Check if missed allocation already exists for this contract
        ExistingRevenue.Reset();
        ExistingRevenue.SetRange("Contract Id", ContractID);
        ExistingRevenue.SetRange("Posting Month", CheckMonth);
        ExistingRevenue.SetRange("Posting Year", CheckYear);
        ExistingRevenue.SetFilter("Posting Period", '%1', 'MISSED*'); // Only missed allocations

        MissedAllocationExists := not ExistingRevenue.IsEmpty;

        // Return true if no regular allocation exists AND no missed allocation exists
        exit(RegularAllocationExists and not MissedAllocationExists);
    end;

    // Create missed revenue allocation for a specific contract
    local procedure CreateMissedRevenueAllocationForContracts(
        pTenancyContract: Record "Tenancy Contract";
        pMissedAllocation: Record "Revenue Allocation Details"
    )
    var
        RevenueStructureSubpage: Record "Revenue Structure Subpage";
        SelectedItemTypes: List of [Text];
        ItemType: Text;
    begin
        // Get selected item types
        GetSelectedItemTypess(SelectedItemTypes);

        // Process each selected item type for this contract
        foreach ItemType in SelectedItemTypes do begin
            // Get revenue structure subpage for this item type
            RevenueStructureSubpage.Reset();
            RevenueStructureSubpage.SetRange("Contract ID", pTenancyContract."Contract ID");
            RevenueStructureSubpage.SetRange("Secondary Item Type", ItemType);

            if RevenueStructureSubpage.FindFirst() then
                // Create missed revenue allocation record
                CreateSingleMissedRevenueAllocations(
                    pTenancyContract,
                    RevenueStructureSubpage,
                    pMissedAllocation,
                    ItemType);
        end;
    end;

    // Enhanced missed revenue allocation creation with better contract detection
    local procedure CreateSingleMissedRevenueAllocations(
        pTenancyContract: Record "Tenancy Contract";
        pRevenueStructureSubpage: Record "Revenue Structure Subpage";
        pMissedAllocation: Record "Revenue Allocation Details";
        pItemType: Text
    )
    var
        RevenueRecognitionDetails: Record "Revenue Recognition Details";
        FinalCalculation: Record "Final Calculation";
        NextEntryNo: Integer;
        NoOfDays: Integer;
        TerminationDate: Date;
        SuspensionDate: Date;
        IsContractSuspended: Boolean;
        ContractStartInMonth: Integer;
        ContractStartDay: Integer;
        permonthrent: Decimal;
    begin

        // Get contract start day to verify it's in range 2-31
        ContractStartDay := Date2DMY(pTenancyContract."Contract Start Date", 1);
        ContractStartInMonth := Date2DMY(pTenancyContract."Contract Start Date", 2);

        // Only process if contract started on day 2-31 of the previous month
        if (ContractStartInMonth = pMissedAllocation.Month) and (ContractStartDay >= 2) then begin

            // Get termination date for this contract
            FinalCalculation.Reset();
            FinalCalculation.SetRange("Contract ID", pTenancyContract."Contract ID");
            if FinalCalculation.FindFirst() then
                TerminationDate := FinalCalculation."Termination Date"
            else
                TerminationDate := 0D;

            // Check if contract was suspended in the missed month
            IsContractSuspended := IsContractSuspendedInPeriods(
                pTenancyContract."Contract ID",
                pMissedAllocation.Month,
                pMissedAllocation."Financial Year",
                SuspensionDate
            );

            // Calculate number of days for missed allocation
            NoOfDays := CalculatePerfectNoOfDayss(
                pTenancyContract."Contract Start Date",
                pTenancyContract."Contract End Date",
                pMissedAllocation.Month,
                pMissedAllocation."Financial Year",
                TerminationDate,
                IsContractSuspended,
                SuspensionDate
            );

            // Create missed revenue record only if there are days to allocate
            if NoOfDays > 0 then begin
                // Get next entry number
                RevenueRecognitionDetails.Reset();
                if RevenueRecognitionDetails.FindLast() then
                    NextEntryNo := RevenueRecognitionDetails."Entry No." + 1
                else
                    NextEntryNo := 1;

                // Create new Revenue Recognition Detail record for missed allocation
                RevenueRecognitionDetails.Init();
                RevenueRecognitionDetails."Entry No." := NextEntryNo;
                RevenueRecognitionDetails."RR_No." := Rec."RR_No.";

                // Copy contract details
                RevenueRecognitionDetails."Contract Id" := pTenancyContract."Contract ID";
                RevenueRecognitionDetails."Property Name" := pTenancyContract."Property Name";
                RevenueRecognitionDetails."Customer Name" := pTenancyContract."Customer Name";
                RevenueRecognitionDetails."Contract Start Date" := pTenancyContract."Contract Start Date";
                RevenueRecognitionDetails."Contract End Date" := pTenancyContract."Contract End Date";
                RevenueRecognitionDetails."Owner Name" := pTenancyContract."Owner's Name";
                RevenueRecognitionDetails."Contract Tenure" := pTenancyContract."Contract Tenor";
                RevenueRecognitionDetails."Grace Days" := pTenancyContract."Grace Period";
                RevenueRecognitionDetails."Grace Start Date" := pTenancyContract."Grace Start Date";
                RevenueRecognitionDetails."Grace End Date" := pTenancyContract."Grace End Date";
                RevenueRecognitionDetails."Unit Type" := pTenancyContract."Usage Type";
                RevenueRecognitionDetails."Description" := 'Missed Revenue';

                // Set unit names based on proposal type
                case
                    pTenancyContract."Praposal Type Selected" of
                    pTenancyContract."Praposal Type Selected"::"Single Unit":
                        RevenueRecognitionDetails."Single Unit Names" := pTenancyContract."Unit Name";
                    pTenancyContract."Praposal Type Selected"::"Merge Unit":
                        RevenueRecognitionDetails."Single Unit Names" := pTenancyContract."Single Unit Name";
                    else
                        RevenueRecognitionDetails."Single Unit Names" := '';
                end;

                // Add missed allocation period details
                RevenueRecognitionDetails."Posting Month" := pMissedAllocation.Month;
                RevenueRecognitionDetails."Posting Year" := pMissedAllocation."Financial Year";

                // Mark as missed revenue allocation with contract start date info
                // RevenueRecognitionDetails."Posting Period" :=
                //     'MISSED: ' + FORMAT(pMissedAllocation.Month) + '/' + FORMAT(pMissedAllocation."Financial Year") +
                //     ' (Started: ' + FORMAT(pTenancyContract."Contract Start Date") + ')';
                RevenueRecognitionDetails."Posting Period" := GetMonthName(pMissedAllocation.Month) + ' ' +
                                       Format(pMissedAllocation."Financial Year") + ' ' + '-' + ' ' + GetMonthName(pMissedAllocation.Month) + ' ' + Format(pMissedAllocation."Financial Year");


                // Set termination date and number of days
                RevenueRecognitionDetails."Termination Date" := TerminationDate;
                RevenueRecognitionDetails."No Of Days" := NoOfDays;

                // Get suspension details
                GetSuspensionDetails(pTenancyContract."Contract ID", RevenueRecognitionDetails);

                // Set revenue structure details from subpage
                RevenueRecognitionDetails."Multi Year Start Date" := pRevenueStructureSubpage."Period Start Date";
                RevenueRecognitionDetails."Multi Year End Date" := pRevenueStructureSubpage."Period End Date";
                RevenueRecognitionDetails."Annual Amount" := pRevenueStructureSubpage."Final Annual Amount" + pRevenueStructureSubpage."Final Annual Amount" * 5 / 100;
                RevenueRecognitionDetails."Final Annual Amount" := RevenueRecognitionDetails."Annual Amount";
                RevenueRecognitionDetails."Item Type" := CopyStr(pItemType, 1, StrLen(pItemType));
                RevenueRecognitionDetails."Contract Amount" := pRevenueStructureSubpage."Final Annual Amount";

                permonthrent := RevenueRecognitionDetails."Final Annual Amount" / 12;
                // Calculate amounts
                RevenueRecognitionDetails."Per Month Rent" := Calculatepermonthrents(permonthrent, NoOfDays, pMissedAllocation.Month, pMissedAllocation."Financial Year"); // Use the per day rent passed from the grid

                RevenueRecognitionDetails."Total Value" := RevenueRecognitionDetails."No Of Days" * RevenueRecognitionDetails."Per Day Rent";
                RevenueRecognitionDetails."Owner Share" := RevenueRecognitionDetails."Total Value";

                // Insert the missed revenue record
                RevenueRecognitionDetails.Insert(true);
            end;
        end;
    end;

    // Perfect calculation of number of days - enhanced for missed allocations
    local procedure CalculatePerfectNoOfDayss(
        ContractStartDate: Date;
        ContractEndDate: Date;
        ProcessMonth: Integer;
        ProcessYear: Integer;
        TerminationDate: Date;
        IsContractSuspended: Boolean;
        SuspensionDate: Date
    ): Integer
    var
        MonthStartDate: Date;
        MonthEndDate: Date;
        EffectiveStartDate: Date;
        EffectiveEndDate: Date;
        NoOfDays: Integer;
    begin
        // Calculate month boundaries
        MonthStartDate := DMY2Date(1, ProcessMonth, ProcessYear);
        MonthEndDate := CalcDate('<CM>', MonthStartDate);

        // For missed allocations, use the actual contract start date if it's within the month
        if (ContractStartDate >= MonthStartDate) and (ContractStartDate <= MonthEndDate) then
            EffectiveStartDate := ContractStartDate
        else
            EffectiveStartDate := MonthStartDate;

        // Determine effective end date (earlier of contract end, month end, or termination date)
        EffectiveEndDate := MonthEndDate;

        if ContractEndDate < EffectiveEndDate then
            EffectiveEndDate := ContractEndDate;

        if (TerminationDate <> 0D) and (TerminationDate < EffectiveEndDate) then
            EffectiveEndDate := TerminationDate;

        // Handle suspension
        if IsContractSuspended and (SuspensionDate <> 0D) and (SuspensionDate < EffectiveEndDate) then
            EffectiveEndDate := SuspensionDate;

        // Calculate number of days
        if EffectiveEndDate >= EffectiveStartDate then
            NoOfDays := EffectiveEndDate - EffectiveStartDate + 1
        else
            NoOfDays := 0;

        exit(NoOfDays);
    end;



    // UPDATED: Function to check if contract should be processed
    local procedure ShouldProcessContracts(pTenancyContract: Record "Tenancy Contract"; pAllocationMonth: Integer; pAllocationYear: Integer): Boolean
    begin
        // 1. If Active - Always process
        if pTenancyContract."Tenant Contract Status" = pTenancyContract."Tenant Contract Status"::Active then
            exit(true);

        // 2. If Suspended - Check if suspension date falls in selected month/year
        if pTenancyContract."Tenant Contract Status" = pTenancyContract."Tenant Contract Status"::Suspended then
            if HasSuspensionInSelectedPeriods(pTenancyContract."Contract ID", pAllocationMonth, pAllocationYear) then
                exit(true);

        // 3. If Terminated - Check if termination date falls in selected month/year
        if pTenancyContract."Tenant Contract Status" = pTenancyContract."Tenant Contract Status"::Terminated then
            if HasTerminationInSelectedPeriods(pTenancyContract."Contract ID", pAllocationMonth, pAllocationYear) then
                exit(true);

        // Default: Don't process
        exit(false);
    end;

    // NEW: Check if suspension date falls in selected month/year
    local procedure HasSuspensionInSelectedPeriods(pContractID: Integer; pAllocationMonth: Integer; pAllocationYear: Integer): Boolean
    var
        SuspendedReasonList: Record SuspendReasonTable;
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
    begin
        // Calculate selected month start and end dates
        SelectedMonthStart := DMY2Date(1, pAllocationMonth, pAllocationYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Check if suspension date falls within selected period
        SuspendedReasonList.Reset();
        SuspendedReasonList.SetRange("Contract ID", pContractID);
        if SuspendedReasonList.FindFirst() then
            if (SuspendedReasonList.DateEffective >= SelectedMonthStart) and
               (SuspendedReasonList.DateEffective <= SelectedMonthEnd) then
                exit(true);

        exit(false);
    end;

    // NEW: Check if termination date falls in selected month/year
    local procedure HasTerminationInSelectedPeriods(pContractID: Integer; pAllocationMonth: Integer; pAllocationYear: Integer): Boolean
    var
        FinalCalculation: Record "Final Calculation";
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
    begin
        // Calculate selected month start and end dates
        SelectedMonthStart := DMY2Date(1, pAllocationMonth, pAllocationYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Check if termination date falls within selected period
        FinalCalculation.Reset();
        FinalCalculation.SetRange("Contract ID", pContractID);
        if FinalCalculation.FindFirst() then
            if (FinalCalculation."Termination Date" <> 0D) and
               (FinalCalculation."Termination Date" >= SelectedMonthStart) and
               (FinalCalculation."Termination Date" <= SelectedMonthEnd) then
                exit(true);

        exit(false);
    end;

    local procedure GetSelectedItemTypess(var pItemTypes: List of [Text])
    var
        RevenueRecognitionItem: Record "Revenue Recognition Item";
    begin
        // Set filter to get all selected Item Types
        RevenueRecognitionItem.SetRange("RR_No.", Rec."RR_No.");

        // Find all records for this Revenue Recognition
        if RevenueRecognitionItem.FindSet() then
            repeat
                // Only add non-empty Item Types
                if RevenueRecognitionItem."Item Type" <> '' then
                    // Check if Item Type is not already in the list
                    if not pItemTypes.Contains(RevenueRecognitionItem."Item Type") then
                        pItemTypes.Add(RevenueRecognitionItem."Item Type");
            until RevenueRecognitionItem.Next() = 0;
    end;

    local procedure GetItemTypeFilters(pItemTypes: List of [Text]): Text
    var
        FilterText: Text;
        ItemType: Text;
    begin
        // Build filter text
        foreach ItemType in pItemTypes do
            if FilterText = '' then
                FilterText := ItemType
            else
                FilterText += '|' + ItemType;

        exit(FilterText);
    end;

    procedure CalculateNoOfDayss(
           pContractStartDate: Date;
           pContractEndDate: Date;
           pAllocationMonth: Integer;
           pAllocationYear: Integer;
           pTerminationDate: Date
       ): Integer
    var
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
        EffectiveStartDate: Date;
        EffectiveEndDate: Date;
        NoOfDays: Integer;
        TerminationDay: Integer;
    begin
        // Start and end of the selected month
        SelectedMonthStart := DMY2Date(1, pAllocationMonth, pAllocationYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Special Termination case:
        if (pTerminationDate <> 0D) then
            if (pTerminationDate < pContractEndDate) and
            (Date2DMY(pTerminationDate, 2) = pAllocationMonth) and
            (Date2DMY(pTerminationDate, 3) = pAllocationYear) then begin
                TerminationDay := Date2DMY(pTerminationDate, 1); // e.g., 3
                // Message('%1 - %2', pTerminationDate, TerminationDay);
                exit(TerminationDay);
            end;

        // Return 0 if contract is outside of the selected month
        if (pContractStartDate > SelectedMonthEnd) or (pContractEndDate < SelectedMonthStart) then
            exit(0);

        // Determine the effective start date
        if pContractStartDate > SelectedMonthStart then
            EffectiveStartDate := pContractStartDate
        else
            EffectiveStartDate := SelectedMonthStart;

        // Determine the effective end date
        if pContractEndDate < SelectedMonthEnd then
            EffectiveEndDate := pContractEndDate
        else
            EffectiveEndDate := SelectedMonthEnd;

        // Calculate inclusive number of days
        NoOfDays := EffectiveEndDate - EffectiveStartDate + 1;

        exit(NoOfDays);
    end;

    // NEW: Calculate number of days for suspended period allocation
    local procedure CalculateSuspendedPeriodDayss(
         pSuspensionStartDate: Date;
         pSuspensionEndDate: Date
     ): Integer
    var
        NoOfDays: Integer;
    begin
        // If no suspension dates, return 0
        if (pSuspensionStartDate = 0D) or (pSuspensionEndDate = 0D) then
            exit(0);

        // આ આખો suspension period return કરે છે
        // તમારા case માં: 04/11/2025 - 05/10/2025 + 1 = 31 days
        NoOfDays := pSuspensionEndDate - pSuspensionStartDate + 1;

        exit(NoOfDays);
    end;

    // Also need to add a separate function for active period after suspension
    local procedure CalculateActivePeriodDaysAfterSuspensions(
        pSuspensionStartDate: Date;
        pSuspensionEndDate: Date;
        pAllocationEndDate: Date
    ): Integer
    var
        EffectiveStartDate: Date;
        EffectiveEndDate: Date;
        NoOfDays: Integer;
    begin
        // If no suspension dates, return 0
        if (pSuspensionStartDate = 0D) or (pSuspensionEndDate = 0D) then
            exit(0);

        // Start from the day AFTER suspension ends
        EffectiveStartDate := pSuspensionEndDate + 1;

        // End at allocation end date
        EffectiveEndDate := pAllocationEndDate;

        // Calculate inclusive number of active days after suspension
        if EffectiveEndDate >= EffectiveStartDate then
            NoOfDays := EffectiveEndDate - EffectiveStartDate + 1
        else
            NoOfDays := 0;

        exit(NoOfDays);
    end;

    // NEW: Check if contract has suspension to active scenario
    local procedure HasSuspensionToActiveScenarios(
        pContractID: Integer;
        pAllocationStartDate: Date;
        pAllocationEndDate: Date;
        var pSuspensionStartDate: Date;
        var pSuspensionEndDate: Date
    ): Boolean
    var
        SuspendedReasonList: Record SuspendReasonTable;
    begin
        SuspendedReasonList.Reset();
        SuspendedReasonList.SetRange("Contract ID", pContractID);
        if SuspendedReasonList.FindFirst() then begin
            pSuspensionStartDate := SuspendedReasonList.DateEffective;
            pSuspensionEndDate := SuspendedReasonList.SuspensionEndDate;

            // Check if contract was suspended and then became active within the allocation period
            if (pSuspensionStartDate <> 0D) and (pSuspensionEndDate <> 0D) then
                // Check if suspension ended before allocation end date
                if (pSuspensionEndDate < pAllocationEndDate) and
                // (pSuspensionStartDate <= pAllocationEndDate) and 
                (pSuspensionEndDate >= pAllocationStartDate) then
                    exit(true);
        end;

        exit(false);
    end;

    // NEW: Function to check if contract is suspended in selected month/year
    local procedure IsContractSuspendedInPeriods(
        pContractID: Integer;
        pAllocationMonth: Integer;
        pAllocationYear: Integer;
        var pSuspensionDate: Date
    ): Boolean
    var
        SuspendedReasonList: Record SuspendReasonTable;
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
    begin
        // Calculate selected month start and end dates
        SelectedMonthStart := DMY2Date(1, pAllocationMonth, pAllocationYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Check if contract is suspended
        SuspendedReasonList.Reset();
        SuspendedReasonList.SetRange("Contract ID", pContractID);
        if SuspendedReasonList.FindFirst() then
            // Check if suspension date falls within selected month/year
            if (SuspendedReasonList.DateEffective >= SelectedMonthStart) and
               (SuspendedReasonList.DateEffective <= SelectedMonthEnd) then begin
                pSuspensionDate := SuspendedReasonList.DateEffective;
                exit(true);
            end;

        exit(false);
    end;

    // NEW: Calculate days for suspended contract (only till suspension date)
    local procedure CalculateSuspendedContractDayss(
        pContractStartDate: Date;
        pContractEndDate: Date;
        pAllocationMonth: Integer;
        pAllocationYear: Integer;
        pSuspensionDate: Date
    ): Integer
    var
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
        EffectiveStartDate: Date;
        EffectiveEndDate: Date;
        NoOfDays: Integer;
    begin
        // Start and end of the selected month
        SelectedMonthStart := DMY2Date(1, pAllocationMonth, pAllocationYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Return 0 if contract is outside of the selected month
        if (pContractStartDate > SelectedMonthEnd) or (pContractEndDate < SelectedMonthStart) then
            exit(0);

        // Determine the effective start date
        if pContractStartDate > SelectedMonthStart then
            EffectiveStartDate := pContractStartDate
        else
            EffectiveStartDate := SelectedMonthStart;

        // For suspended contracts, effective end date is the suspension date
        // (not the full month or contract end date)
        EffectiveEndDate := pSuspensionDate;

        // Make sure suspension date is not before the effective start
        if EffectiveEndDate < EffectiveStartDate then
            exit(0);

        // Calculate inclusive number of days till suspension date
        NoOfDays := EffectiveEndDate - EffectiveStartDate;

        exit(NoOfDays);
    end;

    // MODIFIED: Update your existing CreateRevenueRecognitionDetailDirect procedure
    local procedure CreateRevenueRecognitionDetailDirects(
        pTenancyContract: Record "Tenancy Contract";
        pRevenueStructure: Record "Revenue Structure";
        pRevenueAllocation: Record "Revenue Allocation Details"
    )
    var
        FinalCalculation: Record "Final Calculation";
        revenuestructuredetails: Record "Revenue Structure Subpage";
        PostingDate: Date;
        NoOfDays: Integer;
        RevenueAllocationStartDate: Date;
        RevenueAllocationEndDate: Date;
        SuspensionStartDate: Date;
        SuspensionEndDate: Date;
        SuspendedPeriodDays: Integer;
        SuspendedActivePeriodDays: Integer;
        TerminationDate: Date;
        SuspensionDate: Date;
        IsContractSuspended: Boolean;
    begin
        // Calculate month start and end dates
        RevenueAllocationStartDate := DMY2Date(1, pRevenueAllocation.Month, pRevenueAllocation."Financial Year");
        RevenueAllocationEndDate := CalcDate('<CM>', RevenueAllocationStartDate);

        // Convert Posting Month + Year to Date (assume 1st of that month)
        PostingDate := DMY2Date(1, pRevenueAllocation.Month, pRevenueAllocation."Financial Year");

        // Get termination date for this contract
        FinalCalculation.Reset();
        FinalCalculation.SetRange("Contract ID", pTenancyContract."Contract ID");
        if FinalCalculation.FindFirst() then
            TerminationDate := FinalCalculation."Termination Date"
        else
            TerminationDate := 0D;

        // NEW: Check if contract is suspended in selected month/year
        IsContractSuspended := IsContractSuspendedInPeriods(
            pTenancyContract."Contract ID",
            pRevenueAllocation.Month,
            pRevenueAllocation."Financial Year",
            SuspensionDate
        );

        // Calculate number of days based on suspension status
        if IsContractSuspended then
            // For suspended contracts, calculate days only till suspension date
            NoOfDays := CalculateSuspendedContractDayss(
                pTenancyContract."Contract Start Date",
                pTenancyContract."Contract End Date",
                pRevenueAllocation.Month,
                pRevenueAllocation."Financial Year",
                SuspensionDate)
        else
            // For normal contracts, use existing logic
            NoOfDays := CalculateNoOfDayss(
                pTenancyContract."Contract Start Date",
                pTenancyContract."Contract End Date",
                pRevenueAllocation.Month,
                pRevenueAllocation."Financial Year",
                TerminationDate
            );

        // Create revenue record only if there are days to allocate
        // if NoOfDays > 0 then begin
        //     CreateRevenueRecords(
        //         pTenancyContract,
        //         pRevenueStructure,
        //         pRevenueAllocation,
        //         revenuestructuredetails,
        //         PostingDate,
        //         NoOfDays,
        //         PerDayAmount,
        //         IsContractSuspended // Pass suspension status
        //     );
        // end;

        // Keep existing logic for suspension to active scenario
        if HasSuspensionToActiveScenarios(
            pTenancyContract."Contract ID",
            RevenueAllocationStartDate,
            RevenueAllocationEndDate,
            SuspensionStartDate,
            SuspensionEndDate
        ) then begin
            SuspendedPeriodDays := CalculateSuspendedPeriodDayss(
                SuspensionStartDate,
                SuspensionEndDate
            );
            SuspendedActivePeriodDays := CalculateActivePeriodDaysAfterSuspensions(
                SuspensionStartDate,
                SuspensionEndDate,
                RevenueAllocationEndDate
            );

            if SuspendedPeriodDays > 0 then
                CreateRevenueRecords(
                    pTenancyContract,
                    pRevenueStructure,
                    pRevenueAllocation,
                    revenuestructuredetails,
                    PostingDate,
                    SuspendedPeriodDays,
                    true);

            if SuspendedActivePeriodDays > 0 then
                CreateRevenueRecords(
                    pTenancyContract,
                    pRevenueStructure,
                    pRevenueAllocation,
                    revenuestructuredetails,
                    PostingDate,
                    SuspendedActivePeriodDays,
                    true);

        end else
            if NoOfDays > 0 then
                CreateRevenueRecords(
                    pTenancyContract,
                    pRevenueStructure,
                    pRevenueAllocation,
                    revenuestructuredetails,
                    PostingDate,
                    NoOfDays,
                    IsContractSuspended);
    end;

    // NEW: Common procedure to create revenue record
    local procedure CreateRevenueRecords(
        pTenancyContract: Record "Tenancy Contract";
        pRevenueStructure: Record "Revenue Structure";
        pRevenueAllocation: Record "Revenue Allocation Details";
        var revenuestructuredetails: Record "Revenue Structure Subpage";
        PostingDate: Date;
        NoOfDays: Integer;
        IsSuspendedPeriodAllocation: Boolean
    )
    var
        RevenueRecognitionDetails: Record "Revenue Recognition Details";
        NextEntryNo: Integer;
        ActualNoOfDays: Integer;
        permonthrent: Decimal;
        FirstDayOfTargetMonth: Date;
        LastDayOfTargetMonth: Date;
    begin
        // Get next entry number
        RevenueRecognitionDetails.Reset();
        if RevenueRecognitionDetails.FindLast() then
            NextEntryNo := RevenueRecognitionDetails."Entry No." + 1
        else
            NextEntryNo := 1;

        PostingDate := DMY2Date(1, pRevenueAllocation.Month, pRevenueAllocation."Financial Year");


        FirstDayOfTargetMonth := DMY2Date(1, pRevenueAllocation.Month, pRevenueAllocation."Financial Year");
        LastDayOfTargetMonth := CALCDATE('<CM>', FirstDayOfTargetMonth);



        // Create new Revenue Recognition Detail record
        RevenueRecognitionDetails.Init();
        RevenueRecognitionDetails."Entry No." := NextEntryNo;
        RevenueRecognitionDetails."RR_No." := Rec."RR_No.";

        // Copy contract details
        RevenueRecognitionDetails."Contract Id" := pTenancyContract."Contract ID";
        RevenueRecognitionDetails."Property Name" := pTenancyContract."Property Name";
        RevenueRecognitionDetails."Customer Name" := pTenancyContract."Customer Name";
        RevenueRecognitionDetails."Contract Start Date" := pTenancyContract."Contract Start Date";
        RevenueRecognitionDetails."Contract End Date" := pTenancyContract."Contract End Date";
        RevenueRecognitionDetails."Contract Amount" := pRevenueStructure."Amount Including VAT";
        RevenueRecognitionDetails."Owner Name" := pTenancyContract."Owner's Name";
        RevenueRecognitionDetails."Contract Tenure" := pTenancyContract."Contract Tenor";
        RevenueRecognitionDetails."Grace Days" := pTenancyContract."Grace Period";
        RevenueRecognitionDetails."Grace Start Date" := pTenancyContract."Grace Start Date";
        RevenueRecognitionDetails."Grace End Date" := pTenancyContract."Grace End Date";
        RevenueRecognitionDetails."Unit Type" := pTenancyContract."Usage Type";
        RevenueRecognitionDetails."Item Type" := pRevenueStructure."Secondary Item Type";
        RevenueRecognitionDetails."Description" := 'Regular';

        case
                    pTenancyContract."Praposal Type Selected" of
            pTenancyContract."Praposal Type Selected"::"Single Unit":
                RevenueRecognitionDetails."Single Unit Names" := pTenancyContract."Unit Name";
            pTenancyContract."Praposal Type Selected"::"Merge Unit":
                RevenueRecognitionDetails."Single Unit Names" := pTenancyContract."Single Unit Name";
            else
                RevenueRecognitionDetails."Single Unit Names" := '';
        end;

        // Add allocation period details
        RevenueRecognitionDetails."Posting Month" := pRevenueAllocation.Month;
        RevenueRecognitionDetails."Posting Year" := pRevenueAllocation."Financial Year";

        // NEW: Add description to differentiate regular vs suspended period allocation
        if IsSuspendedPeriodAllocation then
            RevenueRecognitionDetails."Posting Period" := Format(RevenueRecognitionDetails."Posting Month") +
            ' ' + Format(RevenueRecognitionDetails."Posting Year") + ' ' + '-' + ' ' +
            Format(RevenueRecognitionDetails."Posting Month") + ' ' + Format(RevenueRecognitionDetails."Posting Year")

        else
            RevenueRecognitionDetails."Posting Period" := Format(RevenueRecognitionDetails."Posting Month") +
           ' ' + Format(RevenueRecognitionDetails."Posting Year") + ' ' + '-' + ' ' +
           Format(RevenueRecognitionDetails."Posting Month") + ' ' + Format(RevenueRecognitionDetails."Posting Year");


        // Get termination date from Final Calculation by Contract ID match
        GetTerminationDates(pTenancyContract."Contract ID", RevenueRecognitionDetails);

        // IMPORTANT: For suspension scenarios, use the passed NoOfDays directly
        // For regular scenarios, recalculate using the standard function
        if IsSuspendedPeriodAllocation then
            ActualNoOfDays := NoOfDays
        else
            ActualNoOfDays := CalculateNoOfDays(
                pTenancyContract."Contract Start Date",
                pTenancyContract."Contract End Date",
                pRevenueAllocation.Month,
                pRevenueAllocation."Financial Year",
                RevenueRecognitionDetails."Termination Date");

        RevenueRecognitionDetails."No Of Days" := ActualNoOfDays;

        // Get suspension details from Suspended Reason List by Contract ID match
        GetSuspensionDetailss(pTenancyContract."Contract ID", RevenueRecognitionDetails);

        revenuestructuredetails.Reset();
        revenuestructuredetails.SetRange("Contract ID", RevenueRecognitionDetails."Contract ID");
        revenuestructuredetails.SetRange("Secondary Item Type", pRevenueStructure."Secondary Item Type");
        if revenuestructuredetails.FindSet() then
            repeat
                // if (revenuestructuredetails."Period Start Date" <= PostingDate) and
                //    (revenuestructuredetails."Period End Date" >= PostingDate) then begin
                if ((revenuestructuredetails."Period Start Date" >= FirstDayOfTargetMonth) and
      (revenuestructuredetails."Period Start Date" <= LastDayOfTargetMonth)) OR
       ((revenuestructuredetails."Period End Date" <= LastDayOfTargetMonth) and
      (revenuestructuredetails."Period End Date" >= FirstDayOfTargetMonth)) OR
      ((revenuestructuredetails."Period Start Date" <= FirstDayOfTargetMonth) and
      (revenuestructuredetails."Period End Date" >= LastDayOfTargetMonth)) then begin
                    RevenueRecognitionDetails."Multi Year Start Date" := revenuestructuredetails."Period Start Date";
                    RevenueRecognitionDetails."Multi Year End Date" := revenuestructuredetails."Period End Date";

                    if revenuestructuredetails."VAT %" = 1 then
                        revenuestructuredetails."VAT %" := 5
                    else
                        revenuestructuredetails."VAT %" := 0;

                    RevenueRecognitionDetails."Annual Amount" := revenuestructuredetails."Final Annual Amount" + revenuestructuredetails."Final Annual Amount" * revenuestructuredetails."VAT %" / 100;
                    RevenueRecognitionDetails."Final Annual Amount" := RevenueRecognitionDetails."Annual Amount";
                end;
            until revenuestructuredetails.Next() = 0;

        permonthrent := RevenueRecognitionDetails."Final Annual Amount" / 12;
        RevenueRecognitionDetails."Per Month Rent" := calculatepermonthrent(permonthrent, ActualNoOfDays, pRevenueAllocation.Month, pRevenueAllocation."Financial Year"); // Use the per day rent passed from the grid
        RevenueRecognitionDetails."Total Value" := RevenueRecognitionDetails."No Of Days" * RevenueRecognitionDetails."Per Month Rent";
        RevenueRecognitionDetails."Owner Share" := RevenueRecognitionDetails."Total Value";

        // Insert the record
        RevenueRecognitionDetails.Insert(true);
    end;







    // New procedure to process credit note entries with debugging
    procedure ProcessCreditNoteEntriess(SelectedMonthStart: Date; SelectedMonthEnd: Date; MonthNo: Integer; FinancialYear: Integer)
    var
        RequestCreditNotegrid: Record "Request Credit Note Grid";
        RequestCreditNote: Record "Request Credit Note";
        ContractRec: Record "Tenancy Contract";
        RevenueRecognitionDetails: Record "Revenue Recognition Details";
        ExistingRevenueRec: Record "Revenue Recognition Details";
        paymentschedule: Record "Payment Schedule2";
        SuspensionRec: Record SuspendReasonTable;
        ShouldProcessCreditNote: Boolean;
        NoOfDays: Integer;
        NextEntryNo: Integer;
        permonthrent: Decimal;
        RentReductionAmount: Decimal;
        SelectedItemTypes: List of [Text];
        itemTypeFilter: Text;
    begin
        GetSelectedItemTypess(SelectedItemTypes);
        itemTypeFilter := GetItemTypeFilter(SelectedItemTypes);

        RequestCreditNote.SetRange(Status, RequestCreditNote.Status::Approved);
        if RequestCreditNote.FindSet() then
            repeat
                RentReductionAmount := 0;
                RequestCreditNotegrid.SetRange("Request No.", RequestCreditNote."Request No.");
                RequestCreditNotegrid.SetFilter(Charges, itemTypeFilter);
                if RequestCreditNotegrid.FindSet() then
                    repeat
                        RentReductionAmount := RequestCreditNotegrid."Total Reduction";
                        // else
                        //     // Skip processing if Rent line is not found
                        //     exit;


                        if RevenueRecognitionDetails.FindLast() then
                            NextEntryNo := RevenueRecognitionDetails."Entry No." + 1
                        else
                            NextEntryNo := 1;

                        // LineNo += 1;
                        ShouldProcessCreditNote := false;

                        // Get contract details for this credit note
                        ContractRec.Reset();
                        ContractRec.SetRange("Contract ID", RequestCreditNotegrid."Contract ID");
                        ContractRec.SetRange("Tenant Contract Status", ContractRec."Tenant Contract Status"::Active);
                        if ContractRec.FindFirst() then begin
                            paymentschedule.SetRange("Contract ID", ContractRec."Contract ID");
                            paymentschedule.SetRange("Payment Series", RequestCreditNotegrid."Payment Series");
                            //  paymentschedule.SetRange("Secondary Item Type", 'Rent');
                            if paymentschedule.FindFirst() then
                                // Check if contract dates overlap with selected month
                                if ((ContractRec."Contract Start Date" <= SelectedMonthEnd) and
                                    (ContractRec."Contract End Date" >= SelectedMonthStart)) then
                                    ShouldProcessCreditNote := true;
                        end;


                        // If contract dates match the posting month/year duration, create negative revenue entry
                        if ShouldProcessCreditNote then begin

                            // Initialize the record properly
                            RevenueRecognitionDetails.Reset();
                            RevenueRecognitionDetails.Init();

                            // Set primary key fields first
                            RevenueRecognitionDetails."Entry No." := NextEntryNo;
                            RevenueRecognitionDetails."RR_No." := Rec."RR_No.";
                            RevenueRecognitionDetails."Contract ID" := RequestCreditNotegrid."Contract ID";
                            RevenueRecognitionDetails."Property Name" := ContractRec."Property Name";
                            RevenueRecognitionDetails."Contract Tenure" := ContractRec."Contract Tenor";
                            RevenueRecognitionDetails."Unit Type" := ContractRec."Usage Type";
                            RevenueRecognitionDetails."Customer Name" := ContractRec."Customer Name";
                            RevenueRecognitionDetails."Contract Start Date" := ContractRec."Contract Start Date";
                            RevenueRecognitionDetails."Contract End Date" := ContractRec."Contract End Date";
                            RevenueRecognitionDetails."Grace Days" := ContractRec."Grace Period";
                            RevenueRecognitionDetails."Grace Start Date" := ContractRec."Grace Start Date";
                            RevenueRecognitionDetails."Grace End Date" := ContractRec."Grace End Date";
                            RevenueRecognitionDetails."Owner Name" := ContractRec."Owner's Name";

                            case
                            ContractRec."Praposal Type Selected" of
                                ContractRec."Praposal Type Selected"::"Single Unit":
                                    RevenueRecognitionDetails."Single Unit Names" := ContractRec."Unit Name";
                                ContractRec."Praposal Type Selected"::"Merge Unit":
                                    RevenueRecognitionDetails."Single Unit Names" := ContractRec."Single Unit Name";
                                else
                                    RevenueRecognitionDetails."Single Unit Names" := '';
                            end;

                            RevenueRecognitionDetails."Termination Date" := 0D;

                            // Add suspension information
                            SuspensionRec.Reset();
                            SuspensionRec.SetRange("Contract ID", ContractRec."Contract ID");
                            if SuspensionRec.FindFirst() then begin
                                RevenueRecognitionDetails."Suspension Start Date" := SuspensionRec.DateEffective;
                                RevenueRecognitionDetails."Suspension End Date" := SuspensionRec.SuspensionEndDate;
                            end;

                            ExistingRevenueRec.Reset();
                            ExistingRevenueRec.SetRange("Contract ID", RevenueRecognitionDetails."Contract ID");
                            if ExistingRevenueRec.FindFirst() then begin
                                Noofdays := ExistingRevenueRec."No Of Days";
                                RevenueRecognitionDetails."Multi Year Start Date" := ExistingRevenueRec."Multi Year Start Date";
                                RevenueRecognitionDetails."Multi Year End Date" := ExistingRevenueRec."Multi Year End Date";
                                RevenueRecognitionDetails."Item Type" := ExistingRevenueRec."Item Type";
                            end;

                            RevenueRecognitionDetails."No Of Days" := NoOfDays;
                            RevenueRecognitionDetails."Posting Month" := MonthNo;
                            RevenueRecognitionDetails."Posting Year" := FinancialYear;
                            RevenueRecognitionDetails."Posting Period" := Format(RevenueRecognitionDetails."Posting Month") +
                  ' ' + Format(RevenueRecognitionDetails."Posting Year") + ' ' + '-' + ' ' +
                  Format(RevenueRecognitionDetails."Posting Month") + ' ' + Format(RevenueRecognitionDetails."Posting Year");
                            RevenueRecognitionDetails."Owner Name" := ContractRec."Owner's Name";
                            RevenueRecognitionDetails."Contract Amount" := -RentReductionAmount;
                            RevenueRecognitionDetails."Annual Amount" := -RentReductionAmount;
                            RevenueRecognitionDetails."Final Annual Amount" := -RentReductionAmount;

                            permonthrent := RevenueRecognitionDetails."Annual Amount" / 12;
                            RevenueRecognitionDetails."Per Month Rent" := Calculatepermonthrentss(permonthrent, Noofdays, MonthNo, FinancialYear);
                            RevenueRecognitionDetails."Total Value" := RevenueRecognitionDetails."Per Month Rent";
                            RevenueRecognitionDetails."Owner Share" := RevenueRecognitionDetails."Per Month Rent";
                            RevenueRecognitionDetails."Description" := 'Credit Note'; // Or whatever indicates this is a credit note entry
                            RevenueRecognitionDetails.Insert();
                        end;
                    until RequestCreditNotegrid.Next() = 0;
            until RequestCreditNote.Next() = 0;
        // until RequestCreditNotegrid.Next() = 0;
        // end;
    end;



    // Get termination date from Final Calculation table
    local procedure GetTerminationDates(ContractID: Integer; var RevenueRecognitionDetails: Record "Revenue Recognition Details")
    var
        FinalCalculation: Record "Final Calculation";
    begin
        FinalCalculation.Reset();
        FinalCalculation.SetRange("Contract ID", ContractID);
        if FinalCalculation.FindFirst() then
            RevenueRecognitionDetails."Termination Date" := FinalCalculation."Termination Date";
    end;

    // Get suspension details from Suspended Reason table
    local procedure GetSuspensionDetailss(ContractID: Integer; var RevenueRecognitionDetails: Record "Revenue Recognition Details")
    var
        SuspendedReasonList: Record SuspendReasonTable;
    begin
        SuspendedReasonList.Reset();
        SuspendedReasonList.SetRange("Contract ID", ContractID);
        if SuspendedReasonList.FindFirst() then begin
            RevenueRecognitionDetails."Suspension Start Date" := SuspendedReasonList.DateEffective;
            RevenueRecognitionDetails."Suspension End Date" := SuspendedReasonList.SuspensionEndDate;
        end;
    end;


    procedure Calculatepermonthrent(permonthrent: Decimal; ActualNoOfDays: Integer; MonthNo: Integer; FinancialYear: Integer): Decimal
    var
        revenuerecognition: Record "Revenue Recognition";
        MonthlyRate: Decimal;
    begin

        if ActualNoOfDays < revenuerecognition.GetDaysInMonthss(DMY2Date(1, MonthNo, FinancialYear)) then
            MonthlyRate := Round(permonthrent / revenuerecognition.GetDaysInMonthss(DMY2Date(1, MonthNo, FinancialYear)) * ActualNoOfDays)
        else
            MonthlyRate := permonthrent;
        exit(MonthlyRate);
    end;

    procedure Calculatepermonthrents(permonthrent: Decimal; NoOfDays: Integer; MonthNo: Integer; FinancialYear: Integer): Decimal
    var
        revenuerecognition: Record "Revenue Recognition";
        MonthlyRate: Decimal;
    begin

        if NoOfDays < revenuerecognition.GetDaysInMonthss(DMY2Date(1, MonthNo, FinancialYear)) then
            MonthlyRate := Round(permonthrent / revenuerecognition.GetDaysInMonthss(DMY2Date(1, MonthNo, FinancialYear)) * NoOfDays)
        else
            MonthlyRate := permonthrent;
        exit(MonthlyRate);
    end;


    procedure Calculatepermonthrentss(permonthrent: Decimal; NoOfDays: Integer; MonthNo: Integer; FinancialYear: Integer): Decimal
    var
        revenuerecognition: Record "Revenue Recognition";
        MonthlyRate: Decimal;
    begin

        if NoOfDays < revenuerecognition.GetDaysInMonthss(DMY2Date(1, MonthNo, FinancialYear)) then
            MonthlyRate := Round(permonthrent / revenuerecognition.GetDaysInMonthss(DMY2Date(1, MonthNo, FinancialYear)) * NoOfDays)
        else
            MonthlyRate := permonthrent;
        exit(MonthlyRate);
    end;

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    var
        RRID: Integer;

    procedure SetRIID(pRRID: Integer)
    begin
        RRID := pRRID;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."RR_No." := RRID;
        exit(true);
    end;
}
