table 50312 SuspendReasonTable
{
    DataClassification = ToBeClassified;
    DataCaptionFields = ID;

    fields
    {
        field(50100; ID; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            AutoIncrement = true;
        }
        field(50101; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
            TableRelation = "Tenancy Contract"."Contract ID";

            trigger OnValidate()
            var
                TenancyContractRec: Record "Tenancy Contract";
            begin
                TenancyContractRec.SetRange("Contract ID", Rec."Contract ID");
                if TenancyContractRec.FindFirst() then begin
                    Rec.TenantID := TenancyContractRec."Tenant ID";
                    Rec.TenantName := TenancyContractRec."Customer Name";
                    Rec.EmiratesID := TenancyContractRec."Emirates ID";
                    Rec.ContactNumber := TenancyContractRec."Contact Number";
                    Rec.EmailAddress := TenancyContractRec."Email Address";
                    Rec.TradeLicenseNo := TenancyContractRec."Tenant_License No.";
                    Rec.LicensingAuthority := TenancyContractRec."Licensing Authority";
                end else begin
                    Rec.TenantID := '';
                    Rec.TenantName := '';
                    Rec.EmiratesID := '';
                    Rec.ContactNumber := '';
                    Rec.EmailAddress := '';
                    Rec.TradeLicenseNo := '';
                    Rec.LicensingAuthority := '';
                end;
            end;
        }
        field(50102; TenantID; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(50103; TenantName; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Name';
        }
        field(50104; EmiratesID; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirates ID';
        }
        field(50105; ContactNumber; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contact Number';
        }
        field(50106; EmailAddress; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email Address';
        }
        field(50107; TradeLicenseNo; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Trade License No.';
        }
        field(50108; LicensingAuthority; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Licensing Authority';
        }
        field(50109; DateEffective; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Suspension Start Date';
        }
        field(50110; Reason; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reason';
            OptionMembers = " ","Legal Reason","Business Reason";
        }
        field(50111; Description; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(50112; ReleaseUnit; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Release Unit';
        }
        field(50113; ReleaseDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Release Date';
        }
        field(50114; SuspensionEffectiveDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Effective Date of Suspension to Active';
        }
        field(50115; IssueResolutionDescription; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Issue Resolution Description';
        }
        field(50116; "Tenant Contract Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Contract Status';
            OptionMembers = " ",Suspended,Active,Terminate;

            trigger OnValidate()
            var
                TenancyContract: Record "Tenancy Contract";
                PropertyManagerApproval: Codeunit "Property Manager Approval";
            begin
                if "Contract ID" = 0 then
                    Error('Contract ID must be specified.');

                if TenancyContract.Get("Contract ID") then begin
                    case "Tenant Contract Status" of
                        "Tenant Contract Status"::Suspended:
                            TenancyContract."Update Contract Status" :=
                                TenancyContract."Update Contract Status"::"Initiate Suspension Process";

                        "Tenant Contract Status"::Active:
                            begin
                                TenancyContract."Update Contract Status" :=
                                    TenancyContract."Update Contract Status"::"Initiate Activation Process";
                                "SuspensionEndDate" := Today;
                            end;

                        "Tenant Contract Status"::Terminate:
                            TenancyContract."Update Contract Status" :=
                                TenancyContract."Update Contract Status"::"Initiate Termination Process";
                    end;

                    TenancyContract.Modify(true);
                    PropertyManagerApproval.HandleContractStatusUpdate(TenancyContract);
                end else
                    Error('Tenancy Contract with Contract ID %1 not found.', "Contract ID");
            end;

        }
        field(50117; "Proposal ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Proposal ID';
            TableRelation = "Tenancy Contract";
            trigger OnValidate()
            var
                TenancyContractRec: Record "Tenancy Contract";
            begin
                Rec."Contract ID" := Rec."Proposal ID";
                TenancyContractRec.SetRange("Contract ID", Rec."Proposal ID");
                if TenancyContractRec.FindFirst() then begin
                    Rec."Proposal ID" := TenancyContractRec."Proposal ID";
                    Rec.TenantID := TenancyContractRec."Tenant ID";
                    Rec.TenantName := TenancyContractRec."Customer Name";
                    Rec.EmiratesID := TenancyContractRec."Emirates ID";
                    Rec.ContactNumber := TenancyContractRec."Contact Number";
                    Rec.EmailAddress := TenancyContractRec."Email Address";
                    Rec.TradeLicenseNo := TenancyContractRec."Tenant_License No.";
                    Rec.LicensingAuthority := TenancyContractRec."Licensing Authority";
                end else begin
                    // Clear fields if no record is found
                    Rec."Contract ID" := 0;
                    Rec.TenantID := '';
                    Rec.TenantName := '';
                    Rec.EmiratesID := '';
                    Rec.ContactNumber := '';
                    Rec.EmailAddress := '';
                    Rec.TradeLicenseNo := '';
                    Rec.LicensingAuthority := '';
                end;
            end;
        }
        field(50120; "Renewal Proposal ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Renewal ID';
            TableRelation = "Tenancy Contract"."Contract ID";

            trigger OnValidate()
            var
                TenancyContractRec: Record "Tenancy Contract";
            begin
                Rec."Contract ID" := Rec."Renewal Proposal ID";
                TenancyContractRec.SetRange("Contract ID", Rec."Renewal Proposal ID");
                if TenancyContractRec.FindFirst() then begin
                    Rec."Contract ID" := TenancyContractRec."Contract ID";
                    Rec.TenantID := TenancyContractRec."Tenant ID";
                    Rec.TenantName := TenancyContractRec."Customer Name";
                    Rec.EmiratesID := TenancyContractRec."Emirates ID";
                    Rec.ContactNumber := TenancyContractRec."Contact Number";
                    Rec.EmailAddress := TenancyContractRec."Email Address";
                    Rec.TradeLicenseNo := TenancyContractRec."Tenant_License No.";
                    Rec.LicensingAuthority := TenancyContractRec."Licensing Authority";
                end else begin
                    Rec."Contract ID" := 0;
                    Rec.TenantID := '';
                    Rec.TenantName := '';
                    Rec.EmiratesID := '';
                    Rec.ContactNumber := '';
                    Rec.EmailAddress := '';
                    Rec.TradeLicenseNo := '';
                    Rec.LicensingAuthority := '';
                end;
            end;
        }
        field(50118; ReleaseUnits; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Release Units';
            OptionMembers = " ","Yes";
            trigger OnValidate()
            var
                TenancyContract: Record "Tenancy Contract";
            begin
                if ReleaseUnits = ReleaseUnits::"Yes" then begin
                    if ("Proposal ID" = 0) or ("Contract ID" = 0) then
                        Error('Proposal ID and Contract ID must be specified.');
                    if TenancyContract.Get("Proposal ID", "Contract ID") then begin
                        TenancyContract."Update Contract Status" := TenancyContract."Update Contract Status"::"Initiate Under Suspension-Unit Released";
                        TenancyContract.Modify();
                    end else
                        Error('Tenancy Contract with Proposal ID %1 and Contract ID %2 not found.', "Proposal ID", "Contract ID");
                end;
            end;
        }

        field(50119; SuspensionEndDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Suspension End Date';
        }

        field(50121; "Contract Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Type';
            OptionMembers = " ","New Contract","Renewal Contract";
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; TenantID, TenantName, "Contract ID", EmailAddress)
        {

        }
    }
}
