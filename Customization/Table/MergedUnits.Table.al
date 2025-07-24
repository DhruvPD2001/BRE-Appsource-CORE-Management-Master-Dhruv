table 50310 "Merged Units"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "Merged Unit ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Merged Unit ID';
            AutoIncrement = true;
        }
        field(50101; "Property ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property ID';
            TableRelation = "Property Registration"."Property ID";

            trigger OnValidate()
            var
                PropertyRec: Record "Property Registration";
            begin
                // Attempt to retrieve the property record based on the selected Property ID
                PropertyRec.SetRange("Property ID", Rec."Property ID");
                if PropertyRec.FindFirst() then begin
                    "Property Name" := PropertyRec."Property Name"; // Replace with actual field name in "Property Registration"
                    "Property Type" := Format(PropertyRec."Property Classification");
                    "Base Unit of Measure" := PropertyRec."Base Unit of Measure"; // Replace with actual field name for Property Type

                end else begin
                    // Clear the field if no record is found
                    "Property Name" := '';
                    "Property Type" := '';
                    "Base Unit of Measure" := '';
                end;
            end;
        }


        field(50102; "Property Name"; Text[100])
        {
            Caption = 'Property Name';
            DataClassification = ToBeClassified;
        }

        field(50103; "Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit ID';
            TableRelation = "Item"."No."
        where("Property ID" = field("Property ID"));
        }

        field(50104; "Unit Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Name';

        }

        field(50105; "Merged Unit Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Merged Unit Name';

        }

        field(50106; "Unit Size"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Unit Size';
        }

        field(50107; "Market Rate per Square"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Market Rate per Square';
        }

        field(50108; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Amount';
        }

        field(50109; "Property Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Type';
        }

        field(50110; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Merge Unit Status';
            OptionMembers = "Free","Occupied","Selected","N/A";
        }
        field(50111; "FixedNumber"; Code[100]) // New field to store the incrementing number
        {
            DataClassification = ToBeClassified;
        }

        field(50112; "Spliting Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Splitting  Status';
            OptionMembers = " ","Merge","Unmerge";
        }

        field(50113; "Base Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Base Unit of Measure';

        }

        field(50114; "Single Unit Name"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Single Unit Names';
        }

        field(50115; "Unit Number"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Number';
        }
    }

    keys
    {
        key(PK; "Merged Unit ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Merged Unit ID", "Unit ID", "Unit Name", "Property Name")
        {

        }
    }
    procedure AutoGenerateUnitName()
    var
        PropertyCode: Text;
    begin
        PropertyCode := FormatName(Rec."Property Name");
        Rec."Merged Unit Name" := PropertyCode + '-MU-' + Format(Rec.FixedNumber); // Assuming 'MU' is the Unit Type for Merge Unit
    end;

    procedure FormatName(Name: Text): Text
    var
        Words: List of [Text];
        Word: Text;
        Code: Text;
        i: Integer;
    begin
        Words := Name.Split(' ');
        if Words.Count() = 1 then
            Code := CopyStr(Words.Get(1), 1, 3)
        else
            Code := '';
        for i := 1 to Words.Count() do begin
            Word := Words.Get(i);
            Code += CopyStr(Word, 1, 1);
        end;
        exit(Code);
    end;

    trigger OnInsert()
    var
        NoSeriesManagement: Codeunit "No. Series";
        NewUnitNo: Code[20];
    begin
        if ("FixedNumber" = '') then begin
            NewUnitNo := NoSeriesManagement.GetNextNo('MGUNITNO', 0D, true); // Use the number series code you created
            FixedNumber := NewUnitNo;
        end;
        AutoGenerateUnitName();

    end;
}