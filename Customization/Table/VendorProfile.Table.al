table 50926 "Vendor Profile"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Vendor ID";
    fields
    {
        field(50100; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor ID';
            TableRelation = Vendor."No." WHERE("Vendor Category" = FILTER('Property Management System' | 'Brokers and Commission Agent'),
             "No." = FILTER('PM_V_*'));
            trigger OnValidate()
            var
                vendor: Record Vendor;
            begin
                vendor.SetRange("No.", Rec."Vendor ID");
                if vendor.FindFirst() then begin
                    Rec."Vendor ID" := vendor."No.";
                    "Vendor Name" := vendor."Name";
                    "Search Name" := vendor."Search Name";
                    "Vendor Contact No." := Vendor.Contact;
                    "Vendor Category" := vendor."Vendor Category";
                    "Blocked" := Vendor."Blocked";
                    "Privacy Blocked" := Vendor."Privacy Blocked";
                    "IC Partner Code" := Vendor."IC Partner Code";
                    "Purchaser Code" := Vendor."Purchaser Code";
                    "Responsibility Center" := Vendor."Responsibility Center";
                    "Disable Search by Name" := Vendor."Disable Search by Name";
                    "Company Size Code" := Vendor."Company Size Code";
                    "Last Date Modified" := Vendor."Last Date Modified";
                    "Document Sending Profile" := Vendor."Document Sending Profile";
                    "Balance (LCY)" := Vendor."Balance (LCY)";
                    "Balance Due (LCY)" := Vendor."Balance Due (LCY)";
                    Address := Vendor.Address;
                    "Address 2" := Vendor."Address 2";
                    "Country" := Vendor.County;
                    "Emirate" := vendor.Emirate;
                    "Community" := vendor.Community;
                    "Phone No." := Vendor."Phone No.";
                    "Mobile Phone No." := Vendor."Mobile Phone No.";
                    "E-Mail" := Vendor."E-Mail";
                    "Our Account No." := Vendor."Our Account No.";
                    "Primary Contact Code" := Vendor."Primary Contact No.";
                    "VAT Registration No." := Vendor."VAT Registration No.";
                    "Price Calculation Method" := Vendor."Price Calculation Method";
                    "Price Including VAT" := Vendor."Prices Including VAT";
                    "Application Method" := Vendor."Application Method";
                    "Payment Terms Code" := Vendor."Payment Terms Code";
                    "Payment Method Code" := Vendor."Payment Method Code";
                    Priority := Vendor.Priority;
                    "Block Payment Tolerance" := Vendor."Block Payment Tolerance";
                    "Preferred Bank Account Code" := Vendor."Preferred Bank Account Code";
                    "Partner Type" := Vendor."Partner Type";
                    "Cash Flow Payment Terms Code" := Vendor."Cash Flow Payment Terms Code";
                    "Creditor No." := Vendor."Creditor No.";
                    "Location Code" := Vendor."Location Code";
                    "Shipment Method Code" := Vendor."Shipment Method Code";
                    "Lead Time Calculation" := Vendor."Lead Time Calculation";
                    "Base Calendar Code" := Vendor."Base Calendar Code";
                    "Over-Receipt Code" := Vendor."Over-Receipt Code";
                end else begin
                    "Vendor ID" := '';
                    "Vendor Name" := '';
                    "Search Name" := '';
                    "Vendor Contact No." := '';
                    "Blocked" := "Blocked"::" ";
                    "Privacy Blocked" := false;
                    "IC Partner Code" := '';
                    "Purchaser Code" := '';
                    "Responsibility Center" := '';
                    "Disable Search by Name" := false;
                    "Company Size Code" := '';
                    "Last Date Modified" := 0D;
                    "Document Sending Profile" := '';
                    "Balance (LCY)" := 0;
                    "Balance Due (LCY)" := 0;
                    Address := '';
                    "Address 2" := '';
                    "Country" := '';
                    "Phone No." := '';
                    "Mobile Phone No." := '';
                    "E-Mail" := '';
                    "Home Page" := '';
                    "Our Account No." := '';
                    "Primary Contact Code" := '';
                    "VAT Registration No." := '';
                    "Price Calculation Method" := "Price Calculation Method"::" ";
                    "Price Including VAT" := false;
                    "Application Method" := "Application Method"::"Manual";
                    "Payment Terms Code" := '';
                    "Payment Method Code" := '';
                    Priority := 0;
                    "Block Payment Tolerance" := false;
                    "Preferred Bank Account Code" := '';
                    "Partner Type" := "Partner Type"::" ";
                    "Cash Flow Payment Terms Code" := '';
                    "Creditor No." := '';
                    "Location Code" := '';
                    "Shipment Method Code" := '';
                    "Base Calendar Code" := '';
                    "Over-Receipt Code" := '';
                end;
            end;
        }
        field(50101; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Name';
            Editable = false;
        }
        field(50102; "Vendor Contact No."; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Contact No.';
            Editable = false;
        }
        field(50103; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }
        field(50104; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }
        field(50146; "Vendor Category"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Category';
            TableRelation = "Vendor Category"."Vendor Category Type";
        }
        field(50109; "Contract Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Status';
            OptionMembers = " ","Active","Terminate";
        }
        field(50111; "Blocked"; Enum "Vendor Blocked")
        {
            DataClassification = ToBeClassified;
            Caption = 'Blocked';
            Editable = false;
        }
        field(50112; "Balance (LCY)"; Decimal)
        {
            Caption = 'Balance (LCY)';
            Editable = false;
        }
        field(50114; "Balance Due (LCY)"; Decimal)
        {
            Caption = 'Balance Due (LCY)';
            Editable = false;
        }
        field(50115; Address; Text[100])
        {
            Caption = 'Address';
            Editable = false;
        }
        field(50116; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            Editable = false;
        }
        field(50163; Country; Text[30])
        {
            Caption = 'Country';
            Editable = false;
        }
        field(50164; Emirate; Enum Emirates)
        {
            Caption = 'Emirate';
            Editable = false;
        }
        field(50119; Community; Text[100])
        {
            Caption = 'Community';
            Editable = false;
        }
        field(50121; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            Editable = false;
        }
        field(50122; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            Editable = false;
        }
        field(50123; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            Editable = false;
        }
        field(50124; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            Editable = false;
        }
        field(50125; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
            Editable = false;
        }
        field(50126; "Primary Contact Code"; Code[80])
        {
            Caption = 'Primary Contact Code';
            Editable = false;
        }
        field(50128; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            Editable = false;
        }
        field(50129; "Price Calculation Method"; Enum "Price Calculation Method")
        {
            Caption = 'Price Calculation Method';
            Editable = false;
        }
        field(50130; "Price Including VAT"; Boolean)
        {
            Caption = 'Price Including VAT';
            Editable = false;
        }
        field(50131; "Application Method"; Enum "Application Method")
        {
            DataClassification = ToBeClassified;
            Caption = 'Application Method';
            Editable = false;
        }
        field(50132; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            Editable = false;
        }
        field(50133; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            Editable = false;
        }
        field(50134; Priority; Integer)
        {
            Caption = 'Priority';
            Editable = false;
        }
        field(50135; "Block Payment Tolerance"; Boolean)
        {
            Caption = 'Block Payment Tolerance';
            Editable = false;
        }
        field(50136; "Preferred Bank Account Code"; Code[100])
        {
            Caption = 'Preferred Bank Account Code';
            Editable = false;
        }
        field(50137; "Partner Type"; Enum "Partner Type")
        {
            DataClassification = ToBeClassified;
            Caption = 'Partner Type';
            Editable = false;
        }
        field(50138; "Cash Flow Payment Terms Code"; Code[100])
        {
            Caption = 'Cash Flow Payment Terms Code';
            Editable = false;
        }
        field(50139; "Creditor No."; Code[100])
        {
            Caption = 'Creditor No.';
            Editable = false;
        }
        field(50140; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Editable = false;
        }
        field(50141; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            Editable = false;
        }
        field(50142; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
            Editable = false;
        }
        field(50143; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            Editable = false;
        }
        field(50144; "Over-Receipt Code"; Code[20])
        {
            Caption = 'Over-Receipt Code';
            Editable = false;
        }
        field(50145; "Receive E-Document To"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Receive E-Document To';
            OptionMembers = " ","Purchase Order","Purchase Invoice";
            Editable = false;
        }
        field(50147; "Privacy Blocked"; Boolean)
        {
            Caption = 'Privacy Blocked';
            Editable = false;
        }
        field(50148; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50149; "Document Sending Profile"; Code[20])
        {
            Caption = 'Document Sending Profile';
            Editable = false;
        }
        field(50150; "Search Name"; Code[100])
        {
            Caption = 'Search Name';
            Editable = false;
        }
        field(50151; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            Editable = false;
        }
        field(50152; "Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
            Editable = false;
        }
        field(50153; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
        }
        field(50154; "Disable Search by Name"; Boolean)
        {
            Caption = 'Disable Search by Name';
            Editable = false;
        }
        field(50155; "Company Size Code"; Code[20])
        {
            Caption = 'Company Size Code';
            Editable = false;
        }
        field(50156; "Percentage"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage';
        }
        field(50157; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(50159; "Calculation Method"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Calculation Method';
            TableRelation = "Calculation Type"."Calculation Type";
        }
        field(50160; "Percentage Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage Type';
            OptionMembers = " ","Fixed","Variable";
        }
        field(50161; "Base Amount Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Base Amount Type';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
        }
        field(50162; "Frequency Of Payment"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Frequency Of Payment';
            OptionMembers = " ","Monthly","Quaterly","Half Yearly","Yearly";
        }
    }
    keys
    {
        key(PK; "Vendor ID", "Vendor Name")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Vendor ID", "Vendor Name")
        {
        }
    }
    trigger OnDelete()
    var
    begin
        DeleteVendorContractDocument();
        DeleteVendorDocument();
        DeleteVendorCalculationDetails();
    end;

    procedure DeleteVendorContractDocument()
    var
        VendorDoc: Record "Vendor Contract Document";
    begin
        VendorDoc.SetRange("Vendor Id", Rec."Vendor ID");
        if VendorDoc.FindSet() then
            VendorDoc.DeleteAll();
    end;

    procedure DeleteVendorDocument()
    var
        VendorDoc: Record "Vendor Document";
    begin
        VendorDoc.SetRange("Vendor Id", Rec."Vendor ID");
        if VendorDoc.FindSet() then
            VendorDoc.DeleteAll();
    end;

    procedure DeleteVendorCalculationDetails()
    var
        VendorDoc: Record "Vendor Calculation Details";
    begin
        VendorDoc.SetRange("Vendor Id", Rec."Vendor ID");
        if VendorDoc.FindSet() then
            VendorDoc.DeleteAll();
    end;
}
