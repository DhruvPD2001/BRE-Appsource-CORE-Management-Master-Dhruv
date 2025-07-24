table 50115 "Customer Payment Receipt"
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
        field(50101; "Posing Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50102; "Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = CustomerContent;
        }
        field(50103; "Account No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50104; "Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50105; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50106; "Invoice No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50107; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.", "Document No.")
        {
            Clustered = true;
        }
    }
}