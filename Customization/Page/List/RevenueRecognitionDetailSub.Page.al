page 50974 "Revenue Recognition Detail Sub"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Revenue Recognition Details";
    Caption = 'Revenue Recognition Details';
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'The unique entry number for the revenue recognition item.';
                    ApplicationArea = All;
                    Caption = 'Entry No.';
                    Visible = false;
                }
                field("Description"; Rec."Description")
                {
                    ToolTip = 'The description of the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ToolTip = 'The type of unit associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Item Type"; Rec."Item Type")
                {
                    ToolTip = 'The type of item associated with the revenue recognition.';
                    ApplicationArea = All;
                }
                field("Property Name"; Rec."Property Name")
                {
                    ToolTip = 'The name of the property associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Single Unit Names"; Rec."Single Unit Names")
                {
                    ToolTip = 'The names of the single units associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Contract Id"; Rec."Contract Id")
                {
                    ToolTip = 'The unique identifier for the contract associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Contract Tenure"; Rec."Contract Tenure")
                {
                    ToolTip = 'The tenure of the contract associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'The name of the customer associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ToolTip = 'The start date of the contract associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ToolTip = 'The end date of the contract associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Grace Days"; Rec."Grace Days")
                {
                    ToolTip = 'The number of grace days associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Grace Start Date"; Rec."Grace Start Date")
                {
                    ToolTip = 'The start date of the grace period for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Grace End Date"; Rec."Grace End Date")
                {
                    ToolTip = 'The end date of the grace period for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ToolTip = 'The termination date of the contract associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Suspension Start Date"; Rec."Suspension Start Date")
                {
                    ToolTip = 'The start date of the suspension period for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Suspension End Date"; Rec."Suspension End Date")
                {
                    ToolTip = 'The end date of the suspension period for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Multi Year Start Date"; Rec."Multi Year Start Date")
                {
                    ToolTip = 'The start date of the multi-year period for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Multi Year End Date"; Rec."Multi Year End Date")
                {
                    ToolTip = 'The end date of the multi-year period for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Contract Amount"; Rec."Contract Amount")
                {
                    ToolTip = 'The total amount of the contract associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Annual Amount"; Rec."Annual Amount")
                {
                    ToolTip = 'The annual amount calculated for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Posting Month"; Rec."Posting Month")
                {
                    ToolTip = 'The month in which the revenue recognition item is posted.';
                    ApplicationArea = All;
                }
                field("Posting Year"; Rec."Posting Year")
                {
                    ToolTip = 'The year in which the revenue recognition item is posted.';
                    ApplicationArea = All;
                }
                field("Posting Period"; Rec."Posting Period")
                {
                    ToolTip = 'The period in which the revenue recognition item is posted.';
                    ApplicationArea = All;
                }
                field("Final Annual Amount"; Rec."Final Annual Amount")
                {
                    ToolTip = 'The final annual amount calculated for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("No Of Days"; Rec."No Of Days")
                {
                    ToolTip = 'The number of days associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Per Day Rent"; Rec."Per Day Rent")
                {
                    ToolTip = 'The rent amount per day for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Per Month Rent"; Rec."Per Month Rent")
                {
                    ToolTip = 'The rent amount per month for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Total Value"; Rec."Total Value")
                {
                    ToolTip = 'The total value calculated for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ToolTip = 'The name of the owner associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Owner Share"; Rec."Owner Share")
                {
                    ToolTip = 'The share of the owner in the revenue recognition item.';
                    ApplicationArea = All;
                }
            }
        }
    }
    procedure SetRIID(pRRID: Integer)
    begin
        RRID := pRRID;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."RR_No." := RRID;
    end;

    var
        RRID: Integer;
}