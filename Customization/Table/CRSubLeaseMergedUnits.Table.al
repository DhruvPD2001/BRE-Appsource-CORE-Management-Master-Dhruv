table 50326 "CR Sub Lease Merged Units"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Merge Unit ID"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Merge Unit ID';

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
        field(50109; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50110; "Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50112; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; "Merge Unit ID", "Unit ID", "ID")
        {
            Clustered = true;
        }
    }

}