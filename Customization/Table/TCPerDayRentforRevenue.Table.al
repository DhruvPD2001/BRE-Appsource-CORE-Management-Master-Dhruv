table 50332 "TC Per Day Rent for Revenue"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(50108; "Id"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }

        field(50109; "Contract Renewal Id"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(50101; "Proposal Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50102; "Merge Unit Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50103; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50104; "Unit ID"; Code[200])
        {
            DataClassification = ToBeClassified;
        }

        field(50105; "Sq.Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50106; "Per Day Rent Per Unit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50107; "Get Data"; Code[100])
        {
            DataClassification = ToBeClassified;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';


        }


    }

    keys
    {
        key(PK; "Id")
        {
            Clustered = true;
        }
    }
}
