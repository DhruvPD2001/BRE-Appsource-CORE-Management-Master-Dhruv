table 50104 "Community"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = ID;

    fields
    {
        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(50101; "Sl No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sl No.';
            Editable = false;
        }
        field(50102; "Emirate Name"; Enum Emirates)
        {
            DataClassification = ToBeClassified;
            Caption = '"Emirate Name"';
            // TableRelation = Emirate."Emirate Name";
        }
        field(50103; "Community Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Community Code';
        }
        field(50104; "Community Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Community Name';
        }
    }

    keys
    {
        key(PK; "ID", "Community Name", "Emirate Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Sl No.", ID, "Community Name", "Emirate Name", "Community Code")
        {

        }
    }

    //-------------Record Delete--------------//
    trigger OnDelete()
    var
        CommunityRec: Record "Community";
    begin
        CommunityRec.SetRange("Sl No.", "Sl No." + 1, 2147483647); // Set filter to find records with 'Sl No.' greater than the current record

        // Process each of those records and adjust 'Sl No.'
        if CommunityRec.FindSet() then
            repeat
                CommunityRec."Sl No." := CommunityRec."Sl No." - 1;
                CommunityRec.Modify();
            until CommunityRec.Next() = 0;

    end;

    //-------------Record Delete--------------//

    //-------------Record Insert--------------//

    trigger OnInsert()
    var
        CommunityRec: Record "Community";
    begin
        // Check if 'Sl No.' is 0 (indicating it's a new record)
        if "Sl No." = 0 then
            // If there are existing records, find the last one and increment
            if CommunityRec.FindLast() then
                "Sl No." := CommunityRec."Sl No." + 1
            else
                "Sl No." := 1;

    end;
    //-------------Record Insert--------------//

}
