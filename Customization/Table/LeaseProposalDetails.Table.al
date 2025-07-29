table 50308 "Lease Proposal Details"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Proposal ID";

    fields
    {
        field(50100; "Proposal ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50101; "Unit Address"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item"."Unit Address";
        }

        field(50102; "Property ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property ID';
            TableRelation = "Property Registration"."Property ID";

            trigger OnValidate()
            var
                PropertyRec: Record "Property Registration";
            begin
                PropertyRec.SetRange("Property ID", Rec."Property ID");
                if PropertyRec.FindFirst() then begin
                    "Property Name" := PropertyRec."Property Name";
                    "Makani Number" := PropertyRec."Makani Number";
                    Emirate := PropertyRec.Emirate;
                    Community := PropertyRec.Community;
                    "DEWA Number" := PropertyRec."DEWA Number";
                    "Property Size" := PropertyRec."Property Size";

                end else
                    "Property Name" := '';
            end;
        }

        field(50103; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';
            TableRelation = "Property Registration"."Property Name";
        }

        field(50104; "Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Single Unit ID';
            TableRelation = Item."No."
    where("Property ID" = field("Property ID"), "Unit Status" = const(Free), "MergeSplitOption" = const(Single));

            trigger OnValidate()
            var
                LeaseProposalRec: Record "Lease Proposal Details";
                ItemRec: Record Item;
            begin
                if "Merge Unit ID" <> '' then
                    Error('You can only select either Single Unit ID or Merge Unit ID, not both.');
                if "Unit ID" <> '' then
                    if not Confirm('Once you select this Single Unit ID, the status of the associated units will change from "Free" to "Selected". Do you wish to proceed?', false) then begin
                        Validate("Unit ID", '');
                        exit;
                    end;
                LeaseProposalRec.Reset();
                LeaseProposalRec.SetRange("Property ID", "Property ID");
                LeaseProposalRec.SetRange("Unit ID", "Unit ID");
                LeaseProposalRec.SetFilter("Proposal ID", '<>%1', "Proposal ID"); // Exclude the current record
                if LeaseProposalRec.FindSet() then
                    repeat
                        if LeaseProposalRec."Proposal Status" = LeaseProposalRec."Proposal Status"::Approved then
                            Error('This property and unit combination is already used in another proposal with an approved status.');
                    until LeaseProposalRec.Next() = 0;
                if ItemRec.Get("Unit ID") then begin
                    "Base Unit of Measure" := ItemRec."Base Unit of Measure";
                    "Unit Number" := ItemRec."Unit Number";
                    "Usage Type" := ItemRec."Usage Type";
                    "Unit Type" := ItemRec."Unit Type";
                    "Unit Size" := ItemRec."Unit Size";
                    "Unit Address" := ItemRec."Unit Address";
                    "Unit Name" := ItemRec."Unit Name";
                    "UnitID" := ItemRec."UnitID";
                    "Market Rate per Sq. Ft." := ItemRec."Market Rate per Sq. Ft.";
                    case ItemRec."Usage Type" of
                        'Commercial':
                            Validate("Rent Amount VAT %", "Rent Amount VAT %"::"5%");
                        else
                            Validate("Rent Amount VAT %", "Rent Amount VAT %"::"0%");
                    end;
                    ItemRec."Unit Status" := ItemRec."Unit Status"::Selected;
                    ItemRec.Modify();
                end;
            end;
        }

        field(50105; "Unit Number"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."Unit Number";
        }
        field(50106; "Usage Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Usage Type';
            TableRelation = "Item"."Usage Type";
            NotBlank = true;
        }
        field(50107; "Unit Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Type';
            TableRelation = "Item"."Unit Type";
        }
        field(50108; "Unit Size"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Size';
            TableRelation = "Item"."Unit Size";
        }
        field(50109; "Facilities/Amenities"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(50110; "Tenant Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
        }

        field(50111; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer"."No." WHERE("Approve" = const(true));
            ValidateTableRelation = true;
            trigger OnValidate()
            var
                TenantRec: Record "Customer";
            begin
                TenantRec.SetRange("No.", Rec."Tenant ID");
                if TenantRec.FindFirst() then begin
                    "Tenant Full Name" := TenantRec."Name";
                    "Tenant Contact Phone" := TenantRec."Phone No."; // Convert Integer to Text
                    "Tenant Contact Email" := TenantRec."E-Mail";
                    "Emirates ID" := "TenantRec"."Emirates ID";
                    "License No." := "TenantRec"."License No.";
                    "Licensing Authority" := TenantRec."Licensing Authority";
                end else begin // Clear the fields if no record is found
                    "Tenant Full Name" := '';
                    "Tenant Contact Phone" := '';
                    "Tenant Contact Email" := '';
                    "Emirates ID" := '';
                    "License No." := '';
                    "Licensing Authority" := '';
                end;
            end;
        }
        field(50112; "Tenant Contact Phone"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."Phone No.";
        }
        field(50113; "Tenant Contact Email"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."E-Mail";

        }
        field(50114; "Trade License"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50115; "Legal Representative"; Text[100])
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     emailrec: Codeunit "Send Proposal Email";
            // begin
            //     emailrec.SendEmail(Rec);
            // end;
        }

        // Lease Terms Group
        field(50116; "Lease Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CalculateLeaseDuration();

            end;
        }

        field(50117; "Lease End Date"; Date)
        {
            DataClassification = ToBeClassified;
            // Trasfer from Table Start  
            // trigger OnValidate()
            // var
            //     docAttach: Page "Revenue Item Subpage Card";
            // begin
            //     CalculateLeaseDuration();
            //     docAttach.SetStartEndDate(Rec."Lease Start Date", Rec."Lease End Date", Rec."Unit Name", Rec."Property Name", Rec."Unit Size", Rec."Tenant Full Name");
            // end;
            // Trasfer from Table End
        }


        field(50118; "Lease Duration"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lease Duration';
        }
        field(50119; "Rent Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = ' Annual Rent Amount';

        }
        field(50120; "Payment Frequency"; Option)
        {
            OptionMembers = " ",Monthly,Quarterly,"Half-Yearly",Yearly;
            DataClassification = ToBeClassified;
        }

        field(50121; "Payment Method"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Type"."Payment Method";
        }
        // field(50122; "Grace Period"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Grace Period (Days)';
        // }

        // Deposit and Fees Group
        field(50123; "Security Deposit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50124; "Other Fees"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Fees ';
        }
        field(50125; "Refund Conditions"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }

        // Responsibilities Group
        field(50126; "Maintenance Responsibilities"; Option)
        {
            OptionMembers = Tenant,Landlord;
            DataClassification = ToBeClassified;
        }
        field(50127; "Utility Bills Responsibility"; Option)
        {
            OptionMembers = Tenant,Landlord;
            DataClassification = ToBeClassified;
        }
        field(50128; "Insurance Requirements"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        // Conditions for Renewal Group

        field(50129; "Rent Escalation Clause"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }

        // Special Conditions Group
        field(50130; "Early Termination Conditions"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50131; "Restrictions"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50132; "Legal Jurisdiction"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Legal Jurisdiction (e.g., Dubai Courts)';
        }
        field(50133; "Proposal Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Proposal Status';
            OptionMembers = "    ",ProposalSharedtoTenant,Approved,Declined;
            OptionCaption = '   ,Proposal Shared to Tenant,  Approved,  Declined';
            trigger OnValidate()
            var
                ItemRec: Record Item;
                MergeUnitRec: Record "Merged Units";
                MergeUnitLeaseGrid: Record "Sub Lease Merged Units";
                emailrec: Codeunit "Send Proposal Email";
            begin
                if "Unit ID" <> '' then begin
                    if ItemRec.Get("Unit ID") then
                        case "Proposal Status" of
                            "Proposal Status"::ProposalSharedtoTenant:
                                begin
                                    Message('Sending Email for Approval');
                                    emailrec.SendEmail(Rec); // Call your email codeunit
                                end;
                            "Proposal Status"::Approved:
                                begin
                                    ItemRec."Unit Status" := ItemRec."Unit Status"::Selected;
                                    ItemRec.Modify();
                                end;
                            "Proposal Status"::Declined:
                                begin
                                    ItemRec."Unit Status" := ItemRec."Unit Status"::Free;
                                    ItemRec.Modify();
                                end;
                        end;
                end else
                    Message('Unit ID not found in Item Record');


                // Handle logic for Merge Unit ID
                if "Merge Unit ID" <> '' then
                    if MergeUnitRec.Get("Merge Unit ID") then
                        case "Proposal Status" of
                            "Proposal Status"::ProposalSharedtoTenant:
                                begin
                                    Message('Sending Email for Merge Unit Approval');
                                    emailrec.SendEmail(Rec); // Call your email codeunit
                                end;
                            "Proposal Status"::Approved:
                                begin
                                    MergeUnitRec."Status" := MergeUnitRec."Status"::Selected;
                                    MergeUnitRec.Modify();

                                    ItemRec.Reset();
                                    ItemRec.SetRange("Merged Unit ID", MergeUnitRec."Merged Unit ID");
                                    if ItemRec.FindSet() then
                                        repeat
                                            ItemRec."Unit Status" := ItemRec."Unit Status"::Selected;
                                            // Set Unit Status to Selected
                                            ItemRec.Modify();
                                        until ItemRec.Next() = 0;
                                end;
                            "Proposal Status"::Declined:
                                begin
                                    // Set Merge Unit Status to Free
                                    MergeUnitRec."Status" := MergeUnitRec."Status"::Free;
                                    MergeUnitRec.Modify();

                                    // Delete associated records from Sub Lease Merged Units table
                                    MergeUnitLeaseGrid."Merge Unit ID" := FORMAT(MergeUnitRec."Merged Unit ID");

                                    if MergeUnitLeaseGrid.FindSet() then
                                        repeat
                                            MergeUnitLeaseGrid.Delete();
                                        until MergeUnitLeaseGrid.Next() = 0;

                                    // Update all associated Unit IDs in the Item table
                                    ItemRec.Reset();
                                    ItemRec.SetRange("Merged Unit ID", MergeUnitRec."Merged Unit ID");
                                    if ItemRec.FindSet() then
                                        repeat
                                            ItemRec."Unit Status" := ItemRec."Unit Status"::Free;
                                            // Set Unit Status to Free
                                            ItemRec.Modify();
                                        until ItemRec.Next() = 0;
                                end;
                        end
                    else
                        Message('Merge Unit ID not found in Merge Unit Record');
            end;
        }
        field(50134; "Emirates ID"; Code[25])
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirates ID';
        }

        field(50135; "Unit Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Name';

        }

        field(50136; "UnitID"; code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'UnitID';

        }

        field(50137; "Base Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Base Unit of Measure';
        }

        field(50138; "Merge Unit ID"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Merge Unit ID';
            TableRelation = "Merged Units"."Merged Unit ID"
    where("Property ID" = field("Property ID"), "Status" = const(Free)); // Filter only "Free" status records

            trigger OnValidate()
            var
                MergedUnitRec: Record "Merged Units";
                MergeUnitGrid: Record "Sub Merged Units";
                MergeUnitLeaseGrid: Record "Sub Lease Merged Units";
                ItemRec: Record Item;
                SelectedUnits: Text[1024];
                mergeUnitId: Integer;
            begin
                if "Unit ID" <> '' then
                    Error('You can only select either Merge Unit ID or Unit ID, not both.');
                if "Merge Unit ID" <> '' then begin
                    if not Confirm('Once you select this Merge Unit ID, the status of the associated units will change from "Free" to "Selected". Do you wish to proceed?', false) then begin
                        Validate("Merge Unit ID", '');
                        exit;
                    end;
                    if MergedUnitRec.Get("Merge Unit ID") then begin
                        "Property Name" := MergedUnitRec."Property Name";
                        "Unit Name" := MergedUnitRec."Merged Unit Name";
                        "Base Unit of Measure" := MergedUnitRec."Base Unit of Measure";
                        "Usage Type" := MergedUnitRec."Property Type";
                        "Unit Size" := MergedUnitRec."Unit Size";
                        "Market Rate per Sq. Ft." := MergedUnitRec."Market Rate per Square";
                        "Single Unit Name" := MergedUnitRec."Single Unit Name";
                        "Unit Number" := MergedUnitRec."Unit Number";
                        if MergedUnitRec."Status" = MergedUnitRec."Status"::Free then begin
                            MergedUnitRec."Status" := MergedUnitRec."Status"::Selected; // Set to Selected status
                            MergedUnitRec.Modify();
                        end;
                        SelectedUnits := MergedUnitRec."Unit ID";
                        ItemRec.SetFilter("No.", SelectedUnits);
                        if ItemRec.FindSet() then
                            repeat
                                ItemRec."Unit Status" := ItemRec."Unit Status"::Selected;

                                ItemRec.Modify();
                            until ItemRec.Next() = 0;
                    end else begin
                        // Clear fields if no record is found
                        "Property Name" := '';
                        "Unit Name" := '';
                        "Base Unit of Measure" := '';
                        "Unit Size" := 0;
                        "Rent Amount" := 0;
                    end;
                end else begin
                    "Property Name" := '';
                    "Unit Name" := '';
                    "Base Unit of Measure" := '';
                    "Unit Size" := 0;
                    "Rent Amount" := 0;
                end;
                Evaluate(mergeUnitId, Rec."Merge Unit ID");
                MergeUnitLeaseGrid.SetRange("Merge Unit ID", FORMAT(mergeUnitId));
                if MergeUnitLeaseGrid.FindSet() then
                    repeat
                        MergeUnitLeaseGrid.Delete();
                    until MergeUnitLeaseGrid.Next() = 0;
                MergeUnitGrid.SetRange("Merged Unit ID", mergeUnitId);
                if MergeUnitGrid.FindSet() then
                    repeat
                        MergeUnitLeaseGrid.Init();
                        MergeUnitLeaseGrid."Merge Unit ID" := FORMAT(MergeUnitGrid."Merged Unit ID");
                        MergeUnitLeaseGrid."Proposal ID" := Rec."Proposal ID";
                        MergeUnitLeaseGrid."Single Unit Name" := MergeUnitGrid."Single Unit Name";
                        MergeUnitLeaseGrid."Unit ID" := MergeUnitGrid."Unit ID";
                        MergeUnitLeaseGrid."Base Unit of Measure" := MergeUnitGrid."Base Unit of Measure";
                        MergeUnitLeaseGrid."Unit Size" := MergeUnitGrid."Unit Size";
                        MergeUnitLeaseGrid."Unit Name" := MergeUnitGrid."Unit Name";
                        MergeUnitLeaseGrid."Market Rate per Square" := MergeUnitGrid."Market Rate per Square";
                        MergeUnitLeaseGrid.Amount := MergeUnitGrid.Amount;
                        MergeUnitLeaseGrid.Insert();
                    until MergeUnitGrid.Next() = 0;
            end;
        }
        field(50139; "Annual Rent Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount ';
            Editable = false;
        }

        field(50140; "Praposal Type Selected"; Option)
        {
            OptionMembers = " ","Single Unit","Merge Unit";
            DataClassification = ToBeClassified;

        }

        field(50141; "Chiller Deposit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Chiller Deposit Amount';
        }


        field(50142; "Electricity Deposit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Electricity Deposit Amount';
        }

        field(50143; "Renewal Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal Amount';
        }

        field(50144; "Rera Fees"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rera Fees';
        }

        field(50145; "Ejari Processing Fees"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ejari Processing Fees';
        }

        field(50146; "Renewal Amount VAT %"; Option)
        {
            OptionMembers = "0%","5%";
            Caption = 'Renewal Amount VAT %';
            Editable = false;
        }

        field(50147; "Renewal Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal Amount Including VAT';

            trigger OnValidate()
            begin
                "Renewal Amount Including VAT" := "Renewal Amount" + "Renewal VAT Amount";
            end;
        }

        field(50148; "Rent Amount VAT %"; Option)
        {
            OptionMembers = "0%","5%";
            Caption = 'Contract Amount VAT %';
            Editable = false;
        }

        field(50149; "Rent Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount Including VAT';
            Editable = false;
        }

        field(50150; "Ejari Fees VAT %"; Option)
        {
            OptionMembers = "0%","5%";
            Caption = 'Ejari Fees VAT %';
            Editable = false;
        }

        field(50151; "Ejari Fees Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ejari Fees Including VAT';
            trigger OnValidate()
            begin
                "Ejari Fees Including VAT" := "Ejari Processing Fees" + "Ejari VAT Amount";
            end;
        }
        field(50152; "Ejari VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ejari VAT Amount';
            trigger OnValidate()
            begin
                "Ejari VAT Amount" := "Ejari Processing Fees" * ("Ejari Fees VAT %" / 100);
            end;
        }

        field(50153; "Rent VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract VAT Amount';
            Editable = false;
        }

        field(50154; "Renewal VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal VAT Amount';

            trigger OnValidate()
            begin
                "Renewal VAT Amount" := "Renewal Amount" * ("Renewal Amount VAT %" / 100);
            end;
        }
        field(50155; "License No."; Code[20])
        {
            Caption = 'License No.';
            DataClassification = ToBeClassified;
        }

        field(50156; "Licensing Authority"; Text[100])
        {
            Caption = 'Licensing Authority';
            DataClassification = ToBeClassified;
        }

        field(50157; "Makani Number"; Text[50])
        {
            Caption = 'Makani Number';
            DataClassification = ToBeClassified;

        }
        field(50158; "Emirate"; Enum Emirates)
        {
            Caption = 'Emirate';
            DataClassification = ToBeClassified;

        }
        field(50159; "Community"; Text[100])
        {
            Caption = 'Community';
            DataClassification = ToBeClassified;
        }
        field(50160; "DEWA Number"; Text[50])
        {
            Caption = 'DEWA Number';
            DataClassification = ToBeClassified;
        }
        field(50161; "Property Size"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Size';
        }
        field(50162; "No of Installments"; Integer)
        {
            Caption = 'No of Installments';
            Editable = false;
        }
        field(50163; "Single Rent Calculation"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Single Unit Rent Calculation Type';
            OptionMembers = " ","Single Unit with square feet rate","Single Unit with lumpsum square feet rate";

            trigger OnValidate()

            var
                LeaseProposal: Record "Lease Proposal Details";
                SingleSameSquare: Record "Single Unit Rent SubPage";
                SingleLumSquare: Record "Single Lum_AnnualAmnt SubPage";
                PeriodStartDate: Date;
                PeriodEndDate: Date;
                LeaseEndDate: Date;
                TotalDays: Integer;
                DaysToAdd: Integer;
                LeapDays: Integer;
                CurrentYear: Integer;
                YearCounter: Integer;
                LineNoCounter: Integer;
            begin
                if "Single Rent Calculation" = "Single Rent Calculation"::"Single Unit with square feet rate" then begin
                    SingleSameSquare.SetRange("Proposal ID", Rec."Proposal ID");
                    if SingleSameSquare.FindSet() then
                        repeat
                            SingleSameSquare.Delete();
                        until SingleSameSquare.Next() = 0;
                    PeriodStartDate := Rec."Lease Start Date";
                    LeaseEndDate := Rec."Lease End Date";
                    YearCounter := 1;
                    LineNoCounter := 1;
                    while PeriodStartDate <= LeaseEndDate do begin
                        SingleSameSquare.Init();
                        SingleSameSquare."Proposal ID" := Rec."Proposal ID";
                        SingleSameSquare."Line No." := LineNoCounter;
                        SingleSameSquare.Year := YearCounter;
                        SingleSameSquare."Start Date" := PeriodStartDate;
                        DaysToAdd := 365;
                        LeapDays := 0;
                        for CurrentYear := Date2DMY(PeriodStartDate, 3) to Date2DMY(PeriodStartDate + 364, 3) do
                            if IsLeapYear(CurrentYear) then
                                if (DMY2Date(29, 2, CurrentYear) >= PeriodStartDate) and
                                     (DMY2Date(29, 2, CurrentYear) <= PeriodStartDate + DaysToAdd - 1) then
                                    LeapDays += 1;
                        DaysToAdd := DaysToAdd + LeapDays;
                        PeriodEndDate := PeriodStartDate + DaysToAdd - 1;
                        if PeriodEndDate > LeaseEndDate then
                            PeriodEndDate := LeaseEndDate;
                        SingleSameSquare."End Date" := PeriodEndDate;
                        TotalDays := PeriodEndDate - PeriodStartDate + 1;
                        SingleSameSquare."Number of Days" := TotalDays;
                        SingleSameSquare."Unit ID" := Rec."Unit Name";
                        SingleSameSquare."Unit Sq Ft" := Rec."Unit Size";
                        SingleSameSquare."Rate per Sq.Ft" := 0;
                        SingleSameSquare."Annual Amount" := 0;
                        SingleSameSquare."Final Annual Amount" := SingleSameSquare."Annual Amount";
                        SingleSameSquare."Per Day Rent" := 0;
                        SingleSameSquare.Insert();
                        PeriodStartDate := PeriodEndDate + 1;
                        YearCounter += 1;
                        LineNoCounter += 1;
                    end;
                end
                else
                    if "Single Rent Calculation" = "Single Rent Calculation"::"Single Unit with lumpsum square feet rate" then begin
                        if Rec."Proposal ID" = 0 then
                            Error('Proposal ID is missing or not assigned.');
                        LeaseProposal.Reset();
                        LeaseProposal.SetRange("Proposal ID", Rec."Proposal ID");
                        if not LeaseProposal.FindFirst() then
                            Error('No record found for Proposal ID %1.', Rec."Proposal ID");
                        SingleLumSquare.SetRange("Proposal ID", LeaseProposal."Proposal ID");
                        if SingleLumSquare.FindSet() then
                            repeat
                                SingleLumSquare.Delete();
                            until SingleLumSquare.Next() = 0;
                        PeriodStartDate := LeaseProposal."Lease Start Date";
                        YearCounter := 1;
                        LineNoCounter := 1;
                        while PeriodStartDate <= LeaseProposal."Lease End Date" do begin
                            SingleLumSquare.Init();
                            SingleLumSquare."Proposal ID" := LeaseProposal."Proposal ID";
                            SingleLumSquare."SL_Line No." := LineNoCounter;
                            SingleLumSquare.SL_Year := YearCounter;
                            SingleLumSquare."SL_Start Date" := PeriodStartDate;
                            DaysToAdd := 365;
                            LeapDays := 0;
                            for CurrentYear := Date2DMY(PeriodStartDate, 3) to Date2DMY(PeriodStartDate + 364, 3) do
                                if IsLeapYear(CurrentYear) then
                                    if (DMY2Date(29, 2, CurrentYear) >= PeriodStartDate) and
                                       (DMY2Date(29, 2, CurrentYear) <= PeriodStartDate + DaysToAdd - 1) then
                                        LeapDays += 1;
                            DaysToAdd := DaysToAdd + LeapDays;
                            PeriodEndDate := PeriodStartDate + DaysToAdd - 1;
                            if PeriodEndDate > LeaseProposal."Lease End Date" then
                                PeriodEndDate := LeaseProposal."Lease End Date";
                            SingleLumSquare."SL_End Date" := PeriodEndDate;
                            TotalDays := PeriodEndDate - PeriodStartDate + 1;
                            SingleLumSquare."SL_Number of Days" := TotalDays;
                            SingleLumSquare."SL_Unit ID" := LeaseProposal."Unit Name";
                            SingleLumSquare."SL_Unit Sq Ft" := LeaseProposal."Unit Size";
                            if YearCounter = 1 then begin
                                SingleLumSquare."SL_Annual Amount" := 0; // User will enter manually
                                SingleLumSquare."SL_Final Annual Amount" := 0;
                            end;
                            if TotalDays > 0 then
                                SingleLumSquare."SL_Per Day Rent" := SingleLumSquare."SL_Final Annual Amount" / TotalDays
                            else
                                SingleLumSquare."SL_Per Day Rent" := 0;
                            SingleLumSquare.Insert();
                            PeriodStartDate := PeriodEndDate + 1;
                            YearCounter += 1;
                            LineNoCounter += 1;
                        end;
                    end;
            end;
        }
        field(50169; "Merge Rent Calculation"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Merge Unit Rent Calculation Type';
            OptionMembers = " ","Merged Unit with same square feet","Merged Unit with differential square feet rate","Merged Unit with lumpsum annual amount";
            trigger OnValidate()
            var
                LeaseProposal: Record "Lease Proposal Details"; // Replace with actual table name
                MergeSameSquare: Record "Merge SameSqure SubPage"; // Target table
                MergeDiffSquare: Record "Merge DifferentSqure SubPage"; // Target table
                MergeLumSquare: Record "Merge Lum_AnnualAmount SubPage";
                SubLeaseMergeRec: Record "Sub Lease Merged Units";
                PeriodStartDate: Date;
                PeriodEndDate: Date;
                LeaseEndDate: Date;
                TotalDays: Integer;
                DaysToAdd: Integer;
                LeapDays: Integer;
                CurrentYear: Integer;
                YearCounter: Integer;
                LineNoCounter: Integer;
            begin
                case
                    "Merge Rent Calculation" of
                    "Merge Rent Calculation"::"Merged Unit with same square feet":
                        begin
                            MergeSameSquare.SetRange("Proposal ID", Rec."Proposal ID");
                            if MergeSameSquare.FindSet() then
                                repeat
                                    MergeSameSquare.Delete();
                                until MergeSameSquare.Next() = 0;
                            PeriodStartDate := Rec."Lease Start Date";
                            LeaseEndDate := Rec."Lease End Date";
                            YearCounter := 1;
                            LineNoCounter := 1;
                            while PeriodStartDate <= LeaseEndDate do begin
                                MergeSameSquare.Init();
                                MergeSameSquare."Proposal ID" := Rec."Proposal ID";
                                MergeSameSquare."MS_Line No." := LineNoCounter;
                                MergeSameSquare.MS_Year := YearCounter;
                                MergeSameSquare."MS_Start Date" := PeriodStartDate;
                                DaysToAdd := 365; // Default to 365 days
                                LeapDays := 0;
                                for CurrentYear := Date2DMY(PeriodStartDate, 3) to Date2DMY(PeriodStartDate + 364, 3) do
                                    if IsLeapYear(CurrentYear) then
                                        if (DMY2Date(29, 2, CurrentYear) >= PeriodStartDate) and
                                     (DMY2Date(29, 2, CurrentYear) <= PeriodStartDate + DaysToAdd - 1) then
                                            LeapDays += 1;
                                DaysToAdd := DaysToAdd + LeapDays;
                                PeriodEndDate := PeriodStartDate + DaysToAdd - 1;
                                if PeriodEndDate > LeaseEndDate then
                                    PeriodEndDate := LeaseEndDate;
                                MergeSameSquare."MS_End Date" := PeriodEndDate;
                                TotalDays := PeriodEndDate - PeriodStartDate + 1;
                                MergeSameSquare."MS_Number of Days" := TotalDays;
                                MergeSameSquare."MS_Merged Unit ID" := Rec."Unit Name";
                                MergeSameSquare."MS_Unit Sq Ft" := Rec."Unit Size";
                                MergeSameSquare."MS_Rate per Sq.Ft" := 0; // Initialize as 0; users will manually enter this
                                MergeSameSquare."MS_Annual Amount" := 0; // Calculated after manual input
                                MergeSameSquare."MS_Final Annual Amount" := MergeSameSquare."MS_Annual Amount";
                                MergeSameSquare."MS_Per Day Rent" := 0; // Will be calculated after manual input
                                MergeSameSquare.Insert();
                                PeriodStartDate := PeriodEndDate + 1;
                                YearCounter += 1;
                                LineNoCounter += 1;
                            end;
                        end;
                    "Merge Rent Calculation"::"Merged Unit with lumpsum annual amount":
                        begin
                            if Rec."Proposal ID" = 0 then
                                Error('Proposal ID is missing or not assigned.');
                            LeaseProposal.Reset();
                            LeaseProposal.SetRange("Proposal ID", Rec."Proposal ID");
                            if not LeaseProposal.FindFirst() then
                                Error('No record found for Proposal ID %1.', Rec."Proposal ID");
                            MergeLumSquare.SetRange("Proposal ID", LeaseProposal."Proposal ID");
                            if MergeLumSquare.FindSet() then
                                repeat
                                    MergeLumSquare.Delete();
                                until MergeLumSquare.Next() = 0;
                            PeriodStartDate := LeaseProposal."Lease Start Date";
                            YearCounter := 1;
                            LineNoCounter := 1;
                            while PeriodStartDate <= LeaseProposal."Lease End Date" do begin
                                MergeLumSquare.Init();
                                MergeLumSquare."Proposal ID" := LeaseProposal."Proposal ID";
                                MergeLumSquare."ML_Line No." := LineNoCounter;
                                MergeLumSquare.ML_Year := YearCounter;
                                MergeLumSquare."ML_Start Date" := PeriodStartDate;
                                DaysToAdd := 365; // Default to 365 days
                                LeapDays := 0;

                                for CurrentYear := Date2DMY(PeriodStartDate, 3) to Date2DMY(PeriodStartDate + 364, 3) do
                                    if IsLeapYear(CurrentYear) then
                                        // Ensure the leap day (Feb 29) falls within the range
                                        if (DMY2Date(29, 2, CurrentYear) >= PeriodStartDate) and (DMY2Date(29, 2, CurrentYear) <= PeriodStartDate + DaysToAdd - 1) then
                                            LeapDays += 1;

                                DaysToAdd := DaysToAdd + LeapDays;
                                PeriodEndDate := PeriodStartDate + DaysToAdd - 1;
                                if PeriodEndDate > LeaseProposal."Lease End Date" then
                                    PeriodEndDate := LeaseProposal."Lease End Date";
                                MergeLumSquare."ML_End Date" := PeriodEndDate;
                                TotalDays := PeriodEndDate - PeriodStartDate + 1;
                                MergeLumSquare."ML_Number of Days" := TotalDays;
                                MergeLumSquare."ML_Merged Unit ID" := LeaseProposal."Unit Name";
                                MergeLumSquare."ML_Unit Sq Ft" := LeaseProposal."Unit Size";
                                if YearCounter = 1 then begin
                                    MergeLumSquare."ML_Annual Amount" := 0; // User will enter manually
                                    MergeLumSquare."ML_Final Annual Amount" := 0;
                                end;
                                if TotalDays > 0 then
                                    MergeLumSquare."ML_Per Day Rent" := MergeLumSquare."ML_Final Annual Amount" / TotalDays
                                else
                                    MergeLumSquare."ML_Per Day Rent" := 0;
                                MergeLumSquare.Insert();
                                PeriodStartDate := PeriodEndDate + 1;
                                YearCounter += 1;
                                LineNoCounter += 1;
                            end;
                        end;
                    "Merge Rent Calculation"::"Merged Unit with differential square feet rate":
                        begin
                            MergeDiffSquare.SetRange("Proposal ID", Rec."Proposal ID");
                            if MergeDiffSquare.FindSet() then
                                repeat
                                    MergeDiffSquare.Delete();
                                until MergeDiffSquare.Next() = 0;
                            PeriodStartDate := Rec."Lease Start Date";
                            LeaseEndDate := Rec."Lease End Date";
                            YearCounter := 1;
                            LineNoCounter := 1;
                            SubLeaseMergeRec.SetRange("Proposal ID", Rec."Proposal ID");
                            if SubLeaseMergeRec.FindSet() then
                                repeat
                                    YearCounter := 1;
                                    PeriodStartDate := Rec."Lease Start Date";
                                    LeaseEndDate := Rec."Lease End Date";
                                    while PeriodStartDate <= LeaseEndDate do begin
                                        MergeDiffSquare.Init();
                                        MergeDiffSquare."Proposal ID" := Rec."Proposal ID";
                                        MergeDiffSquare."MD_Line No." := LineNoCounter;
                                        MergeDiffSquare.MD_Year := YearCounter;
                                        MergeDiffSquare."MD_Start Date" := PeriodStartDate;
                                        DaysToAdd := 365;
                                        LeapDays := 0;

                                        for CurrentYear := Date2DMY(PeriodStartDate, 3) to Date2DMY(PeriodStartDate + 364, 3) do
                                            if IsLeapYear(CurrentYear) then
                                                if (DMY2Date(29, 2, CurrentYear) >= PeriodStartDate) and (DMY2Date(29, 2, CurrentYear) <= PeriodStartDate + DaysToAdd - 1) then
                                                    LeapDays += 1;

                                        DaysToAdd := DaysToAdd + LeapDays;
                                        PeriodEndDate := PeriodStartDate + DaysToAdd - 1;

                                        if PeriodEndDate > LeaseEndDate then
                                            PeriodEndDate := LeaseEndDate;

                                        MergeDiffSquare."MD_End Date" := PeriodEndDate;
                                        TotalDays := PeriodEndDate - PeriodStartDate + 1;
                                        MergeDiffSquare."MD_Number of Days" := TotalDays;
                                        MergeDiffSquare."MD_Merged Unit ID" := Rec."Unit Name";
                                        MergeDiffSquare."MD_Unit Sq Ft" := SubLeaseMergeRec."Unit Size"; // From Sub Lease Merged Units
                                        MergeDiffSquare."MD_Unit ID" := CopyStr(SubLeaseMergeRec."Single Unit Name", 1, StrLen(SubLeaseMergeRec."Single Unit Name")); // From Sub Lease Merged Units
                                        MergeDiffSquare."MD_Rate per Sq.Ft" := 0; // Initialize as 0; users will manually enter this
                                        MergeDiffSquare."MD_Annual Amount" := 0; // Calculated after manual input
                                        MergeDiffSquare."MD_Final Annual Amount" := MergeSameSquare."MS_Annual Amount";
                                        MergeDiffSquare."MD_Per Day Rent" := 0;
                                        MergeDiffSquare.Insert();
                                        PeriodStartDate := PeriodEndDate + 1;
                                        YearCounter += 1;
                                        LineNoCounter += 1;
                                    end;
                                until SubLeaseMergeRec.Next() = 0
                            else
                                Error('No matching records found in Sub Lease Merged Units for the given Proposal ID.');
                        end;

                end;
            end;
        }
        field(50164; "Market Rate per Sq. Ft."; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Market Rate per Sq. Ft. ';
        }

        field(50165; "Single Unit Name"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Single Unit Names';
        }

        field(50166; "TotalFinalAmount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50167; "TotalAnnualAmount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50168; "TotalRoundOff"; Decimal)
        {
            DataClassification = ToBeClassified;

        }

        field(50170; "Update Data"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Update Data';
            InitValue = 'Update Data';

        }

        field(50171; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor ID';
        }

        field(50172; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Name';
            Editable = false;
        }
        field(50173; "Percentage"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage';
        }
        field(50174; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(50176; "Calculation Method"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Calculation Method';
            TableRelation = "Calculation Type"."Calculation Type";
        }

        field(50177; "Percentage Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage Type';
            OptionMembers = " ","Fixed","Variable";
        }
        field(50178; "Base Amount Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Base Amount Type';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
        }
        field(50179; "Frequency Of Payment"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Frequency Of Payment';
            OptionMembers = " ","Monthly","Quaterly","Half Yearly","Yearly";
        }

        field(50180; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
            Editable = false;
        }
        field(50181; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
            Editable = false;
        }

        field(50182; "Contract Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Status';
            OptionMembers = " ","Active","Terminate";
        }

        field(50183; "Is any Broker Involved?"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Is any Broker Involved?';
        }
    }

    keys
    {
        key(PK; "Proposal ID", "Merge Unit ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Proposal ID", "Unit Name", "Property Name", "Tenant Full Name", "Tenant ID", "Unit Number")
        {

        }
    }
    procedure CalculateLeaseDuration()
    var
        LeaseStartDate: Date;
        LeaseEndDate: Date;
        Years: Integer;
        Months: Integer;
        Days: Integer;
        DurationText: Text[50];
        TempStartDate: Date;
        DaysDifference: Integer;
    begin
        LeaseStartDate := "Lease Start Date";
        LeaseEndDate := "Lease End Date";

        if (LeaseStartDate <> 0D) and (LeaseEndDate <> 0D) then begin
            if LeaseEndDate >= LeaseStartDate then begin
                DaysDifference := LeaseEndDate - LeaseStartDate + 1;
                if (DaysDifference = 365) or (DaysDifference = 366) then begin
                    Years := 1;
                    Months := 0;
                    Days := 0;
                end else begin
                    TempStartDate := LeaseStartDate;
                    Years := 0;
                    while (CALCDATE('<+1Y>', TempStartDate) <= LeaseEndDate) or
                          (CALCDATE('<+1Y-1D>', TempStartDate) = LeaseEndDate) do begin
                        TempStartDate := CALCDATE('<+1Y>', TempStartDate);
                        Years := Years + 1;
                    end;
                    Months := 0;
                    while CALCDATE('<+1M>', TempStartDate) <= LeaseEndDate do begin
                        TempStartDate := CALCDATE('<+1M>', TempStartDate);
                        Months := Months + 1;
                    end;
                    Days := LeaseEndDate - TempStartDate + 1;
                end;
                DurationText := '';
                if Years > 0 then
                    DurationText := Format(Years) + ' year(s) ';

                if Months > 0 then
                    DurationText := Format(DurationText + Format(Months) + ' month(s) ');
                if Days > 0 then
                    DurationText := Format(DurationText + Format(Days) + ' day(s)');
                "Lease Duration" := DelChr(DurationText, '<>', ' ');
            end else
                "Lease Duration" := '';
        end else
            "Lease Duration" := '';
    end;

    trigger OnDelete()
    var
    begin
        DeleteSingleUnitSameRate();
        DeleteMergeUnitSameRate();
        DeletePerDayRevenueUnitSameRate();
        DeleteLeaseMergeAllUnitDetails();
        DeleteMergeUnitDiffRate();
        DeleteSingleUnitLumpsumRate();
        DeleteMergeUnitLumpsumRate();

    end;

    procedure DeleteSingleUnitSameRate()
    var
        deleteSingleUnitRecords: Record "Single Unit Rent SubPage";

    begin
        deleteSingleUnitRecords.SetRange("Proposal Id", Rec."Proposal ID");

        if deleteSingleUnitRecords.FindSet() then
            deleteSingleUnitRecords.DeleteAll();
    end;

    procedure DeleteMergeUnitSameRate()
    var
        deleteMergeUnitRecords: Record "Merge SameSqure SubPage";

    begin
        deleteMergeUnitRecords.SetRange("Proposal Id", Rec."Proposal ID");

        if deleteMergeUnitRecords.FindSet() then
            deleteMergeUnitRecords.DeleteAll();
    end;

    procedure DeletePerDayRevenueUnitSameRate()
    var
        deletePerDayRevenueUnitRecords: Record "Per Day Rent for Revenue";

    begin
        deletePerDayRevenueUnitRecords.SetRange("Proposal Id", Rec."Proposal ID");

        if deletePerDayRevenueUnitRecords.FindSet() then
            deletePerDayRevenueUnitRecords.DeleteAll();
    end;

    procedure DeleteLeaseMergeAllUnitDetails()
    var
        deleteAllUnitRecords: Record "Sub Lease Merged Units";

    begin
        deleteAllUnitRecords.SetRange("Proposal Id", Rec."Proposal ID");

        if deleteAllUnitRecords.FindSet() then
            deleteAllUnitRecords.DeleteAll();
    end;

    procedure DeleteMergeUnitDiffRate()
    var
        deleteMergeUnitDiffRecords: Record "Merge DifferentSqure SubPage";

    begin
        deleteMergeUnitDiffRecords.SetRange("Proposal Id", Rec."Proposal ID");

        if deleteMergeUnitDiffRecords.FindSet() then
            deleteMergeUnitDiffRecords.DeleteAll();
    end;

    procedure DeleteMergeUnitLumpsumRate()
    var
        deleteMergeUnitLumpsumRecords: Record "Merge Lum_AnnualAmount SubPage";

    begin
        deleteMergeUnitLumpsumRecords.SetRange("Proposal Id", Rec."Proposal ID");

        if deleteMergeUnitLumpsumRecords.FindSet() then
            deleteMergeUnitLumpsumRecords.DeleteAll();
    end;

    procedure DeleteSingleUnitLumpsumRate()
    var
        deleteSingleUnitLumpsumRecords: Record "Single Lum_AnnualAmnt SubPage";

    begin
        deleteSingleUnitLumpsumRecords.SetRange("Proposal Id", Rec."Proposal ID");

        if deleteSingleUnitLumpsumRecords.FindSet() then
            deleteSingleUnitLumpsumRecords.DeleteAll();
    end;

    trigger OnInsert()
    begin
        ValidateRecord();
    end;

    local procedure IsLeapYear(Year: Integer): Boolean
    begin
        if (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0)) then
            exit(true);
        exit(false);
    end;

    procedure ValidateRecord()
    begin
        TestField(Rec."Property ID");
    end;
}

