page 50433 "Report Request"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(SelectReport)
            {
                Caption = 'Select Report';
                field("Report Type"; reportType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of report to be generated.';
                    Caption = 'Report Type';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Navigate)
            {
                ApplicationArea = All;
                Caption = 'Navigate to Report';
                ToolTip = 'Navigate to the selected report based on the report type.';
                Image = Navigate;
                trigger OnAction()
                begin
                    case reportType of
                        Enum::"Report Type"::"Security Deposit Report":
                            Report.Run(Report::"Security Deposit");
                        Enum::"Report Type"::"PDC Transaction Report":
                            Report.Run(Report::"PDC Transaction Report");
                        Enum::"Report Type"::"Contract Master Data Report":
                            Report.Run(Report::ContractMasterData);
                        Enum::"Report Type"::"Revenue Allocation Report":
                            RedirectToRevenueAlloationReport();
                        Enum::"Report Type"::"Unearned Revenue Report":
                            RedirectToUnearnedRevenueReport();
                        else
                            Error('Please select a valid report type.');
                    end;
                end;
            }
        }

        area(Promoted)
        {
            actionref(Navigate_Report; Navigate) { }
        }
    }

    var
        reportType: Enum "Report Type";

    procedure RedirectToRevenueAlloationReport()
    var
        revenueAllocationList: Page "Revenue Allocation List";
    begin
        revenueAllocationList.Run();
    end;

    procedure RedirectToUnearnedRevenueReport()
    var
        unearnedRevenueReportList: Page "Unearned Revenue Report List";
    begin
        unearnedRevenueReportList.Run();
    end;
}