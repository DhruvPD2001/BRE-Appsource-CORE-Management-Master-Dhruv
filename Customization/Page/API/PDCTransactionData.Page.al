page 50514 "PDC Transaction Data"
{
    PageType = API;
    APIGroup = 'finance';
    APIPublisher = 'realeststeDev';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'PDC Transaction API';
    DelayedInsert = true;
    EntityName = 'pdcTransaction';
    EntitySetName = 'pdcTransactions';
    ODataKeyFields = SystemId;
    SourceTable = "PDC Transaction";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("pdcID"; Rec."PDC ID") { }
                field(systemId; Rec.SystemId) { }
                field("tenantId"; Rec."Tenant Id") { }
                field("contractID"; Rec."Contract ID") { }
                field("bankName"; Rec."Bank Name") { }
                field("chequeNumber"; Rec."Cheque Number") { }
                field("chequeDate"; Rec."Cheque Date") { }
                field(amount; Rec.Amount) { }
                field("chequeStatus"; Rec."Cheque Status") { }
                field("approvalStatus"; Rec."Approval Status") { }
                field(view; Rec.View) { }

            }
        }
    }

}