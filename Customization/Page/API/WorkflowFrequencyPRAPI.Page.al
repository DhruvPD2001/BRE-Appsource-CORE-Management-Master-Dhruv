page 50360 "Workflow Frequency PR API"
{
    PageType = API;
    SourceTable = "Workflow Frequency PR";
    APIPublisher = 'realestate';
    APIGroup = 'workflowManagement';
    APIVersion = 'v2.0';
    EntityName = 'workflowFrequencyPR';
    EntitySetName = 'workflowFrequencyPRs';
    Caption = 'Workflow Frequency PR API';
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            field("systemId"; Rec.SystemId) // System ID field for unique identification in API calls
            {
                Caption = 'System Identifier';
            }

            field("companyID"; Rec."Company ID")
            {
            }

            field("workflow"; Rec."Workflow")
            {
            }

            field("frequencyStatus"; Rec."frequncy Status")
            {
            }

            field("noOfDays"; Rec."No. of Days")
            {
            }

            field("propertyID"; Rec."Property ID")
            {
            }
        }
    }
}
