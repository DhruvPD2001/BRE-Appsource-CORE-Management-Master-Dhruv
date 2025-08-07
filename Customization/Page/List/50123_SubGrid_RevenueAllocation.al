page 50123 "Revenue Allocation SubGrid"
{
    PageType = ListPart;
    ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Revenue Allocation SubGrid";
    Caption = 'Revenue Allocation Master data';

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
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ApplicationArea = All;
                }
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = All;
                }
                field("Single Unit Names"; Rec."Single Unit Names")
                {
                    ApplicationArea = All;
                }
                field("Contract Id"; Rec."Contract Id")
                {
                    ApplicationArea = All;
                }
                field("Contract Tenure"; Rec."Contract Tenure")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ApplicationArea = All;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                }
                field("Grace Days"; Rec."Grace Days")
                {
                    ApplicationArea = All;
                }
                field("Grace Start Date"; Rec."Grace Start Date")
                {
                    ApplicationArea = All;
                }
                field("Grace End Date"; Rec."Grace End Date")
                {
                    ApplicationArea = All;
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = All;
                }
                field("Suspension Start Date"; Rec."Suspension Start Date")
                {
                    ApplicationArea = All;
                }
                field("Suspension End Date"; Rec."Suspension End Date")
                {
                    ApplicationArea = All;
                }
                field("Multi Year Start Date"; Rec."Multi Year Start Date")
                {
                    ApplicationArea = All;
                }
                field("Multi Year End Date"; Rec."Multi Year End Date")
                {
                    ApplicationArea = All;
                }
                field("Contract Amount"; Rec."Contract Amount")
                {
                    ApplicationArea = All;
                }
                field("Annual Amount"; Rec."Annual Amount")
                {
                    ApplicationArea = All;
                }
                field("Posting Month"; Rec."Posting Month")
                {
                    ApplicationArea = All;
                }
                field("Posting Year"; Rec."Posting Year")
                {
                    ApplicationArea = All;
                }
                field("Posting Period"; Rec."Posting Period")
                {
                    ApplicationArea = All;
                }
                field("Final Annual Amount"; Rec."Final Annual Amount")
                {
                    ApplicationArea = All;
                }
                field("No Of Days"; Rec."No Of Days")
                {
                    ApplicationArea = All;
                }
                field("Per Day Rent"; Rec."Per Day Rent")
                {
                    ApplicationArea = All;
                }
                field("Per Month Rent"; Rec."Per Month Rent")
                {
                    ApplicationArea = All;
                }
                field("Total Value"; Rec."Total Value")
                {
                    ApplicationArea = All;
                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ApplicationArea = All;
                }
                field("Owner Share"; Rec."Owner Share")
                {
                    ApplicationArea = All;
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
                    createExcelReport.GenerateExcelReportForAnyTable(50110, 50123, Rec."Header No.");
                end;
            }
        }
    }
}