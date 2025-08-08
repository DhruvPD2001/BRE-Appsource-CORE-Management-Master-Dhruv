page 50142 "Sub Unearned Charges"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Sub Unearned Charges";
    Caption = 'Unearned Other Charges Revenue Report';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Header No."; Rec."Header No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Unique identifier for the header of the unearned charges report.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Unique identifier for the line in the unearned charges report.';
                }
                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Identifier for the contract associated with the unearned charges.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Name of the customer associated with the unearned charges.';
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Name of the unit associated with the unearned charges.';
                }
                field(Property; Rec.Property)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Property associated with the unearned charges.';
                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Name of the owner associated with the unearned charges.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Start date of the contract for the unearned charges.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'End date of the contract for the unearned charges.';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Date when the contract was terminated for the unearned charges.';
                }
                field("Suspension Date"; Rec."Suspension Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Date when the contract was suspended for the unearned charges.';
                }
                field("Other Charges Value"; Rec."Other Charges Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Value of the other charges associated with the unearned charges.';
                }
                field("Contract Status"; Rec."Contract Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Status of the contract associated with the unearned charges.';
                }
                field("Opening Balance"; Rec."Opening Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Opening balance for the unearned charges.';
                }
                field("Invoice Raised During the Year"; Rec."Invoice Raised During the Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Total amount of invoices raised during the year for the unearned charges.';
                }
                field("RevenueAllocated DuringtheYear"; Rec."RevenueAllocated DuringtheYear")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Total amount of revenue allocated during the year for the unearned charges.';
                }
                field("Unearned Revenue Balance"; Rec."Unearned Revenue Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Current balance of unearned revenue for the charges.';
                }
                field(CalculatedUnearnedRevBalance; Rec.CalculatedUnearnedRevBalance)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Calculated balance of unearned revenue for the charges.';
                }
                field("Shortfall/Excess"; Rec."Shortfall/Excess")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Difference between the calculated unearned revenue balance and the actual balance.';
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
                    createExcelReport.GenerateExcelReportForAnyTable(50118, 50118, Rec."Header No.");
                end;
            }
        }
    }
}