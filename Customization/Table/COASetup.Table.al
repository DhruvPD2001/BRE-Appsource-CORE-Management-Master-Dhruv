table 50513 "COA Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50501; "Primary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(50502; "Residential Rent"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Residential Rent';
            TableRelation = "G/L Account"."No.";
        }
        field(50503; "Commercial Rent"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Commercial Rent';
            TableRelation = "G/L Account"."No.";
        }
        field(50504; "Residential Unearned Rent"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Residential-Unearned Rent';
            TableRelation = "G/L Account"."No.";
        }
        field(50505; "Commercial Unearned Rent"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Commercial-Unearned Rent';
            TableRelation = "G/L Account"."No.";
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}