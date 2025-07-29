table 50909 "Workflow Frequency"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Company ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Company ID';
            TableRelation = "Company Data"."Company ID";

        }

        field(50101; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }

        field(50102; "Workflow"; Option)
        {
            OptionMembers = " ","Payment Reminder","Invoice","Renewal Notification to Tenant","Tenant Loyalty Check Reminder";
            Caption = 'Workflow';
        }

        field(50103; "frequncy Status"; Option)
        {
            OptionMembers = " ","Company","Property";
            Caption = 'frequncy Status';
        }

        field(50104; "No. of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }



    keys
    {
        key(Key1; "Entry No.", "Company ID")
        {
            Clustered = true;
        }
    }
}





