page 51256 "Emirate Card"
{
    PageType = Card;
    SourceTable = Emirate;
    ApplicationArea = All;
    Caption = 'Emirate Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Emirate Details';
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the emirate.';
                }
                field("Sl No."; Rec."Sl No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the serial number for the emirate.';
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country code associated with the emirate.';
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Emirate Name"; Rec."Emirate Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the emirate.';
                    ShowMandatory = true;
                    NotBlank = true;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("Country Code");
        Rec.TestField("Emirate Name");
    end;
}
