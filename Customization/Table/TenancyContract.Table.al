table 50307 "Tenancy Contract"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Contract ID";

    fields
    {
        field(50100; "Owner's Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner Name';
            TableRelation = "Owner Profile";
            trigger OnValidate()
            var
                OwnerRec: Record "Owner Profile";
                ownerID: Integer;
            begin
                Evaluate(ownerID, "Owner's Name");
                if "Owner's Name" <> '' then begin
                    OwnerRec.Reset();
                    OwnerRec.SetRange("Owner ID", ownerID);
                    if OwnerRec.FindFirst() then begin
                        "Owner's Name" := OwnerRec."Full Name";
                        "Owner ID" := OwnerRec."Owner ID";
                    end;
                end;
            end;
        }
        field(50101; "Lessor's Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lessor Name';
        }

        field(50102; "Lessor's Emirates ID"; Code[15])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lessor Emirates ID';
        }

        field(50103; "License No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'License No.';

        }

        field(50104; "Licensing Authority"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Licensing Authority';
        }

        field(50105; "Lessor's Email"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lessor Email';
        }

        field(50106; "Lessor's Phone"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lessor Phone';
        }
        field(50107; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
            AutoIncrement = true;
        }

        field(50108; "Proposal ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Proposal ID';
            TableRelation = "Lease Proposal Details"."Proposal ID" WHERE("Proposal Status" = CONST(Approved));

            trigger OnValidate()
            var
                LeaseProposalRec: Record "Lease Proposal Details";
                TenantContractRec: Record "Tenancy Contract";
            begin
                TenantContractRec.Reset();
                TenantContractRec.SetRange("Proposal ID", "Proposal ID");

                if TenantContractRec.FindFirst() and (TenantContractRec."Contract ID" <> "Contract ID") then
                    Error('The selected Proposal ID is already used for another tenant contract.');

                LeaseProposalRec.SetRange("Proposal ID", "Proposal ID");
                if LeaseProposalRec.FindFirst() then begin
                    "Tenant ID" := LeaseProposalRec."Tenant ID";
                    "Tenant_License No." := LeaseProposalRec."License No.";
                    "Tenant_Licensing Authority" := LeaseProposalRec."Licensing Authority";
                    "Customer Name" := LeaseProposalRec."Tenant Full Name";
                    "Email Address" := LeaseProposalRec."Tenant Contact Email";
                    "Emirates ID" := LeaseProposalRec."Emirates ID";
                    "Property ID" := LeaseProposalRec."Property ID";
                    "Payment Frequency" := LeaseProposalRec."Payment Frequency";
                    "Payment Method" := LeaseProposalRec."Payment Method";
                    "Base Unit of Measure" := LeaseProposalRec."Base Unit of Measure";
                    "Contact Number" := LeaseProposalRec."Tenant Contact Phone";
                    "Unit ID" := LeaseProposalRec."Unit ID";
                    "Merge Unit ID" := LeaseProposalRec."Merge Unit ID";
                    "Unit Name" := LeaseProposalRec."Unit Name";
                    "Unit Sq. Feet" := LeaseProposalRec."Unit Size";
                    "Annual Rent Amount" := LeaseProposalRec."Rent Amount";
                    "UnitID" := LeaseProposalRec."UnitID";
                    "Property Classification" := LeaseProposalRec."Usage Type";
                    "Property Type" := LeaseProposalRec."Unit Type";
                    "Property Name" := LeaseProposalRec."Property Name";
                    "Contract Start Date" := LeaseProposalRec."Lease Start Date";
                    "Contract End Date" := LeaseProposalRec."Lease End Date";
                    "Contract Tenor" := LeaseProposalRec."Lease Duration";
                    "Annual Rent Amount" := LeaseProposalRec."Annual Rent Amount";
                    "Rent Amount" := LeaseProposalRec."Rent Amount";
                    "Security Deposit Amount" := LeaseProposalRec."Security Deposit Amount";
                    "Security Amount Received" := LeaseProposalRec."Security Deposit Amount";
                    "Unit Number" := LeaseProposalRec."Unit Number";
                    "Makani Number" := LeaseProposalRec."Makani Number";
                    Emirate := LeaseProposalRec.Emirate;
                    Community := LeaseProposalRec.Community;
                    "DEWA Number" := LeaseProposalRec."DEWA Number";
                    "Property Size" := LeaseProposalRec."Property Size";
                    "No of Installments" := LeaseProposalRec."No of Installments";
                    "praposal Type Selected" := LeaseProposalRec."praposal Type Selected";
                    "Unit Address" := LeaseProposalRec."Unit Address";
                    "Usage Type" := LeaseProposalRec."Usage Type";
                    "Unit Type" := LeaseProposalRec."Unit Type";
                    "Single Unit Name" := LeaseProposalRec."Single Unit Name";
                    "Market Rate per Sq. Ft." := LeaseProposalRec."Market Rate per Sq. Ft.";
                    "Facilities/Amenities" := LeaseProposalRec."Facilities/Amenities";

                    "Unit Number" := LeaseProposalRec."Unit Number";
                    "Single Rent Calculation" := LeaseProposalRec."Single Rent Calculation";
                    "Merge Rent Calculation" := LeaseProposalRec."Merge Rent Calculation";
                    "Contract VAT %" := LeaseProposalRec."Rent Amount VAT %";
                    "Contract VAT Amount" := LeaseProposalRec."Rent VAT Amount";
                    "Contract Amount Including VAT" := LeaseProposalRec."Rent Amount Including VAT";
                    TenancyContractSubpage();
                    rentdatafetch();
                    brokerdata();
                end else begin
                    "Tenant ID" := '';
                    "Customer Name" := '';
                    "Property ID" := '';
                    "Unit ID" := '';
                    "Merge Unit ID" := '';
                    "Unit Name" := '';
                    "Unit Sq. Feet" := 0;
                    "Annual Rent Amount" := 0;
                    "Property Name" := '';
                    "Emirates ID" := '';
                    "Email Address" := '';
                    "Property Classification" := '';
                    "Property Type" := '';
                    "Property Name" := '';
                    "Unit Number" := '';
                end;
            end;
        }

        field(50109; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';
        }

        field(50110; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Name';
            TableRelation = Customer.Name;
        }

        field(50111; "Unit Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Name';
        }

        field(50112; "Ejari Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ejari Name';
        }

        field(50113; "Property Classification"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Classification';
            TableRelation = "Primary Classification"."Classification Name";
            NotBlank = true;
        }

        field(50114; "Property Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Type';
            TableRelation = "Secondary Classification"."Property Type"
                where("Classification Name" = field("Property Classification"));
        }

        field(50115; "Annual Rent Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount ';
        }

        field(50116; "Contract Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Date';
            // NotBlank = true;
            trigger OnValidate()
            var
            begin
                TenancyContractSubpage();
                TenancyContractSubpage2();

            end;
        }

        field(50117; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';
        }

        field(50118; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';

        }

        field(50119; "Contract Tenor"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Period (Months)';
        }
        field(50120; "Base Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Base Unit of Measure';

        }

        field(50121; "Unit Sq. Feet"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Size';
        }

        field(50122; "Grace Period"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Grace Period (Days)';
        }

        field(50123; "Grace Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Grace Start Date';
            trigger OnValidate()
            begin
                CalculateGracePeriod();
            end;
        }

        field(50124; "Grace End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Grace End Date';
            trigger OnValidate()
            begin
                CalculateGracePeriod();
            end;
        }

        field(50125; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
            TableRelation = Customer."No.";
        }

        field(50126; "Property ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property ID';
            TableRelation = "Property Registration"."Property ID";
        }

        field(50127; "Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Single Unit ID';
            TableRelation = "Item"."No."
                where("Property ID" = field("Property ID"));
        }

        field(50128; "Emirates ID"; Code[25])
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirates ID';
        }

        field(50129; "Contact Number"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contact Number';
        }
        field(50130; "Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email Address';
        }

        field(50131; "Payment Frequency"; Option)
        {
            OptionMembers = " ",Monthly,Quarterly,"Half-Yearly",Yearly;
            DataClassification = ToBeClassified;
        }
        field(50132; "Payment Method"; Text[100])
        {

            DataClassification = ToBeClassified;
        }

        field(50133; "Update Contract Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Update Contract Status';
            OptionMembers = " ","Initiate Activation Process","Initiate Suspension Process","Initiate Termination Process","Initiate Under Suspension-Unit Released";


        }
        field(50134; "Tenant Contract Status"; Option)
        {
            Editable = true;
            DataClassification = ToBeClassified;
            Caption = 'Tenant Contract Status';
            OptionMembers = " ",Active,Terminated,Suspended,Inactive,"Under Suspension-Unit Released","Active-Contract Renewed","Contract Renewed";

            trigger OnValidate()
            var
                ItemRec: Record Item;
                MergeUnitRec: Record "Merged Units";
                emailrec: Codeunit "Send Contract Email";

            begin
                // Handle logic for Unit ID
                if "Unit ID" <> '' then
                    if ItemRec.Get("Unit ID") then begin
                        case "Tenant Contract Status" of
                            "Tenant Contract Status"::Active,
                            "Tenant Contract Status"::Suspended:
                                ItemRec."Unit Status" := ItemRec."Unit Status"::Occupied;

                            "Tenant Contract Status"::Terminated,
                            "Tenant Contract Status"::"Under Suspension-Unit Released":
                                ItemRec."Unit Status" := ItemRec."Unit Status"::Free;
                        end;
                        ItemRec.Modify();
                    end;

                if "Merge Unit ID" <> '' then
                    if MergeUnitRec.Get("Merge Unit ID") then begin
                        case "Tenant Contract Status" of
                            "Tenant Contract Status"::Terminated:
                                MergeUnitRec."Status" := MergeUnitRec."Status"::Free;
                            "Tenant Contract Status"::"Under Suspension-Unit Released":
                                MergeUnitRec."Status" := MergeUnitRec."Status"::Free;
                            "Tenant Contract Status"::Active:
                                MergeUnitRec."Status" := MergeUnitRec."Status"::Occupied;
                            "Tenant Contract Status"::Suspended:
                                MergeUnitRec."Status" := MergeUnitRec."Status"::Occupied;

                        end;

                        // Additional logic for Spliting Status in Merge Units table
                        case "Tenant Contract Status" of
                            "Tenant Contract Status"::Active:
                                MergeUnitRec."Spliting Status" := MergeUnitRec."Spliting Status"::Merge;
                            "Tenant Contract Status"::Terminated:
                                MergeUnitRec."Spliting Status" := MergeUnitRec."Spliting Status"::Merge;
                            "Tenant Contract Status"::Suspended:
                                MergeUnitRec."Spliting Status" := MergeUnitRec."Spliting Status"::Merge;
                            "Tenant Contract Status"::"Under Suspension-Unit Released":
                                MergeUnitRec."Spliting Status" := MergeUnitRec."Spliting Status"::Merge;

                        end;

                        MergeUnitRec.Modify();

                        // Update all associated Unit IDs in the Item table
                        if MergeUnitRec."Unit ID" <> '' then begin
                            ItemRec.SetRange("Merged Unit ID", MergeUnitRec."Merged Unit ID");
                            if ItemRec.FindSet() then
                                repeat
                                    case "Tenant Contract Status" of
                                        "Tenant Contract Status"::Active,
                                          "Tenant Contract Status"::Suspended:
                                            ItemRec."Unit Status" := ItemRec."Unit Status"::Occupied;

                                        "Tenant Contract Status"::Terminated,
                                            "Tenant Contract Status"::"Under Suspension-Unit Released":
                                            ItemRec."Unit Status" := ItemRec."Unit Status"::Free;
                                    end;

                                    ItemRec.Modify();
                                until ItemRec.Next() = 0;
                        end;
                    end;


                if Rec."Tenant Contract Status" = Rec."Tenant Contract Status"::Active then
                    emailrec.SendEmail(Rec);




            end;
        }

        field(50135; "UnitID"; code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Uniq Unit ID';

        }

        field(50136; "Created By"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Created By';
        }
        field(50137; "Handover is Completed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Handover is Completed';
        }

        field(50152; "Handover of PDC"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Handover of PDC';
        }

        field(50153; "Signed TC Document"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Signed TC Document';
        }

        field(50154; "Handover Unit"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Handover Unit';
        }

        field(50138; "Merge Unit ID"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Merge Unit ID';
        }

        field(50139; "Rent Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Annual Rent Amount ';
        }


        field(50140; "Tenant_License No."; Code[20])
        {
            Caption = 'Tenant Trade License No.';
            DataClassification = ToBeClassified;
        }

        field(50141; "Tenant_Licensing Authority"; Text[100])
        {
            Caption = 'Tenant_Licensing Authority';
            DataClassification = ToBeClassified;
        }

        field(50142; "Security Deposit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50143; "Unit Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50144; "Makani Number"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(50145; "Emirate"; Enum Emirates)
        {
            DataClassification = ToBeClassified;

        }
        field(50146; "Community"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50147; "DEWA Number"; Text[50])
        {
            Caption = 'DEWA Number';
            DataClassification = ToBeClassified;
        }
        field(50148; "Property Size"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Size';
        }

        field(50149; "ID"; Integer)
        {
            Caption = 'Suspended Reason ID';
            DataClassification = ToBeClassified;

        }
        field(50150; "Suspended Reason list"; Text[250])
        {
            Caption = 'Suspended Reason list';
            DataClassification = ToBeClassified;

        }
        field(50151; "No of Installments"; Integer)
        {
            Caption = 'No of Installments';
            Editable = false;
        }

        field(50155; "Upload Document"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Upload Document';
        }
        field(50156; "view Document"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'view Document';
        }

        field(50157; "document URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Logo URL';
        }

        field(50158; "Renewal Contract Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal Contract Status';
            OptionMembers = "N/A","Notify Tenant For Renewal";
        }

        field(50159; "Contract Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Type';
            OptionMembers = " ","New Contract","Renewal Contract";

            trigger OnValidate()
            begin
                rec.Insert();
            end;
        }



        field(50160; "Renewal Proposal ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal Proposal ID';
            TableRelation = "Contract Renewal".Id WHERE("Final Status" = CONST(Approved));

            trigger OnValidate()
            var
                LeaseProposalRec: Record "Contract Renewal";
                TenantContractRec: Record "Tenancy Contract";
            begin
                TenantContractRec.Reset();
                TenantContractRec.SetRange("Proposal ID", "Proposal ID");

                LeaseProposalRec.SetRange(ID, "Renewal Proposal ID");
                if LeaseProposalRec.FindFirst() then begin
                    "Tenant ID" := LeaseProposalRec."Tenant ID";
                    "Tenant_License No." := LeaseProposalRec."License No.";
                    "Tenant_Licensing Authority" := LeaseProposalRec."Licensing Authority";
                    "Customer Name" := LeaseProposalRec."Tenant Full Name";
                    "Email Address" := LeaseProposalRec."Email Address";
                    "Emirates ID" := LeaseProposalRec."Emirates ID";
                    "Property ID" := LeaseProposalRec."Property ID";
                    "Payment Frequency" := LeaseProposalRec."Payment Frequency";
                    "Payment Method" := LeaseProposalRec."Payment Method";
                    "Base Unit of Measure" := LeaseProposalRec."Base Unit of Measure";
                    "Contact Number" := LeaseProposalRec."Contact Number";
                    "Unit ID" := LeaseProposalRec."Unit ID";
                    "Merge Unit ID" := LeaseProposalRec."Merge Unit ID";
                    "Unit Name" := LeaseProposalRec."Unit Name";
                    "Unit Sq. Feet" := LeaseProposalRec."Unit Sq. Feet";
                    "Annual Rent Amount" := LeaseProposalRec."Rent Amount";
                    "UnitID" := LeaseProposalRec."UnitID";
                    "Property Classification" := LeaseProposalRec."Property Classification";
                    "Property Type" := LeaseProposalRec."Property Type";
                    "Property Name" := LeaseProposalRec."Property Name";
                    "Contract Start Date" := LeaseProposalRec."Contract Start Date";
                    "Contract End Date" := LeaseProposalRec."Contract End Date";
                    "Contract Tenor" := LeaseProposalRec."Contract Tenor";
                    "Annual Rent Amount" := LeaseProposalRec."Contract Amount";
                    "Rent Amount" := LeaseProposalRec."Rent Amount";
                    "Security Deposit Amount" := LeaseProposalRec."Security Deposit Amount";
                    "Unit Number" := LeaseProposalRec."Unit Number";
                    "Makani Number" := LeaseProposalRec."Makani Number";
                    Emirate := LeaseProposalRec.Emirate;
                    Community := LeaseProposalRec.Community;
                    "DEWA Number" := LeaseProposalRec."DEWA Number";
                    "Property Size" := LeaseProposalRec."Property Size";
                    "No of Installments" := LeaseProposalRec."No of Installments";

                    "Single Rent Calculation" := LeaseProposalRec."Single Rent Calculation";
                    "Merge Rent Calculation" := LeaseProposalRec."Merge Rent Calculation";
                    "Praposal Type Selected" := LeaseProposalRec."Praposal Type Selected";

                    TenancyContractSubpage2();
                    rentdatafetched();
                    renewalbrokerdata();
                end else begin
                    // Clear fields if no record is found
                    "Tenant ID" := '';
                    "Customer Name" := '';
                    "Property ID" := '';
                    "Unit ID" := '';
                    "Merge Unit ID" := '';
                    "Unit Name" := '';
                    "Unit Sq. Feet" := 0;
                    "Annual Rent Amount" := 0;
                    "Property Name" := '';
                    "Emirates ID" := '';
                    "Email Address" := '';
                    "Property Classification" := '';
                    "Property Type" := '';
                    "Property Name" := '';
                    "Unit Number" := '';
                end;
            end;
        }

        field(50161; "Yes/No"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Yes/No';
        }

        field(50162; "Praposal Type Selected"; Option)
        {
            OptionMembers = " ","Single Unit","Merge Unit";
            DataClassification = ToBeClassified;

        }
        field(50163; "Unit Address"; Text[100])
        {
            DataClassification = ToBeClassified;

        }

        field(50164; "Usage Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Usage Type';

            NotBlank = true;
        }

        field(50165; "Unit Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Type';
        }

        field(50166; "Single Unit Name"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Single Unit Names';
        }

        field(50167; "Market Rate per Sq. Ft."; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Market Rate per Sq. Ft. ';
        }

        field(50168; "Facilities/Amenities"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50169; "Balance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50170; "Single Rent Calculation"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Single Unit Rent Calculation Type';
            Editable = false;
            OptionMembers = " ","Single Unit with square feet rate","Single Unit with lumpsum square feet rate";

        }



        field(50171; "Merge Rent Calculation"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Merge Unit Rent Calculation Type';
            OptionMembers = " ","Merged Unit with same square feet","Merged Unit with differential square feet rate","Merged Unit with lumpsum annual amount";
        }

        field(50172; "Update Data"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rent Calculation';
            InitValue = 'Update Data';

        }

        field(50178; "Final Calculation"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Calculation';
            InitValue = 'Final Calculation';
            Editable = false;


        }

        field(50173; "Contract VAT %"; Option)
        {
            OptionMembers = "0%","5%";
            Editable = false;

        }

        field(50174; "Contract VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50175; "Contract Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50176; "Security Amount Received"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50177; "Security Balanced Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50179; "Termination Of Contract"; Option)
        {
            OptionMembers = " ","Regular Termination","Early Termination","Suspension to Termination";
            Editable = true;
        }
        field(50180; "Termination Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50181; "Unpaid Rent Due"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50182; "Penalty Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50183; "Damage Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50184; "Service Charges Due"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50185; "Final Refundable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50186; "Approval Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50187; "Approval Stauts"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
            // OptionMembers = " ","Pending","Approved","Rejected";
        }
        field(50188; "Approved By"; Text[100])
        {
            DataClassification = ToBeClassified;

        }

        field(50189; "Final Settlement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50191; "Rent Calculation Link"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rent Calculation Link';
            Editable = false;
        }

        field(50192; "Link"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Calculation Link';
            Editable = false;

        }

        field(50193; "Renewal Notification to Tenant"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal Notification to Tenant';
            Editable = true;

        }
        field(50194; "Tenant Loyalty Check Reminder"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Loyalty Check Reminder';
            Editable = true;

        }
        field(50195; "Payment Reminder"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Reminder';
            Editable = false;

        }
        field(50196; "Previous Status"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Previous Status';
            Editable = true;

        }

        field(50197; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor ID';
            // Editable = false;
        }
        field(50198; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Name';
            //  Editable = false;
        }
        field(50199; "Percentage"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage';
        }
        field(50200; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(50202; "Calculation Method"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Calculation Method';
            TableRelation = "Calculation Type"."Calculation Type";
        }

        field(50203; "Percentage Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage Type';
            OptionMembers = " ","Fixed","Variable";
        }
        field(50204; "Base Amount Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Base Amount Type';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
        }
        field(50205; "Frequency Of Payment"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Frequency Of Payment';
            OptionMembers = " ","Monthly","Quaterly","Half Yearly","Yearly";
        }

        field(50206; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }
        field(50207; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';

        }
        field(50208; "Contract Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Status';
            OptionMembers = " ","Active","Terminate";
        }
        field(50209; "Owner ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner ID';
            Editable = false;
            TableRelation = "Owner Profile"."Owner ID";
        }
        field(50210; "Lessor's Nationality"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nationality';
        }
        field(50211; "Lessor's Address"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Address';
        }
    }

    keys
    {
        key(PK; "Contract ID")
        {
            Clustered = false;
        }

        key(PK1; SystemId)
        {
            Clustered = false;
        }

        key(PK2; "Proposal ID", "Renewal Proposal ID")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
        fieldgroup(DropDown; "Contract ID", "Proposal ID", "Renewal Proposal ID")
        {

        }
    }




    procedure TenancyContractSubpage()
    var
        RevenueSubpage: Record "Revenue Item Subpage";
        TenancyContractGrid: Record "Tenancy Contract Subpage";

    begin
        if Rec."Contract Type" = Rec."Contract Type"::"New Contract"
        then begin



            TenancyContractGrid.SetRange(ContractID, Rec."Contract ID");
            if TenancyContractGrid.FindSet() then
                TenancyContractGrid.DeleteAll();
            RevenueSubpage.SetRange("ProposalID", Rec."Proposal ID");
            if RevenueSubpage.FindSet() then
                repeat
                    TenancyContractGrid.Init();
                    TenancyContractGrid.ProposalID := RevenueSubpage.ProposalID;
                    TenancyContractGrid."ContractID" := Rec."Contract ID";
                    TenancyContractGrid."TenantID" := rec."Tenant Id";
                    TenancyContractGrid."Secondary Item Type" := RevenueSubpage."Secondary Item Type";
                    TenancyContractGrid.Amount := RevenueSubpage.Amount;
                    TenancyContractGrid."VAT Amount" := RevenueSubpage."VAT Amount";
                    TenancyContractGrid."VAT %" := RevenueSubpage."VAT %";
                    TenancyContractGrid."Amount Including VAT" := RevenueSubpage."Amount Including VAT";
                    TenancyContractGrid."Start Date" := RevenueSubpage."Start Date";
                    TenancyContractGrid."End Date" := RevenueSubpage."End Date";
                    TenancyContractGrid."Payment Type" := RevenueSubpage."Payment Type";

                    TenancyContractGrid.Insert();
                    Clear(TenancyContractGrid);
                until RevenueSubpage.Next() = 0;

        end;
    end;

    procedure TenancyContractSubpage2()
    var
        RevenueSubpage2: Record "Contract Renewal Subpage";
        TenancyContractGrid1: Record "Tenancy Contract Subpage";

    begin
        if Rec."Contract Type" = Rec."Contract Type"::"Renewal Contract" then begin


            TenancyContractGrid1.SetRange(ContractID, Rec."Contract ID");
            if TenancyContractGrid1.FindSet() then
                TenancyContractGrid1.DeleteAll();
            RevenueSubpage2.SetRange(ID, "Renewal Proposal ID");
            if RevenueSubpage2.FindSet() then
                repeat
                    TenancyContractGrid1.Init();
                    TenancyContractGrid1."Contract Renewal ID" := RevenueSubpage2.Id;
                    TenancyContractGrid1."ContractID" := Rec."Contract ID";
                    TenancyContractGrid1."TenantID" := rec."Tenant Id";
                    TenancyContractGrid1."Secondary Item Type" := RevenueSubpage2."Secondary Item Type";
                    TenancyContractGrid1.Amount := RevenueSubpage2.Amount;
                    TenancyContractGrid1."VAT Amount" := RevenueSubpage2."VAT Amount";
                    TenancyContractGrid1."VAT %" := RevenueSubpage2."VAT %";
                    TenancyContractGrid1."Amount Including VAT" := RevenueSubpage2."Amount Including VAT";
                    TenancyContractGrid1."Start Date" := RevenueSubpage2."Start Date";
                    TenancyContractGrid1."End Date" := RevenueSubpage2."End Date";
                    TenancyContractGrid1."Payment Type" := RevenueSubpage2."Payment Type";
                    TenancyContractGrid1.Insert();
                    Clear(TenancyContractGrid1);
                until RevenueSubpage2.Next() = 0;
        end;

    end;


    procedure rentdatafetch()
    var
        CRSingleUnitRent: Record "Single Unit Rent SubPage";
        TCSingleUnitRent: Record "TC Single Unit Rent SubPage";
        TCLumpsumUnitRate: Record "TC Single LumAnnualAmnt SP";
        CRLumpsumUnitRent: Record "Single Lum_AnnualAmnt SubPage";
        TCMergeUnitRate: Record "TC Merge SameSqure SubPage";
        CRMergeUnitRent: Record "Merge SameSqure SubPage";
        TCMergediffUnitRate: Record "TC Merge DifferentSq SubPage";
        CRMergediffUnitRent: Record "Merge DifferentSqure SubPage";
        TCMergeLumpsumUnitRate: Record "TC Merge LumAnnualAmount SP";
        CRMergeLumpsumUnitRent: Record "Merge Lum_AnnualAmount SubPage";
        TCPerDayRevenewUnitRate: Record "TC Per Day Rent for Revenue";
        CRPerDayRevenewUnitRate: Record "Per Day Rent for Revenue";
        LineNoCounter: Integer;
    begin

        if "Single Rent Calculation" = "Single Rent Calculation"::"Single Unit with square feet rate" then begin

            // ✅ **Delete Existing Records Before Insert**
            TCSingleUnitRent.Reset();
            TCSingleUnitRent.SetRange("ID", "Proposal ID");
            if TCSingleUnitRent.FindSet() then
                TCSingleUnitRent.DeleteAll();
            CRSingleUnitRent.Reset();
            CRSingleUnitRent.SetRange("Proposal ID", "Proposal ID");
            if CRSingleUnitRent.FindSet() then begin
                LineNoCounter := 1;
                repeat
                    TCSingleUnitRent.Init();
                    TCSingleUnitRent."ID" := "Proposal ID";
                    TCSingleUnitRent."Contract Id" := Rec."Contract ID";
                    TCSingleUnitRent."Line No." := LineNoCounter;
                    TCSingleUnitRent."Unit ID" := CRSingleUnitRent."Unit ID";
                    TCSingleUnitRent.Year := CRSingleUnitRent.Year;
                    TCSingleUnitRent."Start Date" := CRSingleUnitRent."Start Date";
                    TCSingleUnitRent."End Date" := CRSingleUnitRent."End Date";
                    TCSingleUnitRent."Number of Days" := CRSingleUnitRent."Number of Days";
                    TCSingleUnitRent."Unit Sq Ft" := CRSingleUnitRent."Unit Sq Ft";
                    TCSingleUnitRent."Rate per Sq.Ft" := CRSingleUnitRent."Rate per Sq.Ft";
                    TCSingleUnitRent."Rent Increase %" := CRSingleUnitRent."Rent Increase %";
                    TCSingleUnitRent."Annual Amount" := CRSingleUnitRent."Annual Amount";
                    TCSingleUnitRent."Round off" := CRSingleUnitRent."Round off";
                    TCSingleUnitRent."Final Annual Amount" := CRSingleUnitRent."Final Annual Amount";
                    TCSingleUnitRent."Per Day Rent" := CRSingleUnitRent."Per Day Rent";
                    TCSingleUnitRent.Insert();

                    LineNoCounter += 1; // Increment line number
                until CRSingleUnitRent.Next() = 0;
                // end else begin
                //     Message('No existing records found for Proposal ID: %1 in Single Unit Rent SubPage.', "Proposal ID");
            end;
        end
        else
            if "Single Rent Calculation" = "Single Rent Calculation"::"Single Unit with lumpsum square feet rate" then begin
                TCLumpsumUnitRate.Reset();
                TCLumpsumUnitRate.SetRange("ID", "Proposal ID");
                if TCLumpsumUnitRate.FindSet() then
                    TCLumpsumUnitRate.DeleteAll();
                CRLumpsumUnitRent.Reset();
                CRLumpsumUnitRent.SetRange("Proposal ID", "Proposal ID");
                if CRLumpsumUnitRent.FindSet() then begin
                    LineNoCounter := 1;
                    repeat
                        TCLumpsumUnitRate.Init();

                        TCLumpsumUnitRate."ID" := CRLumpsumUnitRent."Proposal ID";
                        TCLumpsumUnitRate."Contract Id" := Rec."Contract ID";
                        TCLumpsumUnitRate."SL_Line No." := LineNoCounter; // Ensure unique line number
                        TCLumpsumUnitRate."SL_Unit ID" := CRLumpsumUnitRent."SL_Unit ID";
                        TCLumpsumUnitRate.SL_Year := CRLumpsumUnitRent.SL_Year;
                        TCLumpsumUnitRate."SL_Start Date" := CRLumpsumUnitRent."SL_Start Date";
                        TCLumpsumUnitRate."SL_End Date" := CRLumpsumUnitRent."SL_End Date";
                        TCLumpsumUnitRate."SL_Number of Days" := CRLumpsumUnitRent."SL_Number of Days";
                        TCLumpsumUnitRate."SL_Unit Sq Ft" := CRLumpsumUnitRent."SL_Unit Sq Ft";
                        TCLumpsumUnitRate."SL_Rate per Sq.Ft" := CRLumpsumUnitRent."SL_Rate per Sq.Ft";
                        TCLumpsumUnitRate."SL_Rent Increase %" := CRLumpsumUnitRent."SL_Rent Increase %";
                        TCLumpsumUnitRate."SL_Annual Amount" := CRLumpsumUnitRent."SL_Annual Amount";
                        TCLumpsumUnitRate."SL_Round off" := CRLumpsumUnitRent."SL_Round off";
                        TCLumpsumUnitRate."SL_Final Annual Amount" := CRLumpsumUnitRent."SL_Final Annual Amount";
                        TCLumpsumUnitRate."SL_Per Day Rent" := CRLumpsumUnitRent."SL_Per Day Rent";
                        TCLumpsumUnitRate.TotalFinalAmount := CRSingleUnitRent.TotalFinalAmount;
                        TCLumpsumUnitRate.TotalAnnualAmount := CRSingleUnitRent.TotalAnnualAmount;
                        TCLumpsumUnitRate.TotalRoundOff := CRSingleUnitRent.TotalRoundOff;
                        TCLumpsumUnitRate.TotalFirstAnnualAmount := CRSingleUnitRent.TotalFirstAnnualAmount;
                        TCLumpsumUnitRate.Insert();
                        LineNoCounter += 1;
                    until CRLumpsumUnitRent.Next() = 0;
                end;
            end

            else
                if "Merge Rent Calculation" = "Merge Rent Calculation"::"Merged Unit with same square feet" then begin
                    TCMergeUnitRate.Reset();
                    TCMergeUnitRate.SetRange("ID", "Proposal ID");
                    if TCMergeUnitRate.FindSet() then
                        TCMergeUnitRate.DeleteAll();

                    CRMergeUnitRent.Reset();
                    CRMergeUnitRent.SetRange("Proposal ID", "Proposal ID");
                    if CRMergeUnitRent.FindSet() then begin
                        LineNoCounter := 1;
                        repeat
                            TCMergeUnitRate.Init();
                            TCMergeUnitRate."ID" := CRMergeUnitRent."Proposal ID";
                            TCMergeUnitRate."Contract Id" := Rec."Contract ID";
                            TCMergeUnitRate."MS_Line No." := LineNoCounter; // Ensure unique line number
                            TCMergeUnitRate."MS_Merged Unit ID" := CRMergeUnitRent."MS_Merged Unit ID";
                            TCMergeUnitRate.MS_Year := CRMergeUnitRent.MS_Year;
                            TCMergeUnitRate."MS_Start Date" := CRMergeUnitRent."MS_Start Date";
                            TCMergeUnitRate."MS_End Date" := CRMergeUnitRent."MS_End Date";
                            TCMergeUnitRate."MS_Number of Days" := CRMergeUnitRent."MS_Number of Days";
                            TCMergeUnitRate."MS_Unit Sq Ft" := CRMergeUnitRent."MS_Unit Sq Ft";
                            TCMergeUnitRate."MS_Rate per Sq.Ft" := CRMergeUnitRent."MS_Rate per Sq.Ft";
                            TCMergeUnitRate."MS_Rent Increase %" := CRMergeUnitRent."MS_Rent Increase %";
                            TCMergeUnitRate."MS_Annual Amount" := CRMergeUnitRent."MS_Annual Amount";
                            TCMergeUnitRate."MS_Round off" := CRMergeUnitRent."MS_Round off";
                            TCMergeUnitRate."MS_Final Annual Amount" := CRMergeUnitRent."MS_Final Annual Amount";
                            TCMergeUnitRate."MS_Per Day Rent" := CRMergeUnitRent."MS_Per Day Rent";
                            TCMergeUnitRate.TotalFinalAmount := CRMergeUnitRent.TotalFinalAmount;
                            TCMergeUnitRate.TotalAnnualAmount := CRMergeUnitRent.TotalAnnualAmount;
                            TCMergeUnitRate.TotalRoundOff := CRMergeUnitRent.TotalRoundOff;
                            TCMergeUnitRate.TotalFirstAnnualAmount := CRMergeUnitRent.TotalFirstAnnualAmount;
                            TCMergeUnitRate.Insert();
                            LineNoCounter += 1;
                        until CRMergeUnitRent.Next() = 0;
                    end;
                end
                else
                    if "Merge Rent Calculation" = "Merge Rent Calculation"::"Merged Unit with differential square feet rate" then begin
                        TCMergediffUnitRate.Reset();
                        TCMergediffUnitRate.SetRange("ID", "Proposal ID");
                        if TCMergediffUnitRate.FindSet() then
                            TCMergediffUnitRate.DeleteAll();
                        CRMergediffUnitRent.Reset();
                        CRMergediffUnitRent.SetRange("Proposal ID", "Proposal ID");
                        if CRMergediffUnitRent.FindSet() then begin
                            LineNoCounter := 1;
                            repeat
                                TCMergediffUnitRate.Init();
                                TCMergediffUnitRate."ID" := CRMergediffUnitRent."Proposal ID";
                                TCMergediffUnitRate."Contract Id" := Rec."Contract ID";
                                TCMergediffUnitRate."MD_Line No." := LineNoCounter; // Ensure unique line number
                                TCMergediffUnitRate."MD_Merged Unit ID" := CRMergediffUnitRent."MD_Merged Unit ID";
                                TCMergediffUnitRate."MD_Unit ID" := CRMergediffUnitRent."MD_Unit ID";
                                TCMergediffUnitRate.MD_Year := CRMergediffUnitRent.MD_Year;
                                TCMergediffUnitRate."MD_Start Date" := CRMergediffUnitRent."MD_Start Date";
                                TCMergediffUnitRate."MD_End Date" := CRMergediffUnitRent."MD_End Date";
                                TCMergediffUnitRate."MD_Number of Days" := CRMergediffUnitRent."MD_Number of Days";
                                TCMergediffUnitRate."MD_Unit Sq Ft" := CRMergediffUnitRent."MD_Unit Sq Ft";
                                TCMergediffUnitRate."MD_Rate per Sq.Ft" := CRMergediffUnitRent."MD_Rate per Sq.Ft";
                                TCMergediffUnitRate."MD_Rent Increase %" := CRMergediffUnitRent."MD_Rent Increase %";
                                TCMergediffUnitRate."MD_Annual Amount" := CRMergediffUnitRent."MD_Annual Amount";
                                TCMergediffUnitRate."MD_Round off" := CRMergediffUnitRent."MD_Round off";
                                TCMergediffUnitRate."MD_Final Annual Amount" := CRMergediffUnitRent."MD_Final Annual Amount";
                                TCMergediffUnitRate."MD_Per Day Rent" := CRMergediffUnitRent."MD_Per Day Rent";
                                TCMergediffUnitRate.TotalFinalAmount := CRMergediffUnitRent.TotalFinalAmount;
                                TCMergediffUnitRate.TotalAnnualAmount := CRMergediffUnitRent.TotalAnnualAmount;
                                TCMergediffUnitRate.TotalRoundOff := CRMergediffUnitRent.TotalRoundOff;
                                TCMergediffUnitRate.TotalFirstAnnualAmount := CRMergediffUnitRent.TotalFirstAnnualAmount;
                                TCMergediffUnitRate.Insert();
                                LineNoCounter += 1;
                            until CRMergediffUnitRent.Next() = 0;
                        end;
                    end

                    else
                        if "Merge Rent Calculation" = "Merge Rent Calculation"::"Merged Unit with lumpsum annual amount" then begin
                            TCMergeLumpsumUnitRate.Reset();
                            TCMergeLumpsumUnitRate.SetRange("ID", "Proposal ID");

                            if TCMergeLumpsumUnitRate.FindSet() then
                                TCMergeLumpsumUnitRate.DeleteAll();

                            CRMergeLumpsumUnitRent.Reset();
                            CRMergeLumpsumUnitRent.SetRange("Proposal ID", "Proposal ID");

                            if CRMergeLumpsumUnitRent.FindSet() then begin
                                LineNoCounter := 1;
                                repeat
                                    TCMergeLumpsumUnitRate.Init();
                                    TCMergeLumpsumUnitRate."ID" := CRMergeLumpsumUnitRent."Proposal ID";
                                    TCMergeLumpsumUnitRate."Contract Id" := Rec."Contract ID";
                                    TCMergeLumpsumUnitRate."ML_Line No." := LineNoCounter; // Ensure unique line number
                                    TCMergeLumpsumUnitRate."ML_Merged Unit ID" := CRMergeLumpsumUnitRent."ML_Merged Unit ID";
                                    TCMergeLumpsumUnitRate.ML_Year := CRMergeLumpsumUnitRent.ML_Year;
                                    TCMergeLumpsumUnitRate."ML_Start Date" := CRMergeLumpsumUnitRent."ML_Start Date";
                                    TCMergeLumpsumUnitRate."ML_End Date" := CRMergeLumpsumUnitRent."ML_End Date";
                                    TCMergeLumpsumUnitRate."ML_Number of Days" := CRMergeLumpsumUnitRent."ML_Number of Days";
                                    TCMergeLumpsumUnitRate."ML_Unit Sq Ft" := CRMergeLumpsumUnitRent."ML_Unit Sq Ft";
                                    TCMergeLumpsumUnitRate."ML_Rate per Sq.Ft" := CRMergeLumpsumUnitRent."ML_Rate per Sq.Ft";
                                    TCMergeLumpsumUnitRate."ML_Rent Increase %" := CRMergeLumpsumUnitRent."ML_Rent Increase %";
                                    TCMergeLumpsumUnitRate."ML_Annual Amount" := CRMergeLumpsumUnitRent."ML_Annual Amount";
                                    TCMergeLumpsumUnitRate."ML_Round off" := CRMergeLumpsumUnitRent."ML_Round off";
                                    TCMergeLumpsumUnitRate."ML_Final Annual Amount" := CRMergeLumpsumUnitRent."ML_Final Annual Amount";
                                    TCMergeLumpsumUnitRate."ML_Per Day Rent" := CRMergeLumpsumUnitRent."ML_Per Day Rent";
                                    TCMergeLumpsumUnitRate.TotalFinalAmount := CRMergeLumpsumUnitRent.TotalFinalAmount;
                                    TCMergeLumpsumUnitRate.TotalAnnualAmount := CRMergeLumpsumUnitRent.TotalAnnualAmount;
                                    TCMergeLumpsumUnitRate.TotalRoundOff := CRMergeLumpsumUnitRent.TotalRoundOff;
                                    TCMergeLumpsumUnitRate.TotalFirstAnnualAmount := CRMergeLumpsumUnitRent.TotalFirstAnnualAmount;
                                    TCMergeLumpsumUnitRate.Insert();
                                    LineNoCounter += 1;
                                until CRMergeLumpsumUnitRent.Next() = 0;
                            end;
                        end;
        TCPerDayRevenewUnitRate.Reset();
        TCPerDayRevenewUnitRate.SetRange("Proposal Id", "Proposal ID");

        if TCPerDayRevenewUnitRate.FindSet() then
            TCPerDayRevenewUnitRate.DeleteAll();
        CRPerDayRevenewUnitRate.Reset();
        CRPerDayRevenewUnitRate.SetRange("Proposal Id", "Proposal ID");

        if CRPerDayRevenewUnitRate.FindSet() then begin
            LineNoCounter := 1;
            repeat
                TCPerDayRevenewUnitRate.Init();
                TCPerDayRevenewUnitRate."Proposal Id" := CRPerDayRevenewUnitRate."Proposal Id";
                TCPerDayRevenewUnitRate."Merge Unit Id" := CRPerDayRevenewUnitRate."Merge Unit Id";
                TCPerDayRevenewUnitRate."Year" := CRPerDayRevenewUnitRate."Year";
                TCPerDayRevenewUnitRate."Unit ID" := CRPerDayRevenewUnitRate."Unit ID";
                TCPerDayRevenewUnitRate."Sq.Ft" := CRPerDayRevenewUnitRate."Sq.Ft";
                TCPerDayRevenewUnitRate."Per Day Rent Per Unit" := CRPerDayRevenewUnitRate."Per Day Rent Per Unit";

                TCPerDayRevenewUnitRate.Insert();
                Clear(TCPerDayRevenewUnitRate);
                LineNoCounter += 1;
            until CRPerDayRevenewUnitRate.Next() = 0;
        end
    end;

    procedure rentdatafetched()
    var
        CRSingleUnitRent: Record "CR Single Unit Rent SubPage";
        TCSingleUnitRent: Record "TC Single Unit Rent SubPage";
        TCLumpsumUnitRate: Record "TC Single LumAnnualAmnt SP";
        CRLumpsumUnitRent: Record "CR Single LumAnnualAmnt SP";
        TCMergeUnitRate: Record "TC Merge SameSqure SubPage";
        CRMergeUnitRent: Record "CR Merge SameSqure SubPage";
        TCMergediffUnitRate: Record "TC Merge DifferentSq SubPage";
        CRMergediffUnitRent: Record "CR Merge DifferentSq SubPage";
        TCMergeLumpsumUnitRate: Record "TC Merge LumAnnualAmount SP";
        CRMergeLumpsumUnitRent: Record "CR Merge LumAnnualAmount SP";
        TCPerDayRevenewUnitRate: Record "TC Per Day Rent for Revenue";
        CRPerDayRevenewUnitRate: Record "CR Per Day Rent for Revenue";
        LineNoCounter: Integer;
    begin
        if "Single Rent Calculation" = "Single Rent Calculation"::"Single Unit with square feet rate" then begin
            TCSingleUnitRent.Reset();
            TCSingleUnitRent.SetRange("ID", "Renewal Proposal ID");
            if TCSingleUnitRent.FindSet() then
                TCSingleUnitRent.DeleteAll();
            CRSingleUnitRent.Reset();
            CRSingleUnitRent.SetRange("ID", "Renewal Proposal ID");

            if CRSingleUnitRent.FindSet() then begin
                LineNoCounter := 1;
                repeat
                    TCSingleUnitRent.Init();
                    TCSingleUnitRent."ID" := CRSingleUnitRent."ID";
                    TCSingleUnitRent."Contract Id" := Rec."Contract Id";
                    TCSingleUnitRent."Line No." := LineNoCounter;
                    TCSingleUnitRent."Unit ID" := CRSingleUnitRent."Unit ID";
                    TCSingleUnitRent.Year := CRSingleUnitRent.Year;
                    TCSingleUnitRent."Start Date" := CRSingleUnitRent."Start Date";
                    TCSingleUnitRent."End Date" := CRSingleUnitRent."End Date";
                    TCSingleUnitRent."Number of Days" := CRSingleUnitRent."Number of Days";
                    TCSingleUnitRent."Unit Sq Ft" := CRSingleUnitRent."Unit Sq Ft";
                    TCSingleUnitRent."Rate per Sq.Ft" := CRSingleUnitRent."Rate per Sq.Ft";
                    TCSingleUnitRent."Rent Increase %" := CRSingleUnitRent."Rent Increase %";
                    TCSingleUnitRent."Annual Amount" := CRSingleUnitRent."Annual Amount";
                    TCSingleUnitRent."Round off" := CRSingleUnitRent."Round off";
                    TCSingleUnitRent."Final Annual Amount" := CRSingleUnitRent."Final Annual Amount";
                    TCSingleUnitRent."Per Day Rent" := CRSingleUnitRent."Per Day Rent";
                    TCSingleUnitRent.TotalFinalAmount := CRSingleUnitRent.TotalFinalAmount;
                    TCSingleUnitRent.TotalAnnualAmount := CRSingleUnitRent.TotalAnnualAmount;
                    TCSingleUnitRent.TotalRoundOff := CRSingleUnitRent.TotalRoundOff;
                    TCSingleUnitRent.TotalFirstAnnualAmount := CRSingleUnitRent.TotalFirstAnnualAmount;
                    TCSingleUnitRent.Insert();


                    LineNoCounter += 1;
                until CRSingleUnitRent.Next() = 0;
            end;

        end

        else
            if "Single Rent Calculation" = "Single Rent Calculation"::"Single Unit with lumpsum square feet rate" then begin
                // ✅ Delete Existing Records Before Insert in TC Single LumAnnualAmnt SP
                TCLumpsumUnitRate.Reset();
                TCLumpsumUnitRate.SetRange("ID", "Renewal Proposal ID");
                if TCLumpsumUnitRate.FindSet() then
                    TCLumpsumUnitRate.DeleteAll();
                CRLumpsumUnitRent.Reset();
                CRLumpsumUnitRent.SetRange("ID", "Renewal Proposal ID");
                if CRLumpsumUnitRent.FindSet() then begin
                    LineNoCounter := 1; // Start line numbering from 1
                    repeat
                        TCLumpsumUnitRate.Init();

                        TCLumpsumUnitRate."ID" := CRLumpsumUnitRent."ID";
                        TCLumpsumUnitRate."Contract Id" := Rec."Contract Id";
                        TCLumpsumUnitRate."SL_Line No." := LineNoCounter; // Ensure unique line number
                        TCLumpsumUnitRate."SL_Unit ID" := CRLumpsumUnitRent."SL_Unit ID";
                        TCLumpsumUnitRate.SL_Year := CRLumpsumUnitRent.SL_Year;
                        TCLumpsumUnitRate."SL_Start Date" := CRLumpsumUnitRent."SL_Start Date";
                        TCLumpsumUnitRate."SL_End Date" := CRLumpsumUnitRent."SL_End Date";
                        TCLumpsumUnitRate."SL_Number of Days" := CRLumpsumUnitRent."SL_Number of Days";
                        TCLumpsumUnitRate."SL_Unit Sq Ft" := CRLumpsumUnitRent."SL_Unit Sq Ft";
                        TCLumpsumUnitRate."SL_Rate per Sq.Ft" := CRLumpsumUnitRent."SL_Rate per Sq.Ft";
                        TCLumpsumUnitRate."SL_Rent Increase %" := CRLumpsumUnitRent."SL_Rent Increase %";
                        TCLumpsumUnitRate."SL_Annual Amount" := CRLumpsumUnitRent."SL_Annual Amount";
                        TCLumpsumUnitRate."SL_Round off" := CRLumpsumUnitRent."SL_Round off";
                        TCLumpsumUnitRate."SL_Final Annual Amount" := CRLumpsumUnitRent."SL_Final Annual Amount";
                        TCLumpsumUnitRate."SL_Per Day Rent" := CRLumpsumUnitRent."SL_Per Day Rent";
                        TCLumpsumUnitRate.TotalFinalAmount := CRSingleUnitRent.TotalFinalAmount;
                        TCLumpsumUnitRate.TotalAnnualAmount := CRSingleUnitRent.TotalAnnualAmount;
                        TCLumpsumUnitRate.TotalRoundOff := CRSingleUnitRent.TotalRoundOff;
                        TCLumpsumUnitRate.TotalFirstAnnualAmount := CRSingleUnitRent.TotalFirstAnnualAmount;


                        TCLumpsumUnitRate.Insert();

                        LineNoCounter += 1; // Increment line number
                    until CRLumpsumUnitRent.Next() = 0;
                    // end else begin
                    //     Message('No existing records found for ID: %1 in CR Single LumAnnualAmnt SP.', "Renewal Proposal ID");
                end;
            end

            else
                if "Merge Rent Calculation" = "Merge Rent Calculation"::"Merged Unit with same square feet" then begin
                    TCMergeUnitRate.Reset();
                    TCMergeUnitRate.SetRange("ID", "Renewal Proposal ID");
                    if TCMergeUnitRate.FindSet() then
                        TCMergeUnitRate.DeleteAll();

                    CRMergeUnitRent.Reset();
                    CRMergeUnitRent.SetRange("ID", "Renewal Proposal ID");
                    if CRMergeUnitRent.FindSet() then begin
                        LineNoCounter := 1;
                        repeat
                            TCMergeUnitRate.Init();
                            TCMergeUnitRate."ID" := CRMergeUnitRent."ID";
                            TCMergeUnitRate."Contract Id" := Rec."Contract Id";
                            TCMergeUnitRate."MS_Line No." := LineNoCounter; // Ensure unique line number
                            TCMergeUnitRate."MS_Merged Unit ID" := CRMergeUnitRent."MS_Merged Unit ID";
                            TCMergeUnitRate.MS_Year := CRMergeUnitRent.MS_Year;
                            TCMergeUnitRate."MS_Start Date" := CRMergeUnitRent."MS_Start Date";
                            TCMergeUnitRate."MS_End Date" := CRMergeUnitRent."MS_End Date";
                            TCMergeUnitRate."MS_Number of Days" := CRMergeUnitRent."MS_Number of Days";
                            TCMergeUnitRate."MS_Unit Sq Ft" := CRMergeUnitRent."MS_Unit Sq Ft";
                            TCMergeUnitRate."MS_Rate per Sq.Ft" := CRMergeUnitRent."MS_Rate per Sq.Ft";
                            TCMergeUnitRate."MS_Rent Increase %" := CRMergeUnitRent."MS_Rent Increase %";
                            TCMergeUnitRate."MS_Annual Amount" := CRMergeUnitRent."MS_Annual Amount";
                            TCMergeUnitRate."MS_Round off" := CRMergeUnitRent."MS_Round off";
                            TCMergeUnitRate."MS_Final Annual Amount" := CRMergeUnitRent."MS_Final Annual Amount";
                            TCMergeUnitRate."MS_Per Day Rent" := CRMergeUnitRent."MS_Per Day Rent";
                            TCMergeUnitRate.TotalFinalAmount := CRMergeUnitRent.TotalFinalAmount;
                            TCMergeUnitRate.TotalAnnualAmount := CRMergeUnitRent.TotalAnnualAmount;
                            TCMergeUnitRate.TotalRoundOff := CRMergeUnitRent.TotalRoundOff;
                            TCMergeUnitRate.TotalFirstAnnualAmount := CRMergeUnitRent.TotalFirstAnnualAmount;
                            TCMergeUnitRate.Insert();
                            LineNoCounter += 1;
                        until CRMergeUnitRent.Next() = 0;
                    end;
                end
                else
                    if "Merge Rent Calculation" = "Merge Rent Calculation"::"Merged Unit with differential square feet rate" then begin
                        TCMergediffUnitRate.Reset();
                        TCMergediffUnitRate.SetRange("ID", "Renewal Proposal ID");
                        if TCMergediffUnitRate.FindSet() then
                            TCMergediffUnitRate.DeleteAll();
                        CRMergediffUnitRent.Reset();
                        CRMergediffUnitRent.SetRange("ID", "Renewal Proposal ID");
                        if CRMergediffUnitRent.FindSet() then begin
                            LineNoCounter := 1;
                            repeat
                                TCMergediffUnitRate.Init();
                                TCMergediffUnitRate."ID" := CRMergediffUnitRent."ID";
                                TCMergediffUnitRate."Contract Id" := Rec."Contract ID";
                                TCMergediffUnitRate."MD_Line No." := LineNoCounter; // Ensure unique line number
                                TCMergediffUnitRate."MD_Merged Unit ID" := CRMergediffUnitRent."MD_Merged Unit ID";
                                TCMergediffUnitRate.MD_Year := CRMergediffUnitRent.MD_Year;
                                TCMergediffUnitRate."MD_Start Date" := CRMergediffUnitRent."MD_Start Date";
                                TCMergediffUnitRate."MD_End Date" := CRMergediffUnitRent."MD_End Date";
                                TCMergediffUnitRate."MD_Number of Days" := CRMergediffUnitRent."MD_Number of Days";
                                TCMergediffUnitRate."MD_Unit Sq Ft" := CRMergediffUnitRent."MD_Unit Sq Ft";
                                TCMergediffUnitRate."MD_Rate per Sq.Ft" := CRMergediffUnitRent."MD_Rate per Sq.Ft";
                                TCMergediffUnitRate."MD_Rent Increase %" := CRMergediffUnitRent."MD_Rent Increase %";
                                TCMergediffUnitRate."MD_Annual Amount" := CRMergediffUnitRent."MD_Annual Amount";
                                TCMergediffUnitRate."MD_Round off" := CRMergediffUnitRent."MD_Round off";
                                TCMergediffUnitRate."MD_Final Annual Amount" := CRMergediffUnitRent."MD_Final Annual Amount";
                                TCMergediffUnitRate."MD_Per Day Rent" := CRMergediffUnitRent."MD_Per Day Rent";
                                TCMergediffUnitRate.TotalFinalAmount := CRMergediffUnitRent.TotalFinalAmount;
                                TCMergediffUnitRate.TotalAnnualAmount := CRMergediffUnitRent.TotalAnnualAmount;
                                TCMergediffUnitRate.TotalRoundOff := CRMergediffUnitRent.TotalRoundOff;
                                TCMergediffUnitRate.TotalFirstAnnualAmount := CRMergediffUnitRent.TotalFirstAnnualAmount;
                                TCMergediffUnitRate.Insert();
                                LineNoCounter += 1;
                            until CRMergediffUnitRent.Next() = 0;
                        end;
                    end
                    else
                        if "Merge Rent Calculation" = "Merge Rent Calculation"::"Merged Unit with lumpsum annual amount" then begin
                            TCMergeLumpsumUnitRate.Reset();
                            TCMergeLumpsumUnitRate.SetRange("ID", "Renewal Proposal ID");
                            if TCMergeLumpsumUnitRate.FindSet() then
                                TCMergeLumpsumUnitRate.DeleteAll();

                            LineNoCounter := 1;
                            CRMergeLumpsumUnitRent.Reset();
                            CRMergeLumpsumUnitRent.SetRange("ID", "Renewal Proposal ID");
                            if CRMergeLumpsumUnitRent.FindSet() then
                                repeat
                                    TCMergeLumpsumUnitRate.Init();
                                    TCMergeLumpsumUnitRate."ID" := CRMergeLumpsumUnitRent."ID";
                                    TCMergeLumpsumUnitRate."Contract Id" := Rec."Contract ID";
                                    TCMergeLumpsumUnitRate."ML_Line No." := LineNoCounter; // Ensure unique line number
                                    TCMergeLumpsumUnitRate."ML_Merged Unit ID" := CRMergeLumpsumUnitRent."ML_Merged Unit ID";
                                    TCMergeLumpsumUnitRate.ML_Year := CRMergeLumpsumUnitRent.ML_Year;
                                    TCMergeLumpsumUnitRate."ML_Start Date" := CRMergeLumpsumUnitRent."ML_Start Date";
                                    TCMergeLumpsumUnitRate."ML_End Date" := CRMergeLumpsumUnitRent."ML_End Date";
                                    TCMergeLumpsumUnitRate."ML_Number of Days" := CRMergeLumpsumUnitRent."ML_Number of Days";
                                    TCMergeLumpsumUnitRate."ML_Unit Sq Ft" := CRMergeLumpsumUnitRent."ML_Unit Sq Ft";
                                    TCMergeLumpsumUnitRate."ML_Rate per Sq.Ft" := CRMergeLumpsumUnitRent."ML_Rate per Sq.Ft";
                                    TCMergeLumpsumUnitRate."ML_Rent Increase %" := CRMergeLumpsumUnitRent."ML_Rent Increase %";
                                    TCMergeLumpsumUnitRate."ML_Annual Amount" := CRMergeLumpsumUnitRent."ML_Annual Amount";
                                    TCMergeLumpsumUnitRate."ML_Round off" := CRMergeLumpsumUnitRent."ML_Round off";
                                    TCMergeLumpsumUnitRate."ML_Final Annual Amount" := CRMergeLumpsumUnitRent."ML_Final Annual Amount";
                                    TCMergeLumpsumUnitRate."ML_Per Day Rent" := CRMergeLumpsumUnitRent."ML_Per Day Rent";
                                    TCMergeLumpsumUnitRate.TotalFinalAmount := CRMergeLumpsumUnitRent.TotalFinalAmount;
                                    TCMergeLumpsumUnitRate.TotalAnnualAmount := CRMergeLumpsumUnitRent.TotalAnnualAmount;
                                    TCMergeLumpsumUnitRate.TotalRoundOff := CRMergeLumpsumUnitRent.TotalRoundOff;
                                    TCMergeLumpsumUnitRate.TotalFirstAnnualAmount := CRMergeLumpsumUnitRent.TotalFirstAnnualAmount;
                                    TCMergeLumpsumUnitRate.Insert();
                                    LineNoCounter += 1;
                                until CRMergeLumpsumUnitRent.Next() = 0;
                        end;
        TCPerDayRevenewUnitRate.Reset();
        TCPerDayRevenewUnitRate.SetRange("Contract Renewal Id", "Renewal Proposal ID");
        if TCPerDayRevenewUnitRate.FindSet() then
            TCPerDayRevenewUnitRate.DeleteAll();
        LineNoCounter := 1;
        CRPerDayRevenewUnitRate.Reset();
        CRPerDayRevenewUnitRate.SetRange("Contract Renewal Id", "Renewal Proposal ID");
        if CRPerDayRevenewUnitRate.FindSet() then
            repeat
                TCPerDayRevenewUnitRate.Init();
                TCPerDayRevenewUnitRate."Contract Renewal Id" := CRPerDayRevenewUnitRate."Contract Renewal Id";
                TCPerDayRevenewUnitRate."Merge Unit Id" := CRPerDayRevenewUnitRate."Merge Unit Id";
                TCPerDayRevenewUnitRate."Year" := CRPerDayRevenewUnitRate."Year";
                TCPerDayRevenewUnitRate."Unit ID" := CRPerDayRevenewUnitRate."Unit ID";
                TCPerDayRevenewUnitRate."Sq.Ft" := CRPerDayRevenewUnitRate."Sq.Ft";
                TCPerDayRevenewUnitRate."Per Day Rent Per Unit" := CRPerDayRevenewUnitRate."Per Day Rent Per Unit";
                TCPerDayRevenewUnitRate.Insert();
                Clear(TCPerDayRevenewUnitRate);
                LineNoCounter += 1;
            until CRPerDayRevenewUnitRate.Next() = 0;
    end;

    trigger OnModify()
    begin
        populateTenantContractStatusPaymentschedule();
    end;

    procedure populateTenantContractStatusPaymentschedule()
    var
        paymentscheule: Record "Payment Schedule";
        paymentschedule2: Record "Payment Schedule2";
        paymentscheule1: Record "Payment Schedule";
        paymentschedule3grid: Record "Payment Schedule2";
        paymentscheulecard: Record "Payment Schedule";
    begin
        if Rec."Tenant Contract Status" = Rec."Tenant Contract Status"::Active then begin
            if paymentscheule.Get(Rec."Contract ID") then begin
                paymentscheule."Contract Status" := Format(Rec."Tenant Contract Status");
                paymentscheule.Modify();
            end;
            paymentschedule2.SetRange("Contract ID", Rec."Contract ID");
            if paymentschedule2.FindSet() then
                repeat
                    paymentschedule2."Contract Status" := Format(Rec."Tenant Contract Status");
                    paymentschedule2.Modify();
                until paymentschedule2.Next() = 0;
        end;

        if Rec."Tenant Contract Status" = Rec."Tenant Contract Status"::Suspended then
            if paymentscheule1.Get(Rec."Contract ID") then begin
                paymentscheule1."Contract Status" := Format(Rec."Tenant Contract Status");
                paymentscheule1.Modify();
            end;

        if Rec."Tenant Contract Status" = Rec."Tenant Contract Status"::Terminated then begin
            if paymentscheulecard.Get(Rec."Contract ID") then begin
                paymentscheulecard."Contract Status" := Format(Rec."Tenant Contract Status");
                paymentscheulecard.Modify();
            end;

            paymentschedule3grid.SetRange("Contract ID", Rec."Contract ID");
            if paymentschedule3grid.FindSet() then
                repeat
                    paymentschedule3grid."Contract Status" := Format(Rec."Tenant Contract Status");
                    paymentschedule3grid.Modify();
                until paymentschedule3grid.Next() = 0;
        end;
    end;

    trigger OnInsert()
    begin
        "Created By" := CopyStr(UserId, 1, StrLen(UserId));
    end;

    procedure CalculateGracePeriod()
    var
        StartDate, EndDate : Date;
        DaysBetween: Integer;
    begin
        StartDate := "Grace Start Date";
        EndDate := "Grace End Date";

        if (StartDate <> 0D) and (EndDate <> 0D) then begin
            if EndDate >= StartDate then
                DaysBetween := EndDate - StartDate
            else
                DaysBetween := 0;

            "Grace Period" := DaysBetween;
        end else
            "Grace Period" := 0;
    end;

    local procedure IsLeapYear(Year: Integer): Boolean
    begin
        if (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0)) then
            exit(true);
        exit(false);
    end;

    trigger OnDelete()
    begin
        Deletegriddata();
    end;

    procedure Deletegriddata()
    var
        otherpayments: Record "Tenancy Contract Subpage";
    begin
        otherpayments.SetRange(ContractID, Rec."Contract ID");
        if otherpayments.FindSet()
        then
            otherpayments.DeleteAll();

    end;

    procedure brokerdata()
    var
        leaseproposal: Record "Lease Proposal Details";
    begin
        leaseproposal.SetRange("Proposal ID", Rec."Proposal ID");

        if leaseproposal.FindFirst() then begin
            // Exit if Vendor ID is blank (i.e., not available)
            if leaseproposal."Vendor ID" = '' then
                exit;
            if leaseproposal.FindFirst() then begin
                // Fill fields from Lease Proposal
                Rec."Vendor ID" := leaseproposal."Vendor ID";
                Rec."Vendor Name" := leaseproposal."Vendor Name";
                Rec."Start Date" := leaseproposal."Start Date";
                Rec."End Date" := leaseproposal."End Date";
                Rec."Contract Status" := leaseproposal."Contract Status";
                Rec."Calculation Method" := leaseproposal."Calculation Method";
                Rec."Percentage Type" := leaseproposal."Percentage Type";
                Rec.Percentage := leaseproposal.Percentage;
                Rec.Amount := leaseproposal.Amount;
                Rec."Base Amount Type" := leaseproposal."Base Amount Type";
                Rec."Frequency Of Payment" := leaseproposal."Frequency Of Payment";
                ManagementFeeMasterDetailsFetch();
                Rec.Modify();
            end else begin
                Rec.Init();
                Rec."Vendor ID" := leaseproposal."Vendor ID";
                Rec."Vendor Name" := leaseproposal."Vendor Name";
                Rec."Start Date" := leaseproposal."Start Date";
                Rec."End Date" := leaseproposal."End Date";
                Rec."Contract Status" := leaseproposal."Contract Status";
                Rec."Calculation Method" := leaseproposal."Calculation Method";
                Rec."Percentage Type" := leaseproposal."Percentage Type";
                Rec.Percentage := leaseproposal.Percentage;
                Rec.Amount := leaseproposal.Amount;
                Rec."Base Amount Type" := leaseproposal."Base Amount Type";
                Rec."Frequency Of Payment" := leaseproposal."Frequency Of Payment";
                ManagementFeeMasterDetailsFetch();
                Rec.Insert();
            end;
        end;
    end;



    procedure renewalbrokerdata()
    var
        contractrenewal: Record "Contract Renewal";
    begin
        contractrenewal.SetRange("Proposal ID", Rec."Proposal ID");

        if contractrenewal.FindFirst() then begin
            if contractrenewal."Vendor ID" = '' then
                exit;
            if contractrenewal.FindFirst() then begin
                Rec."Vendor ID" := contractrenewal."Vendor ID";
                Rec."Vendor Name" := contractrenewal."Vendor Name";
                Rec."Start Date" := contractrenewal."Start Date";
                Rec."End Date" := contractrenewal."End Date";
                Rec."Contract Status" := contractrenewal."Contract Status";
                Rec."Calculation Method" := contractrenewal."Calculation Method";
                Rec."Percentage Type" := contractrenewal."Percentage Type";
                Rec.Percentage := contractrenewal.Percentage;
                Rec.Amount := contractrenewal.Amount;
                Rec."Base Amount Type" := contractrenewal."Base Amount Type";
                Rec."Frequency Of Payment" := contractrenewal."Frequency Of Payment";
                ManagementFeeMasterDetailsFetch();
                Rec.Modify();
            end else begin
                Rec.Init();
                Rec."Vendor ID" := contractrenewal."Vendor ID";
                Rec."Vendor Name" := contractrenewal."Vendor Name";
                Rec."Start Date" := contractrenewal."Start Date";
                Rec."End Date" := contractrenewal."End Date";
                Rec."Contract Status" := contractrenewal."Contract Status";
                Rec."Calculation Method" := contractrenewal."Calculation Method";
                Rec."Percentage Type" := contractrenewal."Percentage Type";
                Rec.Percentage := contractrenewal.Percentage;
                Rec.Amount := contractrenewal.Amount;
                Rec."Base Amount Type" := contractrenewal."Base Amount Type";
                ManagementFeeMasterDetailsFetch();
                Rec.Insert();
            end;
        end;
    end;


    procedure ManagementFeeMasterDetailsFetch()
    var
        managementfee: Record "Brokerage Master Data";
        contractLine: Record "Tenancy Contract";
    begin
        contractLine.SetRange("Proposal ID", Rec."Proposal ID");

        if contractLine.FindFirst() then begin
            if contractLine."Vendor ID" = '' then
                exit;
            if contractLine.FindFirst() then
                managementfee.Reset();
            managementfee.SetRange("Vendor ID", contractLine."Vendor ID");
            managementfee.SetRange("Contract ID", contractLine."Contract ID");

            if managementfee.FindFirst() then begin
                managementfee."Vendor ID" := contractLine."Vendor ID";
                managementfee."Contract ID" := contractLine."Contract ID";
                managementfee."Property ID" := contractLine."Property ID";
                managementfee."Owner ID" := contractLine."Owner ID";
                managementfee."Unit Name" := contractLine."Unit Name";
                managementfee."Unit Number" := contractLine."Unit Number";
                managementfee."Vendor Name" := contractLine."Vendor Name";
                managementfee."Property Name" := contractLine."Property Name";
                managementfee."Start Date" := contractLine."Start Date";
                managementfee."End Date" := contractLine."End Date";
                managementfee."Property Type" := contractLine."Property Classification";
                managementfee."Contract Status" := contractLine."Contract Status";
                managementfee."Calculation Method" := contractLine."Calculation Method";
                managementfee."Percentage Type" := contractLine."Percentage Type";
                managementfee."Base Amount Type" := contractLine."Base Amount Type";
                managementfee."Frequency Of Payment" := contractLine."Frequency Of Payment";
                managementfee.Amount := contractLine.Amount;
                managementfee."Base Amount" := contractLine."Rent Amount";
                managementfee.Percentage := contractLine.Percentage;
                managementfee."Owner Name" := contractLine."Owner's Name";
                managementfee."Tenant Name" := contractLine."Customer Name";
                managementfee.Modify();
            end else begin
                // Insert new
                managementfee.Init();
                managementfee."Vendor ID" := contractLine."Vendor ID";
                managementfee."Contract ID" := contractLine."Contract ID";
                managementfee."Unit ID" := contractLine."Unit ID";
                managementfee."Unit Name" := contractLine."Unit Name";
                managementfee."Unit Number" := contractLine."Unit Number";
                managementfee."Vendor Name" := contractLine."Vendor Name";
                managementfee."Property ID" := contractLine."Property ID";
                managementfee."Property Name" := contractLine."Property Name";
                managementfee."Start Date" := contractLine."Start Date";
                managementfee."End Date" := contractLine."End Date";
                managementfee."Property Type" := contractLine."Property Classification";
                managementfee."Contract Status" := contractLine."Contract Status";
                managementfee."Calculation Method" := contractLine."Calculation Method";
                managementfee."Percentage Type" := contractLine."Percentage Type";
                managementfee."Base Amount Type" := contractLine."Base Amount Type";
                managementfee."Frequency Of Payment" := contractLine."Frequency Of Payment";
                managementfee.Amount := contractLine.Amount;
                managementfee."Base Amount" := contractLine."Rent Amount";
                managementfee.Percentage := contractLine.Percentage;
                managementfee."Owner ID" := contractLine."Owner ID";
                managementfee."Owner Name" := contractLine."Owner's Name";
                managementfee."Tenant Name" := contractLine."Customer Name";
                managementfee.Insert();
            end;
        end;
    end;
}
