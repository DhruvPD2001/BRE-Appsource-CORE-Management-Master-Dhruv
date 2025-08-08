table 50920 "Payment Schedule"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Contract ID";

    fields
    {
        field(50101; "Tenant Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Id';
            TableRelation = "Lease Proposal Details"."Tenant ID";
            Editable = false;
        }

        field(50102; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tenancy Contract"."Contract ID" WHERE("Tenant Contract Status" = CONST(Active));
            Caption = 'Contract ID';

            trigger OnValidate()
            var
                leaserec: Record "Tenancy Contract";

            begin
                leaserec.SetRange("Contract ID", Rec."Contract ID");
                if leaserec.FindFirst() then begin
                    "Tenant Id" := leaserec."Tenant Id";
                    "Tenant Name" := leaserec."Customer Name";
                    "Contract Status" := Format(leaserec."Tenant Contract Status");
                    "Contract Start date" := leaserec."Contract Start Date";
                    "Contract End date" := leaserec."Contract End Date";
                    "Property ID" := leaserec."Property ID";
                    "Property Classification" := leaserec."Property Classification";
                end else begin
                    "Tenant Id" := '';
                    "Tenant Name" := '';
                    "Contract Status" := '';
                    "Property ID" := '';
                    "Property Classification" := '';

                end;
                UpdatePaymentSchedule2();
                UpdatePaymentSchedule();
                addrevnuestructurpagelinePaymentschedule2();
                EvaluatePaymentSchedule();
            end;
        }

        field(50103; "Total Amount Including VAT"; Decimal)
        {
            Caption = 'Total Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Schedule2"."Amount Including VAT" where("Contract ID" = field("Contract ID")));
        }


        field(50111; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Schedule2".Amount where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }
        field(50911; "Contract End date"; Date)
        {
            Caption = 'Contract End date';
            DataClassification = ToBeClassified;
        }
        field(50912; "Total VAT Amount"; Decimal)
        {
            Caption = 'Total VAT Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Schedule2"."VAT Amount" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }
        field(50913; "Tenant Name"; Text[100])
        {
            Caption = 'Tenant Name';

        }
        field(50914; "Property Classification"; Text[100])
        {
            Caption = 'Property Classification';
            DataClassification = ToBeClassified;
        }

        field(50915; "Contract Status"; Text[100])
        {
            Caption = 'Contract Status';
            DataClassification = ToBeClassified;
        }
        field(50916; "Contract Start date"; Date)
        {
            Caption = 'Contract Start date';
            DataClassification = ToBeClassified;
        }
        field(50917; "Property ID"; Code[40])
        {
            Caption = 'Property ID';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Contract ID")
        {
            Clustered = true;
        }
    }
    procedure UpdatePaymentSchedule2()
    var
        RevenueSubpage: Record "Tenancy Contract Subpage";
        PaymentSchedule2: Record "Payment Schedule2";
        vatper: Integer;

    begin
        PaymentSchedule2.SetRange("Contract ID", Rec."Contract ID");
        if PaymentSchedule2.FindSet() then
            PaymentSchedule2.DeleteAll();

        RevenueSubpage.SetRange("ContractID", Rec."Contract ID");
        RevenueSubpage.SetRange("Payment Type", 1);
        if RevenueSubpage.FindSet() then
            repeat
                PaymentSchedule2.Init();
                PaymentSchedule2."Contract ID" := RevenueSubpage."ContractID";
                PaymentSchedule2."Contract start date" := Rec."Contract Start date";
                PaymentSchedule2."Contract Status" := Rec."Contract Status";
                PaymentSchedule2."Property ID" := Rec."Property ID";
                PaymentSchedule2."Tenant Name" := Rec."Tenant Name";
                PaymentSchedule2."Tenant ID" := RevenueSubpage."TenantId";
                PaymentSchedule2."Property Classification" := Rec."Property Classification";
                PaymentSchedule2."Secondary Item Type" := RevenueSubpage."Secondary Item Type";
                PaymentSchedule2.Amount := RevenueSubpage.Amount;
                PaymentSchedule2."VAT Amount" := RevenueSubpage."VAT Amount";
                PaymentSchedule2."Amount Including VAT" := RevenueSubpage."Amount Including VAT";
                PaymentSchedule2."Installment Start Date" := RevenueSubpage."Start Date";
                PaymentSchedule2."Installment End Date" := RevenueSubpage."End Date";
                PaymentSchedule2."Due Date" := RevenueSubpage."Start Date";
                PaymentSchedule2."Installment No." := 1;
                if RevenueSubpage."VAT %" = RevenueSubpage."VAT %"::"5%" then
                    vatper := 5
                else
                    vatper := 0;
                PaymentSchedule2."VAT%" := vatper;
                PaymentSchedule2.Insert();
                Clear(PaymentSchedule2);
            until RevenueSubpage.Next() = 0;
    end;

    procedure UpdatePaymentSchedule()
    var
        RentCalculationSubpage: Record "Rent Calculation Subpage2";
        PaymentSchedule: Record "Payment Schedule2";
    begin

        RentCalculationSubpage.SetRange("Contract ID", Rec."Contract ID");

        if RentCalculationSubpage.FindSet() then
            repeat
                PaymentSchedule.Init();
                PaymentSchedule."Contract ID" := RentCalculationSubpage."Contract ID";
                PaymentSchedule."Contract start date" := Rec."Contract Start date";
                PaymentSchedule."Contract Status" := Rec."Contract Status";
                PaymentSchedule."Property ID" := Rec."Property ID";
                PaymentSchedule."Tenant Name" := Rec."Tenant Name";
                PaymentSchedule."Tenant ID" := RentCalculationSubpage."Tenant Id";
                PaymentSchedule."Secondary Item Type" := RentCalculationSubpage."Secondary Item Type";
                PaymentSchedule.Amount := RentCalculationSubpage.Amount;
                PaymentSchedule."VAT Amount" := RentCalculationSubpage."VAT Amount";
                PaymentSchedule."Property Classification" := RentCalculationSubpage."Primary Classification";
                PaymentSchedule."Installment Start Date" := RentCalculationSubpage."Installment Start Date";
                PaymentSchedule."Installment End Date" := RentCalculationSubpage."Installment End Date";
                PaymentSchedule."Installment No." := RentCalculationSubpage."Installment No.";
                PaymentSchedule."Amount Including VAT" := RentCalculationSubpage."Amount Including VAT";
                PaymentSchedule."Due Date" := RentCalculationSubpage."Due Date";
                PaymentSchedule."VAT%" := RentCalculationSubpage."VAT %";
                PaymentSchedule.Insert();
                Clear(PaymentSchedule);
            until RentCalculationSubpage.Next() = 0;

    end;

    procedure addrevnuestructurpagelinePaymentschedule2()
    var
        RevenueStructureSubpage: Record "Revenue Structure Subpage1";
        PaymentSchedule3: Record "Payment Schedule2";
    begin

        RevenueStructureSubpage.SetRange("Contract ID", Rec."Contract ID");


        if RevenueStructureSubpage.FindSet() then
            repeat
                PaymentSchedule3.Init();

                PaymentSchedule3."Contract ID" := RevenueStructureSubpage."Contract ID";

                PaymentSchedule3."Contract start date" := Rec."Contract Start date";
                PaymentSchedule3."Contract Status" := Rec."Contract Status";
                PaymentSchedule3."Property ID" := Rec."Property ID";
                PaymentSchedule3."Tenant Name" := Rec."Tenant Name";
                PaymentSchedule3."Tenant ID" := RevenueStructureSubpage."Tenant Id";
                PaymentSchedule3."Property Classification" := Rec."Property Classification";
                PaymentSchedule3."Secondary Item Type" := RevenueStructureSubpage."Secondary Item Type";
                PaymentSchedule3.Amount := RevenueStructureSubpage.Amount;
                PaymentSchedule3."VAT Amount" := RevenueStructureSubpage."VAT Amount";
                PaymentSchedule3."Installment Start Date" := RevenueStructureSubpage."Installment Start Date";
                PaymentSchedule3."Installment End Date" := RevenueStructureSubpage."Installment End Date";
                PaymentSchedule3."Installment No." := RevenueStructureSubpage."Installment No.";
                PaymentSchedule3."Amount Including VAT" := RevenueStructureSubpage."Amount Including VAT";
                PaymentSchedule3."Due Date" := RevenueStructureSubpage."Due Date";
                PaymentSchedule3."VAT%" := RevenueStructureSubpage."VAT %";
                PaymentSchedule3.Insert();
                Clear(PaymentSchedule3);
            until RevenueStructureSubpage.Next() = 0;

    end;

    procedure EvaluatePaymentSchedule()
    var
        PaymentScheduleRec: Record "Payment Schedule2";
        PaymentScheduleRec2: Record "Payment Schedule2";
        NewPaymentCode: Code[20];
        SequenceNo: Integer;
        MinDueDate: Date;
        DueDateList: List of [Date];
        TempDate: Date;
        i: Integer;
        SortedDueDateList: List of [Date];
    begin
        PaymentScheduleRec.SetRange("Tenant ID", Rec."Tenant ID");
        PaymentScheduleRec.SetRange("Contract ID", Rec."Contract ID");
        if PaymentScheduleRec.FindSet() then
            repeat
                if not DueDateList.Contains(PaymentScheduleRec."Due Date") then
                    DueDateList.Add(PaymentScheduleRec."Due Date");
            until PaymentScheduleRec.Next() = 0;
        while DueDateList.Count() > 0 do begin
            TempDate := DueDateList.Get(1);
            for i := 2 to DueDateList.Count() do
                if DueDateList.Get(i) < TempDate then
                    TempDate := DueDateList.Get(i);
            SortedDueDateList.Add(TempDate);
            DueDateList.Remove(TempDate);
        end;
        SequenceNo := 1;
        for i := 1 to SortedDueDateList.Count() do begin
            MinDueDate := SortedDueDateList.Get(i);
            NewPaymentCode := GeneratePaymentCode(SequenceNo);
            PaymentScheduleRec2.Reset();
            PaymentScheduleRec2.SetRange("Due Date", MinDueDate);
            PaymentScheduleRec2.SetRange("Tenant ID", Rec."Tenant ID");
            PaymentScheduleRec2.SetRange("Contract ID", Rec."Contract ID");

            if PaymentScheduleRec2.FindSet() then
                repeat
                    PaymentScheduleRec2."Payment Series" := NewPaymentCode;
                    PaymentScheduleRec2.Modify();
                until PaymentScheduleRec2.Next() = 0;
            SequenceNo += 1;
        end;

        Message('Payment series assignment completed successfully.');
    end;

    local procedure GeneratePaymentCode(SequenceNumber: Integer): Code[20]
    begin
        exit(Format('PAY' + PadStr(Format(SequenceNumber), 2, '0')));
    end;

    local procedure PadStr(Input: Text[20]; Length: Integer; PaddingChar: Char): Text[20]
    begin
        while StrLen(Input) < Length do
            Input := PaddingChar + Input;
        exit(Input);
    end;


    trigger OnDelete()
    var
    begin
        Deletepaymetnscheudlesubpage();

    end;

    procedure Deletepaymetnscheudlesubpage()
    var
        Paymentschedulesubpage: Record "Payment Schedule2";
    begin


        Paymentschedulesubpage.SetRange("Contract ID", Rec."Contract ID");
        if Paymentschedulesubpage.FindSet() then
            Paymentschedulesubpage.DeleteAll();

    end;
}
