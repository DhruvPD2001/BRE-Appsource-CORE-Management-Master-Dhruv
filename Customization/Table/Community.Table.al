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
        field(50102; "Emirate Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = '"Emirate Name"';
            TableRelation = Emirate.ID;

            trigger OnValidate()
            var
                emirate: Record "Emirate";
                emirateID: Integer;
            begin
                Evaluate(emirateID, "Emirate Name");
                emirate.SetRange(ID, emirateID);
                if emirate.FindFirst() then
                    "Emirate Name" := Format(emirate."Emirate Name")
                else
                    Error('Invalid Emirate Name: %1', "Emirate Name");
            end;
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
        key(PK; "ID")
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
    trigger OnDelete()
    var
        CommunityRec: Record "Community";
    begin
        CommunityRec.SetRange("Sl No.", "Sl No." + 1, 2147483647);
        if CommunityRec.FindSet() then
            repeat
                CommunityRec."Sl No." := CommunityRec."Sl No." - 1;
                CommunityRec.Modify();
            until CommunityRec.Next() = 0;
    end;

    trigger OnInsert()
    var
        CommunityRec: Record "Community";
    begin
        if "Sl No." = 0 then
            if CommunityRec.FindLast() then
                "Sl No." := CommunityRec."Sl No." + 1
            else
                "Sl No." := 1;
    end;
}
