table 50303 "Property Registration"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Property ID";

    fields
    {
        // Property ID field (Primary Key)
        field(50100; "Property ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property ID';
            // NotBlank = true;
            // AutoIncrement = true; // Automatically increment the ID
            // Editable = false; // Make it read-only for the user
        }

        field(50127; "Company ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Company ID';
            TableRelation = "testData"."Company ID";
        }

        // Property Description field
        field(50101; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }

        // Property Name
        field(50102; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';
        }

        // Blocked field (Boolean toggle)
        field(50103; "Blocked"; Enum "Vendor Blocked")
        {
            DataClassification = ToBeClassified;
            Caption = 'Blocked';
        }

        // Type field (Option type)
        field(50104; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
            OptionMembers = Inventory,"Non Inventory";
        }

        // Base Unit of Measure
        field(50105; "Base Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure"."Code";
        }

        // Market Rate per Sq. Ft.
        field(50106; "Market Rate per Sq. Ft."; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Market Rate per Sq.(Dirham)';

        }
        // Property Location
        field(50107; "Emirate"; Enum Emirates)
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirate';
            // TableRelation = Emirate."Emirate Name";
            trigger OnValidate()
            begin
                "Community" := '';
            end;
        }

        field(50108; "Community"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Community';
            TableRelation = Community."Community Name"
                 where("Emirate Name" = field(Emirate));
        }

        // Number of Units
        field(50109; "Number of Units"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Number Of Units';
        }

        // Property Classification (related to Property Classification Table)
        field(50110; "Property Classification"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Classification';
            TableRelation = "Primary Classification"."Classification Name";
            // NotBlank = true;

            trigger OnValidate()
            begin
                // Clear the Property Type field when Property Classification is changed
                "Property Type" := '';
            end;
        }

        // Property Type (related to Property Type table)
        field(50111; "Property Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Type';
            // Filter the Property Type values based on the selected Primary Classification
            TableRelation = "Property Type"."Property Type"
                 where("Classification Name" = field("Property Classification"));

        }

        // Last Date Modified
        field(50112; "Registration Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Registration Date';
        }

        // GTIN (optional)
        field(50113; "GTIN"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'GTIN';
        }

        field(50114; "Owner ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner ID';
            TableRelation = "Owner Profile"."Owner ID";


            // Optional: Set as Primary Key

        }

        field(50115; "Ownership Documents"; Text[250])
        {
            Caption = 'Ownership Documents';
            DataClassification = ToBeClassified;
        }
        field(50116; "Compliance Certificates"; Text[250])
        {
            Caption = 'Compliance Certificates';
            DataClassification = ToBeClassified;
        }
        field(50117; "Legal Documents"; Text[250])
        {
            Caption = 'Legal Documents';
            DataClassification = ToBeClassified;
        }
        field(50118; "Property Size"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Size';
            // TableRelation = "Item"."Market Rate per Sq. Ft.";
        }

        field(50119; "Address"; Text[250])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;

        }
        field(50120; "Built-up Area"; Decimal)
        {
            Caption = 'Built-up Area (sq. ft)';
            DataClassification = ToBeClassified;

        }
        field(50121; "Makani Number"; Text[50])
        {
            Caption = 'Makani Number';
            DataClassification = ToBeClassified;

        }
        field(50122; "Municipality Number"; Text[50])
        {
            Caption = 'Municipality Number';
            DataClassification = ToBeClassified;

        }
        field(50123; "DEWA Number"; Text[50])
        {
            Caption = 'DEWA Number';
            DataClassification = ToBeClassified;
        }
        field(50124; "Number of Floors"; Integer)
        {
            Caption = 'Number of Floors';
            DataClassification = ToBeClassified;

        }
        field(50125; "Number of Lifts"; Integer)
        {
            Caption = 'Number of Lifts';
            DataClassification = ToBeClassified;

        }

        field(50126; "Business Unit Code"; Code[20])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit".Code;
        }

        field(50137; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor ID';
            //TableRelation = "Vendor Profile"."Vendor ID";
            TableRelation = "Vendor Profile"."Vendor ID" WHERE("Vendor Category" = FILTER(<> 'Brokers and Commission Agent'));


            trigger OnValidate()
            var
                VendorDetails: Record "Vendor Profile";
                Calculationdeatils: Record "Vendor Calculation Details";
            begin
                VendorDetails.SetRange("Vendor ID", Rec."Vendor ID");
                if VendorDetails.FindFirst() then begin
                    "Vendor ID" := VendorDetails."Vendor ID";
                    "Vendor Name" := VendorDetails."Vendor Name"; // Convert Integer to Text
                    "Search Name" := VendorDetails."Search Name";
                    "Start Date" := VendorDetails."Start Date";
                    "End Date" := VendorDetails."End Date";
                    "Contract Status" := VendorDetails."Contract Status";
                    "Vendor Category" := VendorDetails."Vendor Category";
                    "Vendor Contact No." := VendorDetails."Vendor Contact No.";
                    "Blocked" := VendorDetails."Blocked";
                    "Privacy Blocked" := VendorDetails."Privacy Blocked";
                    "IC Partner Code" := VendorDetails."IC Partner Code";
                    "Purchaser Code" := VendorDetails."Purchaser Code";
                    "Responsibility Center" := VendorDetails."Responsibility Center";
                    "Disable Search by Name" := VendorDetails."Disable Search by Name";
                    "Company Size Code" := VendorDetails."Company Size Code";
                    "Last Date Modified" := VendorDetails."Last Date Modified";
                    "Document Sending Profile" := VendorDetails."Document Sending Profile";
                    "Balance (LCY)" := VendorDetails."Balance (LCY)";
                    "Balance Due (LCY)" := VendorDetails."Balance Due (LCY)";

                    // ManagementFeeMasterDetailsFetch();
                end else begin // Clear the fields if no record is found
                    "Vendor ID" := '';
                    "Vendor Name" := '';
                    "Search Name" := '';
                    "Vendor Contact No." := '';
                    "Start Date" := 0D;
                    "End Date" := 0D;
                    "Vendor Category" := '';
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
                    "Contract Status" := "Contract Status"::" ";
                end;

                Calculationdeatils.SetRange("Vendor ID", Rec."Vendor ID");
                if Calculationdeatils.FindFirst() then begin
                    "Calculation Method" := Calculationdeatils."Calculation Method";
                    "Percentage Type" := Calculationdeatils."Percentage Type";
                    "Percentage" := Calculationdeatils."Percentage";
                    "Amount" := Calculationdeatils."Amount";
                    "Base Amount" := Calculationdeatils."Base Amount";
                    "Frequency Of Payment" := Calculationdeatils."Frequency Of Payment";

                    ManagementFeeMasterDetailsFetch();
                end else begin
                    "Calculation Method" := ' ';
                    "Percentage Type" := "Percentage Type"::" ";
                    "Percentage" := 0;
                    "Amount" := 0;
                    "Base Amount" := "Base Amount"::" ";
                    "Frequency Of Payment" := "Frequency Of Payment"::" ";
                end;
            end;
        }

        field(50128; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Name';
        }
        field(50138; "Search Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Search Name';
        }
        field(50129; "Vendor Contact No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Contact No.';
        }
        field(50130; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }
        field(50131; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }
        field(50136; "Contract Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Status';
            OptionMembers = " ","Active","Terminate";
        }

        field(50139; "Balance (LCY)"; Decimal)
        {
            Caption = 'Balance (LCY)';
        }
        // field(50140; "Balance Due (LCY) As Customer"; Decimal)
        // {
        //     Caption = 'Balance Due (LCY) As Customer';
        //     Editable = false;
        // }
        field(50141; "Balance Due (LCY)"; Decimal)
        {
            Caption = 'Balance Due (LCY)';
        }

        field(50142; "Privacy Blocked"; Boolean)
        {
            Caption = 'Privacy Blocked';
        }
        field(50143; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
        }

        field(50144; "Document Sending Profile"; Code[20])
        {
            Caption = 'Document Sending Profile';
        }

        field(50145; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
        }
        field(50146; "Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
        }

        field(50147; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
        }

        field(50148; "Disable Search by Name"; Boolean)
        {
            Caption = 'Disable Search by Name';
        }
        field(50149; "Company Size Code"; Code[20])
        {
            Caption = 'Company Size Code';
        }
        field(50150; "Vendor Category"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Category';
        }

        field(50151; "Percentage"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage';
        }

        field(50152; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }

        field(50154; "Calculation Method"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Calculation Method';
            TableRelation = "Calculation Type"."Calculation Type";
        }

        field(50155; "Percentage Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage Type';
            OptionMembers = " ","Fixed","Variable";
        }
        field(50156; "Base Amount"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Base Amount';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
        }
        field(50157; "Frequency Of Payment"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Frequency Of Payment';
            OptionMembers = " ","Monthly","Quaterly","Half Yearly","Yearly";
        }


    }



    keys
    {
        key(PK; "Property ID", "Property Classification", "Property Type", "Property Size")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Property ID", "Property Name", "Property Classification", "Property Type")
        {

        }
    }



    trigger OnInsert()
    var
        CompanyRec: Record "testData";
        NoSeriesMgt: Codeunit "No. Series";

    begin
        if "Property ID" = '' then
            "Property ID" := NoSeriesMgt.GetNextNo('PROPERTYID', Today(), true);


        if CompanyRec.FindFirst() then
            "Company ID" := CompanyRec."Company ID";

    end;




    procedure ManagementFeeMasterDetailsFetch()
    var
        managementfee: Record "Management Fee MasterData";
    begin
        managementfee.SetRange("Vendor ID", Rec."Vendor ID");
        managementfee.SetRange("Property ID", Rec."Property ID");

        if not managementfee.IsEmpty() then
            exit;
        managementfee.Init();
        managementfee."Property ID" := Rec."Property ID";
        managementfee."Company ID" := Rec."Company ID";
        managementfee."Vendor ID" := Rec."Vendor ID";
        managementfee."Vendor Name" := Rec."Vendor Name";
        managementfee."Property Name" := Rec."Property Name";
        managementfee."Start Date" := Rec."Start Date";
        managementfee."End Date" := Rec."End Date";
        managementfee."Property Type" := Rec."Property Classification";
        managementfee."Contract Status" := Rec."Contract Status";
        managementfee."Calculation Method" := Rec."Calculation Method";
        managementfee."Percentage Type" := Rec."Percentage Type";
        managementfee."Base Amount" := Rec."Base Amount";
        managementfee."Frequency Of Payment" := Rec."Frequency Of Payment";
        managementfee.Amount := Rec.Amount;
        managementfee.Percentage := Rec.Percentage;
        managementfee.Insert();
        Clear(managementfee);
    end;

    trigger OnDelete()
    var
    begin
        deleteWorkflowFrequencyPR();
    end;

    procedure deleteWorkflowFrequencyPR()
    var
        WorkflowFrequencyPR: Record "Workflow Frequency PR";
    begin
        WorkflowFrequencyPR.SetRange("Company Id", Rec."Company ID");
        WorkflowFrequencyPR.SetRange("Property ID", Rec."Property ID");
        if WorkflowFrequencyPR.FindSet() then
            WorkflowFrequencyPR.DeleteAll();
    end;
}
