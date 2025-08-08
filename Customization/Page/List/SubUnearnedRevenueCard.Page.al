page 50141 "Sub Unearned Revenue Card"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Sub Unearned Revenue Report";
    Caption = 'Unearned Rent Revenue Report';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Header No."; Rec."Header No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the unearned revenue report header.';
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the line in the unearned revenue report.';
                    Editable = false;
                }
                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the contract associated with the unearned revenue.';
                    Editable = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the customer associated with the unearned revenue.';
                    Editable = false;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the unit associated with the unearned revenue.';
                    Editable = false;
                }
                field(Property; Rec.Property)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property associated with the unearned revenue.';
                    Editable = false;
                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the owner associated with the unearned revenue.';
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Start date of the contract for the unearned revenue.';
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'End date of the contract for the unearned revenue.';
                    Editable = false;
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Termination date of the contract for the unearned revenue.';
                    Editable = false;
                }
                field("Suspension Date"; Rec."Suspension Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Suspension date of the contract for the unearned revenue.';
                    Editable = false;
                }
                field("Contract Value"; Rec."Contract Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total value of the contract associated with the unearned revenue.';
                    Editable = false;
                }
                field("Contract Status"; Rec."Contract Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Status of the contract associated with the unearned revenue.';
                    Editable = false;
                }
                field("Opening Balance"; Rec."Opening Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Opening balance of the unearned revenue for the contract.';
                    Editable = false;
                }
                field("Invoice Raised During the Year"; Rec."Invoice Raised During the Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total invoice amount raised during the year for the unearned revenue.';
                    Editable = false;
                }
                field("RevenueAllocated DuringtheYear"; Rec."RevenueAllocated DuringtheYear")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total revenue allocated during the year for the unearned revenue.';
                    Editable = false;
                }
                field("Unearned Revenue Balance"; Rec."Unearned Revenue Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Current balance of the unearned revenue for the contract.';
                    Editable = false;
                }
                field(CalculatedUnearnedRevBalance; Rec.CalculatedUnearnedRevBalance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Calculated unearned revenue balance based on the report data.';
                    Editable = false;
                }
                field("Shortfall/Excess"; Rec."Shortfall/Excess")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortfall or excess amount in the unearned revenue report.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GenerateExcel)
            {
                Caption = 'Generate Excel';
                ApplicationArea = All;
                Image = ExportToExcel;
                ToolTip = 'Generate an Excel report for the unearned other charges revenue.';

                trigger OnAction()
                var
                    createExcelReport: Codeunit "Create Excel Report";
                begin
                    createExcelReport.GenerateExcelReportForAnyTable(50117, 50118, Rec."Header No.");
                end;
            }
        }
    }
}