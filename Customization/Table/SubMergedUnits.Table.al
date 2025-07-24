table 50314 "Sub Merged Units"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Merged Unit ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Merged Unit ID';

        }
        field(50101; "Property ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property ID';
        }
        field(50102; "Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit ID';

        }
        field(50103; "Unit Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Name';

        }
        field(50104; "Unit Size"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Unit Size';
        }

        field(50105; "Market Rate per Square"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Market Rate per Square';
        }

        field(50106; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Amount';
        }

        field(50107; "Base Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Base Unit of Measure';

        }

        field(50108; "Single Unit Name"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Single Unit Names';
        }
    }

    keys
    {
        key(PK; "Merged Unit ID", "Unit ID")
        {
            Clustered = true;
        }
    }






}