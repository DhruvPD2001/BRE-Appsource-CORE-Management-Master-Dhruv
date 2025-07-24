table 50103 "Emirate"
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
        field(50102; "Country Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country Code';
            TableRelation = Country."Country Code";
        }
        field(50103; "Emirate Name"; Enum Emirates)
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirate Name';
        }
    }

    keys
    {
        key(PK; "ID", "Emirate Name", "Country Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Sl No.", ID, "Emirate Name", "Country Code")
        {

        }
    }

    //-------------Record Delete--------------//
    trigger OnDelete()
    var
        EmirateRec: Record "Emirate";
    begin
        EmirateRec.SetRange("Sl No.", "Sl No." + 1, 2147483647); // Set filter to find records with 'Sl No.' greater than the current record

        // Process each of those records and adjust 'Sl No.'
        if EmirateRec.FindSet() then
            repeat
                // Decrease 'Sl No.' by 1 for each record
                EmirateRec."Sl No." := EmirateRec."Sl No." - 1;
                EmirateRec.Modify();
            until EmirateRec.Next() = 0;

    end;
    //-------------Record Delete--------------//

    //-------------Record Insert--------------//
    trigger OnInsert()
    var
        EmirateRec: Record "Emirate";
    begin
        // Check if 'Sl No.' is 0 (indicating it's a new record)
        if "Sl No." = 0 then
            // If there are existing records, find the last one and increment
            if EmirateRec.FindLast() then
                "Sl No." := EmirateRec."Sl No." + 1
            else
                "Sl No." := 1;

    end;
    //-------------Record Insert--------------//


}
