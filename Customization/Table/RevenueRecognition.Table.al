table 50929 "Revenue Recognition"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50102; "RR Id"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'RR Id';
        }
        field(50100; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tenancy Contract"."Contract ID";
            Caption = 'Contract ID';
            trigger OnValidate()
            var
                tenancyrec: Record "Tenancy Contract";
            begin
                tenancyrec.SetRange("Contract ID", Rec."Contract ID");
                if tenancyrec.FindFirst() then begin
                    "Tenant Id" := tenancyrec."Tenant Id";
                    "Start Date" := tenancyrec."Contract Start Date";
                    "End Date" := tenancyrec."Contract End Date";
                    "Contract Amount" := tenancyrec."Annual Rent Amount";
                end else begin
                    "Tenant Id" := '';
                    "Start Date" := 0D;
                    "End Date" := 0D;
                    "Contract Amount" := 0;
                end;
                CalculateMonthlyRevenue();
            end;
        }
        field(50101; "Tenant Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Id';
            TableRelation = "Lease Proposal Details"."Tenant ID";
            Editable = false;
        }
        field(50103; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }
        field(50104; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }
        field(50105; "Contract Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount';
        }
    }
    keys
    {
        key(PK; "RR ID")
        {
            Clustered = true;
        }
    }
    local procedure CalculateMonthlyRevenue()
    var
        SubpageRec: Record "Revenue Recognition Subpage";
        TempSubpageRecs: array[1000] of Record "Revenue Recognition Subpage" temporary;
        TotalDays: Integer;
        CurrentDate: Date;
        MonthDays: Integer;
        DailyRate: Decimal;
        MonthlyRate: Decimal;
        AllocatedAmount: Decimal;
        FirstDayNextMonth: Date;
        LastDayOfMonth: Date;
        DaysInMonth: Integer;
        Year: Integer;
        Month: Integer;
        IsLeap: Boolean;
        MonthlyRate2: Decimal;
        TotalMonths: Integer;
        ActualDaysInMonth: Integer;
        LastEntryNo: Integer;
        Method2Total: Decimal;
        RecCount: Integer;
        RemainingAmount: Decimal;
    begin
        SubpageRec.DeleteAll();
        if ("Start Date" = 0D) or ("End Date" = 0D) then
            exit;
        TotalMonths := CalculateTotalMonths("Start Date", "End Date");
        TotalDays := ("End Date" - "Start Date") + 1;
        DailyRate := "Contract Amount" / TotalDays;
        CurrentDate := "Start Date";
        Method2Total := 0;
        RecCount := 0;
        MonthlyRate2 := Round("Contract Amount" / TotalMonths);
        while CurrentDate <= "End Date" do begin
            RecCount += 1;
            TempSubpageRecs[RecCount].Init();
            LastEntryNo += 1;
            TempSubpageRecs[RecCount]."Entry No." := LastEntryNo;
            TempSubpageRecs[RecCount]."Contract ID" := "Contract ID";
            TempSubpageRecs[RecCount]."Tenant Id" := "Tenant Id";
            TempSubpageRecs[RecCount]."Month" := FORMAT(CurrentDate, 0, '<Month Text>') + '-' + FORMAT(CurrentDate, 0, '<Year>');
            if DATE2DMY(CurrentDate, 2) = 12 then
                FirstDayNextMonth := DMY2DATE(1, 1, DATE2DMY(CurrentDate, 3) + 1)
            else
                FirstDayNextMonth := DMY2DATE(1, DATE2DMY(CurrentDate, 2) + 1, DATE2DMY(CurrentDate, 3));
            LastDayOfMonth := FirstDayNextMonth - 1;
            if "End Date" < LastDayOfMonth then
                MonthDays := "End Date" - CurrentDate + 1
            else
                MonthDays := LastDayOfMonth - CurrentDate + 1;
            if CurrentDate = "Start Date" then
                if MonthDays > ("End Date" - CurrentDate + 1) then
                    MonthDays := ("End Date" - CurrentDate + 1);
            Year := DATE2DMY(CurrentDate, 3);
            Month := DATE2DMY(CurrentDate, 2);
            IsLeap := IsLeapYear(Year);
            if Month = 2 then begin
                if IsLeap then
                    DaysInMonth := 29
                else
                    DaysInMonth := 28;
            end else
                if (Month = 4) or (Month = 6) or (Month = 9) or (Month = 11) then
                    DaysInMonth := 30
                else
                    DaysInMonth := 31;
            ActualDaysInMonth := GetDaysInMonthss(CurrentDate);
            AllocatedAmount := MonthDays * DailyRate;
            TempSubpageRecs[RecCount]."RR - Method 1 (Day)" := AllocatedAmount;
            if MonthDays < ActualDaysInMonth then
                MonthlyRate := Round(MonthlyRate2 / ActualDaysInMonth * MonthDays)
            else
                MonthlyRate := MonthlyRate2;

            Method2Total += MonthlyRate;
            TempSubpageRecs[RecCount]."RR - Method 2 (Month)" := MonthlyRate;
            TempSubpageRecs[RecCount]."No. of Days" := MonthDays;
            CurrentDate := FirstDayNextMonth;
        end;
        RemainingAmount := "Contract Amount" - (Method2Total - TempSubpageRecs[RecCount]."RR - Method 2 (Month)");
        TempSubpageRecs[RecCount]."RR - Method 2 (Month)" := RemainingAmount;
        for LastEntryNo := 1 to RecCount do begin
            SubpageRec.Init();
            SubpageRec."Entry No." := TempSubpageRecs[LastEntryNo]."Entry No.";
            SubpageRec."Contract ID" := TempSubpageRecs[LastEntryNo]."Contract ID";
            SubpageRec."Tenant Id" := TempSubpageRecs[LastEntryNo]."Tenant Id";
            SubpageRec."Month" := TempSubpageRecs[LastEntryNo]."Month";
            SubpageRec."No. of Days" := TempSubpageRecs[LastEntryNo]."No. of Days";
            SubpageRec."RR - Method 1 (Day)" := TempSubpageRecs[LastEntryNo]."RR - Method 1 (Day)";
            SubpageRec."RR - Method 2 (Month)" := TempSubpageRecs[LastEntryNo]."RR - Method 2 (Month)";
            SubpageRec.Insert();
        end;
    end;

    local procedure IsLeapYear(Year: Integer): Boolean
    begin
        if (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0)) then
            exit(true);
        exit(false);
    end;

    local procedure CalculateTotalMonths(StartDate: Date; EndDate: Date) Result: Integer
    var
        StartYear, StartMonth : Integer;
        EndYear, EndMonth, EndDay : Integer;
        DaysInEndMonth: Integer;
        FirstDayOfNextMonth: Date;
    begin
        StartYear := DATE2DMY(StartDate, 3);
        StartMonth := DATE2DMY(StartDate, 2);
        EndYear := DATE2DMY(EndDate, 3);
        EndMonth := DATE2DMY(EndDate, 2);
        EndDay := DATE2DMY(EndDate, 1);
        Result := ((EndYear - StartYear) * 12) + (EndMonth - StartMonth);
        if EndMonth = 12 then
            FirstDayOfNextMonth := DMY2DATE(1, 1, EndYear + 1)
        else
            FirstDayOfNextMonth := DMY2DATE(1, EndMonth + 1, EndYear);
        DaysInEndMonth := FirstDayOfNextMonth - DMY2DATE(1, EndMonth, EndYear);
        if EndDay = DaysInEndMonth then
            Result := Result + 1;
    end;

    local procedure GetDaysInMonth(CurrentDate: Date): Integer
    var
        FirstDayNextMonth: Date;
        FirstDayCurrentMonth: Date;
    begin
        FirstDayNextMonth := CALCDATE('<+CM>', CurrentDate);
        FirstDayCurrentMonth := CALCDATE('<-CM>', CurrentDate);
        exit(FirstDayNextMonth - FirstDayCurrentMonth);
    end;

    procedure GetDaysInMonthss(CurrentDate: Date): Integer
    var
        Year: Integer;
        Month: Integer;
        IsLeap: Boolean;
    begin
        Year := DATE2DMY(CurrentDate, 3);
        Month := DATE2DMY(CurrentDate, 2);
        IsLeap := IsLeapYear(Year);
        case Month of
            1, 3, 5, 7, 8, 10, 12:
                exit(31);
            4, 6, 9, 11:
                exit(30);
            2:
                if IsLeap then
                    exit(29)
                else
                    exit(28);
        end;
    end;
}
