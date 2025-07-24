page 50326 "UserSettingAPI"
{
    PageType = API;
    SourceTable = "User Personalization";
    APIPublisher = 'realestate';
    APIGroup = 'approvalflow';
    APIVersion = 'v2.0';
    EntityName = 'userSetting';
    EntitySetName = 'userSettings';
    Caption = 'User Settings';

    DelayedInsert = true;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            field(userSID; Rec."User SID") // System ID field for unique identification in API calls
            {
                Caption = 'System Identifier';
            }

            field(userID; Rec."User ID")
            {

            }

            field(fullName; Rec."Full Name")
            {

            }

            field(profileID; Rec."Profile ID")
            {

            }

            field(company; Rec.Company)
            {

            }

            field(role; Rec.Role)
            {

            }




        }
    }
}
