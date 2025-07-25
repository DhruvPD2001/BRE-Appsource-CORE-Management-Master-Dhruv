page 50319 "Approval Contract Status API"
{
    PageType = API;
    SourceTable = "Approval Contract Status";
    APIPublisher = 'realestate';
    APIGroup = 'approvalflow';
    APIVersion = 'v2.0';
    EntityName = 'approvalContractStatus';
    EntitySetName = 'approvalContractStatuses';
    Caption = 'Approval Contract Status API';
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            field("systemId"; Rec.SystemId)
            {
                Caption = 'System Identifier';
            }

            field(iD; Rec."ID")
            {
            }

            field(status; Rec."Status")
            {
            }

            field("contractID"; Rec."Contract ID")
            {
            }

            field("leaseID"; Rec."Lease ID")
            {
            }

            field("tenancyContractStatus"; Rec."Tenancy Contract Status")
            {
            }

            field("renewalContractID"; Rec."Renewal Contract ID")
            {
            }



        }
    }
}
