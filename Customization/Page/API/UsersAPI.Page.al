page 50324 "UsersAPI"
{
    PageType = API;
    SourceTable = "User";
    APIPublisher = 'realestate';
    APIGroup = 'approvalflow';
    APIVersion = 'v2.0';
    EntityName = 'user';
    EntitySetName = 'users';
    Caption = 'users';
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            field("systemId"; Rec.systemId) // System ID field for unique identification in API calls
            {
                Caption = 'systemId';
            }

            field("userSecurityID"; Rec."User Security ID") // System ID field for unique identification in API calls
            {
                Caption = 'System Identifier';
            }


            field(userName; Rec."User Name")
            {

            }

            field(fullName; Rec."Full Name")
            {

            }

            field(state; Rec."State")
            {

            }

            field("expiryDate"; Rec."Expiry Date")
            {

            }

            field(contactEmail; Rec."Contact Email")
            {

            }


        }
    }
}
