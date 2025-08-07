namespace PropertyManagement.PropertyManagement;
report 50109 "Security Deposit"
{
    ApplicationArea = All;
    Caption = 'Security Deposit';
    UsageCategory = ReportsAndAnalysis;
    ExcelLayout = 'Security Deposit.xlsx';
    DefaultLayout = Excel;
    dataset
    {
        dataitem(TenancyContract; "Tenancy Contract")
        {
            DataItemTableView = SORTING("Customer Name", "Contract ID");
            column(CustomDateRange; CustomDateRangeText)
            {
            }
            column(Contract_ID; "Contract ID")
            {
            }
            column(Customer_Name; "Customer Name")
            {
            }
            column(Property_Name; "Property Name")
            {
            }
            column(Unit_Name; "Unit Name")
            {
            }
            column(Contract_Start_Date; "Contract Start Date")
            {
            }
            column(Contract_End_Date; "Contract End Date")
            {
            }
            column(Opening_Balance; OpeningBalance)
            {
            }
            column(Additions; Additions)
            {
            }
            column(CarriedForwardIn; CarriedForwardInAmount)
            {
            }
            column(CarriedForwardOut; CarriedForwardOutAmount)
            {
            }
            column(Adjustment; AdjustmentAmount)
            {
            }
            column(Refund; RefundAmount)
            {
            }
            column(Closing_Balance; ClosingBalance)
            {
            }
            trigger OnAfterGetRecord()
            var
                SecurityDepositTransfer: Record "Security Deposit";
                AdditionalCharges: Record "Additional Charges Sub";
                FinalCalculation: Record "Final Calculation";
                StartDateIsInRange: Boolean;
                EndDateIsInRange: Boolean;
                SecurityDepositAmount: Decimal;
            begin
                CustomDateRangeText :=
                     Format(gCustomStartDate, 0, '<Day,2>/<Month,2>/') + Format(Date2DMY(gCustomStartDate, 3)) + ' - ' +
                     Format(gCustomEndDate, 0, '<Day,2>/<Month,2>/') + Format(Date2DMY(gCustomEndDate, 3));
                StartDateIsInRange := ("Contract Start Date" >= gCustomStartDate) and ("Contract Start Date" <= gCustomEndDate);
                EndDateIsInRange := ("Contract End Date" >= gCustomStartDate) and ("Contract End Date" <= gCustomEndDate);
                if not (StartDateIsInRange or EndDateIsInRange) then
                    CurrReport.SKIP();
                SecurityDepositAmount := "Security Deposit Amount";
                if "Contract Start Date" <= gCustomStartDate then
                    OpeningBalance := SecurityDepositAmount
                else
                    OpeningBalance := 0;
                if "Contract Start Date" > gCustomStartDate then
                    Additions := SecurityDepositAmount
                else
                    Additions := 0;
                "OpeningBalance" := OpeningBalance;
                "Additions" := Additions;
                CarriedForwardInAmount := 0;
                CarriedForwardOutAmount := 0;
                SecurityDepositTransfer.Reset();
                SecurityDepositTransfer.SetRange("Contract ID", "Contract ID");
                if SecurityDepositTransfer.FindSet() then
                    repeat
                        CarriedForwardOutAmount += SecurityDepositTransfer."New_Security Deposit Amount";
                    until SecurityDepositTransfer.Next() = 0;
                SecurityDepositTransfer.Reset();
                SecurityDepositTransfer.SetRange("New_Contract ID", "Contract ID");
                if SecurityDepositTransfer.FindSet() then
                    repeat
                        CarriedForwardInAmount += SecurityDepositTransfer."New_Security Deposit Amount";
                    until SecurityDepositTransfer.Next() = 0;
                TotalAdditionalCharges := 0;
                AdditionalCharges.Reset();
                AdditionalCharges.SetRange("Contract ID", "Contract ID");
                if AdditionalCharges.FindSet() then
                    repeat
                        TotalAdditionalCharges += AdditionalCharges."Amount Including VAT";
                    until AdditionalCharges.Next() = 0;
                NetBalance := 0;
                FinalCalculation.Reset();
                FinalCalculation.SetRange("Contract ID", "Contract ID");
                if FinalCalculation.FindFirst() then
                    NetBalance := FinalCalculation."Net Balance";
                if TotalAdditionalCharges > NetBalance then begin
                    AdjustmentAmount := NetBalance;
                    RefundAmount := 0;
                end else
                    if TotalAdditionalCharges < NetBalance then begin
                        AdjustmentAmount := TotalAdditionalCharges;
                        RefundAmount := NetBalance - TotalAdditionalCharges;
                    end else
                        if TotalAdditionalCharges = NetBalance then begin
                            AdjustmentAmount := NetBalance;
                            RefundAmount := 0;
                        end else begin
                            AdjustmentAmount := 0;
                            RefundAmount := 0;
                        end;
                "ClosingBalance" := ClosingBalance;
                if gCustomEndDate < "Contract End Date" then
                    ClosingBalance := SecurityDepositAmount
                else
                    ClosingBalance := 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(DateFilter)
                {
                    field(CustomStartDate; gCustomStartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Custom Start Date';
                        ToolTip = 'Custom Start Date';
                    }
                    field(CustomEndDate; gCustomEndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Custom End Date';
                        ToolTip = 'Custom End Date';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        gCustomStartDate: Date;
        gCustomEndDate: Date;
        CustomDateRangeText: Text;
        OpeningBalance: Decimal;
        Additions: Decimal;
        AdjustmentAmount: Decimal;
        ClosingBalance: Decimal;
        RefundAmount: Decimal;
        CarriedForwardOutAmount: Decimal;
        CarriedForwardInAmount: Decimal;
        TotalAdditionalCharges: Decimal;
        NetBalance: Decimal;
}
