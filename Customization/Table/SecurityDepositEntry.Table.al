table 50113 "Security Deposit Entry"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(50101; "Security Deposit ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Adjustment Security Deposit".ID;
        }
        field(50102; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50103; "Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50104; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50105; "End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50106; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Pending,Approved'; // Include an empty option for flexibility
            OptionMembers = Pending,Approved;
        }
        field(50107; "Total Amount"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50108; "Main Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}