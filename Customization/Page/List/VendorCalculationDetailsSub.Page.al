page 50957 "Vendor Calculation Details Sub"
{
    PageType = ListPart;
    SourceTable = "Vendor Calculation Details";
    ApplicationArea = All;
    Caption = 'Vendor Calculation Details';
    layout
    {
        area(content)
        {
            repeater("Calculation Details")
            {
                field("Vendor ID"; Rec."Vendor ID")
                {
                    ToolTip = 'The unique identifier for the vendor associated with the calculation.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'The name of the vendor associated with the calculation.';
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'The start date of the calculation period for the vendor.';
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'The end date of the calculation period for the vendor.';
                    ApplicationArea = All;
                }
                field("Calculation Method"; Rec."Calculation Method")
                {
                    ToolTip = 'The method used for calculating the vendor payment.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdateFieldEditability();
                    end;
                }
                field("Base Amount"; Rec."Base Amount")
                {
                    ToolTip = 'The base amount used for the vendor calculation.';
                    ApplicationArea = All;
                }
                field("Percentage Type"; Rec."Percentage Type")
                {
                    ToolTip = 'The type of percentage used in the vendor calculation.';
                    ApplicationArea = All;
                    Editable = IsPercentageTypeEditable;
                }
                field("Percentage"; Rec."Percentage")
                {
                    ToolTip = 'The percentage value used in the vendor calculation.';
                    ApplicationArea = All;
                    Editable = IsPercentageEditable;
                }
                field("Amount"; Rec."Amount")
                {
                    ToolTip = 'The calculated amount for the vendor based on the calculation method.';
                    ApplicationArea = All;
                    Editable = IsAmountEditable;
                }
                field("Frequency Of Payment"; Rec."Frequency Of Payment")
                {
                    ToolTip = 'The frequency at which the vendor is paid.';
                    ApplicationArea = All;
                }
            }
        }
    }
    procedure SetVendorID(pVendorID: Code[20])
    begin
        VendorID := pVendorID;
    end;

    procedure SetStartEndDate(pStartDate: Date; pEndDate: Date; pvendorname: Text[100])
    begin
        startDate := pStartDate;
        endDate := pEndDate;
        vendorName := pvendorname;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Vendor ID" := VendorID;
        Rec."Start Date" := startDate;
        Rec."End Date" := endDate;
        Rec."Vendor Name" := vendorName;
    end;

    var
        VendorID: Code[20];
        startDate: Date;
        endDate: Date;
        vendorName: Text[100];
        IsAmountEditable: Boolean;
        IsPercentageEditable: Boolean;
        IsPercentageTypeEditable: Boolean;

    procedure UpdateFieldEditability()
    begin
        case UpperCase(Rec."Calculation Method") of
            '':
                begin
                    IsAmountEditable := false;
                    IsPercentageEditable := false;
                    IsPercentageTypeEditable := false;
                end;
            'FIXED AMOUNT':
                begin
                    IsAmountEditable := true;
                    IsPercentageEditable := false;
                    IsPercentageTypeEditable := false;
                end;
            'PERCENTAGE BASED':
                begin
                    IsAmountEditable := false;
                    IsPercentageEditable := true;
                    IsPercentageTypeEditable := true;
                end;
            else begin
                IsAmountEditable := false;
                IsPercentageEditable := true;
                IsPercentageTypeEditable := true;
            end;
        end;
    end;
}
