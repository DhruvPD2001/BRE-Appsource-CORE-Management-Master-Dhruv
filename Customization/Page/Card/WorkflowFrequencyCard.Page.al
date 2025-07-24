page 50918 "Workflow Frequency Card"
{
    PageType = ListPart;
    SourceTable = "Workflow Frequency";
    ApplicationArea = All;
    Caption = 'Workflow Frequency Card';
    // UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Company ID"; Rec."Company ID")
                {
                    ApplicationArea = All;
                    Editable = false; // The ID is not editable since it's auto-incrementing
                    ToolTip = 'Specifies the unique identifier for the company.';
                    Caption = 'Company ID';
                }

                field("Workflow"; Rec."Workflow")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the workflow associated with the frequency.';
                }
                field("frequncy Status"; Rec."frequncy Status")
                {
                    ApplicationArea = All;
                    Caption = 'frequncy Status';
                    ToolTip = 'Specifies the status of the frequency.';
                }
                field("No. of Days"; Rec."No. of Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of days for the frequency.';
                    Editable = IsApproved;
                }
            }
        }
    }

    var
        IsApproved: Boolean;

    trigger OnModifyRecord(): Boolean
    begin
        HandleFrequencyStatus();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        HandleFrequencyStatus();
    end;

    trigger OnAfterGetRecord()
    begin
        HandleFrequencyStatus();
    end;

    procedure HandleFrequencyStatus()
    begin
        if Rec."frequncy Status" = Rec."frequncy Status"::Company then begin
            if Rec."No. of Days" <= 0 then
                Message('Please enter a valid number of days when Frequency Status is set to Company.');
            IsApproved := true;
        end else begin
            Rec."No. of Days" := 0;
            IsApproved := (Rec."frequncy Status" <> Rec."frequncy Status"::Property);
            if Rec."frequncy Status" = Rec."frequncy Status"::Property then
                Message('Since Frequency Status is set to Property, the number of days is automatically set to 0.')
            else
                Message('Please select "Company" as the Frequency Status before entering the number of days.');
        end;
    end;
}