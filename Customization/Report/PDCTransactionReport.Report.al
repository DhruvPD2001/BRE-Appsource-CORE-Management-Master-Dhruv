namespace BREPropertyManagementMargi.BREPropertyManagementMargi;
report 50111 "PDC Transaction Report"
{
    ApplicationArea = All;
    Caption = 'PDC Transaction Report';
    UsageCategory = ReportsAndAnalysis;
    ExcelLayout = 'PDC Transaction Report.xlsx';
    DefaultLayout = Excel;
    dataset
    {
        dataitem(PDCTransaction; "Payment Mode2")
        {
            DataItemTableView = where("Payment Mode" = const('Cheque'));
            column(Report_Period; CustomDateRangeText)
            {
            }
            column(payment_Series; "payment Series")
            {
            }
            column(Contract_ID; "Contract ID")
            {
            }
            column(Tenant_Id; "Tenant Id")
            {
            }
            column(Tenant_Name; "Tenant Name")
            {
            }
            column(Cheque_Number; "Cheque Number")
            {
            }
            column(Cheque_Date; "Due Date")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Old_Cheque_; "Old Cheque #")
            {
            }
            column(Cheque_Status; "Cheque Status")
            {
            }
            column(Approval_Status; "Approval Status")
            {
            }
            column(Payment_Status; "Payment Status")
            {
            }
            trigger OnAfterGetRecord()
            var
                StartDateIsInRange: Boolean;
                EndDateIsInRange: Boolean;
            begin
                CustomDateRangeText :=
                    Format(gCustomStartDate, 0, '<Day,2>/<Month,2>/<Year4>') + ' - ' +
                    Format(gCustomEndDate, 0, '<Day,2>/<Month,2>/<Year4>');
                StartDateIsInRange := ("Due Date" >= gCustomStartDate) and ("Due Date" <= gCustomEndDate);
                EndDateIsInRange := ("Due Date" >= gCustomStartDate) and ("Due Date" <= gCustomEndDate);
                if not (StartDateIsInRange or EndDateIsInRange) then
                    CurrReport.SKIP();
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
}
