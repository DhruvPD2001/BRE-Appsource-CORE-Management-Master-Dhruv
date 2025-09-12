page 50936 "Payment Type Card"
{
    PageType = Card;
    SourceTable = "Payment Type";
    ApplicationArea = All;
    Caption = 'Payment Type Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Payment Type Details';
                field("Payment ID"; Rec."Payment ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    toolTip = 'Specifies the unique identifier for the payment type.';
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Method';
                    ToolTip = 'Enter the Payment Method.';
                    ShowMandatory = true;
                    NotBlank = true;
                }
            }
        }
    }


}



