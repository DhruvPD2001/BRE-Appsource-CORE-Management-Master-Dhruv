page 51255 "Country Card"
{
    PageType = Card;
    SourceTable = Country;
    ApplicationArea = All;
    Caption = 'Country Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Country Details';
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the country.';
                }
                field("Sl No."; Rec."Sl No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the serial number for the country.';
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country code.';
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Country Name"; Rec."Country Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the country.';
                    ShowMandatory = true;
                    NotBlank = true;

                    trigger onvalidate()
                    begin
                        currpage.saverecord();
                    end;
                }
            }


        }


    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("Country Code");
        Rec.TestField("Country Name");
    end;

}



