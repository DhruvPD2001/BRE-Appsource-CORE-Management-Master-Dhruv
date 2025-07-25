page 50325 "All Profile API"
{
    PageType = API;
    SourceTable = "All Profile";
    APIPublisher = 'realestate';
    APIGroup = 'approvalflow';
    APIVersion = 'v2.0';
    EntityName = 'allProfile';
    EntitySetName = 'allProfiles';
    Caption = 'All Profile';
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

            field(profileID; Rec."Profile ID")
            {

            }

            field(roleCenterID; Rec."Role Center ID")
            {

            }


        }
    }
}
