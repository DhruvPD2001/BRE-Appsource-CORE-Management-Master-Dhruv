table 50100 "Owner Profile"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Owner ID";
    fields
    {
        field(50100; "Owner ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner ID';
            AutoIncrement = true;
            BlankZero = true; // Hide zero value
            Editable = false;
        }

        field(50101; "Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Full Name';
        }
        field(50102; "Nationality"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nationality';
        }
        field(50103; "Emirates ID"; Code[25])
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirates ID';
        }
        field(50104; "Phone Number"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Phone Number';
        }
        field(50105; "Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email Address';
        }
        field(50106; "Mailing Address"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mailing Address';
        }
        field(50107; "Local Address in UAE"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Local Address in UAE';
        }
        field(50108; "Ownership Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ownership Type';
            OptionMembers = Individual,Corporate,Joint;
        }
        field(50109; "TRN"; Code[15])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tax Registration Number';
        }
        field(50110; "Bank Account Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Account Number';
        }
        field(50111; "IBAN"; Code[34])
        {
            DataClassification = ToBeClassified;
            Caption = 'IBAN';
        }
        field(50112; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Name';
        }
        field(50113; "SWIFT/IFSC Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'SWIFT/IFSC Code';
        }
        field(50115; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            OptionMembers = Active,Inactive;
        }
        field(50116; "Date of Registration"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date of Registration';
        }
        field(50117; "Remarks/Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remarks/Notes';
        }
        field(50118; "Ejari Registration Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ejari Registration Number';
            Tooltip = 'Required for legal tenancy agreements in Dubai';
        }
        field(50119; "RERA Owner ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'RERA Owner ID';
            Tooltip = 'RERA (Real Estate Regulatory Agency) registration details for property owners';
        }
        field(50120; "P.O.Box"; Code[50])
        {
            Caption = 'P.O.Box';
        }
    }

    keys
    {
        key(PK; "Owner ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Owner ID", "Full Name")
        {

        }
    }
}
