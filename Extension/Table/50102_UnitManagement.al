tableextension 50102 ItemExtension extends Item
{
    Caption = 'Unit';
    fields
    {
        field(50100; "UnitID"; code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'UnitID';

        }
        field(50101; "Property ID"; Code[20]) // Property ID Field
        {
            Caption = 'Property ID';
            DataClassification = ToBeClassified;
            TableRelation = "Property Registration"."Property ID";
            // NotBlank = true;

            trigger OnValidate()
            var
                PropertyRec: Record "Property Registration";
            begin
                PropertyRec.SetRange("Property ID", Rec."Property ID");
                if PropertyRec.FindSet() then begin
                    "Property Name" := PropertyRec."Property Name";
                    "Usage Type" := PropertyRec."Property Classification"
                end else begin
                    "Property Name" := '';
                    "Usage Type" := '';
                end;
            end;

        }
        field(50118; "Property Name"; Text[100])
        {
            Caption = 'Property Name';
            DataClassification = ToBeClassified;
        }
        field(50102; "Unit Number"; Text[50]) // Unit Number Field
        {
            Caption = 'Actual Unit Number';
            DataClassification = ToBeClassified;
        }

        field(50103; "Floor Number"; Integer) // Floor Number Field
        {
            Caption = 'Floor Number';
            DataClassification = ToBeClassified;
        }

        field(50104; "Usage Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Usage Type';
            TableRelation = "Primary Classification"."Classification Name";
            NotBlank = true;

        }

        // Property Type (related to Property Type table)
        field(50105; "Unit Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Type';
            // Filter the Property Type values based on the selected Primary Classification
            TableRelation = "Secondary Classification"."Property Type"
                 where("Classification Name" = field("Usage Type"));

        }

        // field(50107; "Merge Units"; Boolean) // Merge Units Field
        // {
        //     Caption = 'Merge Units';
        //     DataClassification = ToBeClassified;
        // }
        // field(50108; "Unit Status"; Text[100])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Unit Status';
        //     // TableRelation = "Availability Status".Status;
        //     Editable = false; // Make the field non-editable
        // }

        field(50108; "Unit Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Status';
            OptionMembers = " ",Free,Selected,Occupied;
            OptionCaption = ' ,Free,Selected,Occupied';
            Editable = true; // Keep the field non-editable
        }

        field(50123; "Selected"; Boolean)
        {
            Caption = 'Selected';
            DataClassification = ToBeClassified;
            Editable = true;
        }

        // New dropdown field for Merging/Splitting
        field(50124; "MergeSplitOption"; Option)
        {
            Caption = 'Unit Classification';
            OptionMembers = "Single","Merge";
            DataClassification = ToBeClassified;
        }

        // field(50109; "Tenant ID"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Tenant ID';
        //     TableRelation = TenantProfile."Tenant ID";

        // }
        field(50110; "Unit Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Name';

        }

        field(50111; "Floor plans"; Text[250])
        {
            Caption = 'Floor plans';
            DataClassification = ToBeClassified;
        }
        field(50112; "Inspection certificates"; Text[250])
        {
            Caption = 'Inspection certificates';
            DataClassification = ToBeClassified;
        }

        field(50122; "Other Documents"; Text[250])
        {
            Caption = 'Other Documents';
            DataClassification = ToBeClassified;
        }
        field(50113; "GTIN_"; Code[100])
        {
            Caption = 'GTIN';
            DataClassification = ToBeClassified;
        }
        field(50114; "Country"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country';
            TableRelation = Country."Country Code";
            trigger OnValidate()
            begin
                Emirate := Emirate::" ";
                "Community" := '';
            end;
        }
        field(50115; "Emirate"; Enum Emirates)
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirate';
            // TableRelation = Emirate."Emirate Name"
            //     where("Country Code" = field(Country));

            trigger OnValidate()
            begin
                "Community" := '';
            end;
        }
        field(50116; "Community"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Community';
            // Filter the Property Type values based on the selected Primary Classification
            TableRelation = Community."Community Name"
                 where("Emirate Name" = field(Emirate));

        }

        field(50117; "Unit Address"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Address';

        }

        field(50106; "Market Rate per Sq. Ft."; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Market Rate per Sq. Ft.';

            trigger OnValidate()
            begin
                CalculateAmount();
            end;
        }

        field(50119; "Unit Size"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Size (sq. ft./meters)';

            trigger OnValidate()
            begin
                CalculateAmount();
            end;
        }

        field(50120; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            Editable = false; // This field is auto-calculated and should not be editable.
        }

        field(50121; "FixedNumber"; Code[100]) // New field to store the incrementing number
        {
            DataClassification = ToBeClassified;
        }

        field(50125; "Merged Unit ID"; Integer)
        {
            Caption = 'Merged Unit ID';
            DataClassification = ToBeClassified;
            // TableRelation = "Merged Units"."Merged Unit ID";

            // trigger OnLookup()
            // var
            //     MergedUnitRec: Record "Merged Units";
            // begin
            //     // Open the list page for lookup
            //     if PAGE.RunModal(PAGE::"Merged Units List", MergedUnitRec) = Action::LookupOK then begin
            //         "Merged Unit ID" := MergedUnitRec."Merged Unit ID";
            //         "Merged Property ID" := MergedUnitRec."Property ID";
            //         "Merged Property Name" := MergedUnitRec."Property Name";
            //         "Unit ID" := MergedUnitRec."Unit ID";
            //         "Merge Unit Name" := MergedUnitRec."Merged Unit Name";
            //         "Merged Base Unit of Measure" := MergedUnitRec."Base Unit of Measure";
            //         "Merged Unit Size" := MergedUnitRec."Unit Size";
            //         "Merged Amount" := MergedUnitRec.Amount;
            //         "Merged Property Type" := MergedUnitRec."Property Type";
            //         "Single Unit Name" := MergedUnitRec."Single Unit Name";
            //         "Merged Status" := MergedUnitRec.Status;
            //         "Merged Spliting Status" := MergedUnitRec."Spliting Status";
            //     end;
            // end;
        }

        field(50126; "Primary Classification Type"; Text[100])
        {
            Caption = 'Primary Classification Type';
            DataClassification = ToBeClassified;
            TableRelation = "Primary Classification"."Classification Name";
        }
        field(50140; "Item Type"; Enum "Module Enum")
        {
            Caption = 'Item Type';
            DataClassification = ToBeClassified;
        }

        field(50142; "Item Template"; Enum "Item Template Enum")
        {
            Caption = 'Item Template';
            DataClassification = ToBeClassified;
        }

        field(50144; "Item type template"; Enum "Item Type Template Enum")
        {
            Caption = 'Item type template';
            DataClassification = ToBeClassified;
        }

        // field(50126; "Merged Property ID"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Merged Units"."Property ID";
        // }

        // field(50127; "Merged Property Name"; Text[100])
        // {
        //     // Caption = 'Property Name';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Merged Units"."Property Name";
        // }

        // field(50128; "Unit ID"; Code[100])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Merged Units"."Unit ID";
        // }

        // field(50129; "Merge Unit Name"; Code[100])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Merged Units"."Merged Unit Name";
        // }

        // field(50130; "Merged Base Unit of Measure"; Code[10])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Merged Units"."Base Unit of Measure";
        // }
        // field(50131; "Merged Unit Size"; Decimal)
        // {
        //     // Caption = 'Total Unit Size';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Merged Units"."Unit Size";
        // }

        // field(50132; "Merged Amount"; Decimal)
        // {
        //     // Caption = 'Total Amount';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Merged Units".Amount;
        // }

        // field(50133; "Merged Property Type"; Code[20])
        // {
        //     // Caption = 'Property Type';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Merged Units"."Property Type";
        // }

        // field(50134; "Merged Status"; Option)
        // {
        //     // Caption = 'Merge Unit Status';
        //     OptionMembers = "Free","Occupied","Selected","N/A";
        //     DataClassification = ToBeClassified;
        //     // TableRelation = "Merged Units".Status;
        // }

        // field(50135; "Merged Spliting Status"; Option)
        // {
        //     // Caption = 'Splitting  Status';
        //     DataClassification = ToBeClassified;
        //     OptionMembers = " ","Merge","Unmerge";
        //     // TableRelation = "Merged Units"."Spliting Status";
        // }

        // field(50136; "Single Unit Name"; Text[500])
        // {
        //     // Caption = 'Single Unit Names';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Merged Units"."Single Unit Name";
        // }

        // field(50137; "Select Unit Type"; Option)
        // {
        //     // Caption = 'Splitting  Status';
        //     DataClassification = ToBeClassified;
        //     OptionMembers = " ","Single Unit","Merge Unit";
        // }
        // field(50138; "Merged FixedNumber"; Code[100]) // New field to store the incrementing number
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Merged Units".FixedNumber;
        // }
        field(50145; "Primary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Item';
            TableRelation = "Primary Item"."Primary Item Type";
            Editable = false;
        }
        field(50146; "Category Types"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Category';
            TableRelation = "Category Type"."Category Types";

            trigger OnValidate()
            var
                CategoryRec: Record "Category type";
                PrimaryRec: Record "Primary Item";
            begin
                CategoryRec.SetRange("Category Types", Rec."Category Types");

                if CategoryRec.FindFirst() then
                    "Primary Item Type" := CategoryRec."Primary Item Type"
                else
                    "Primary Item Type" := '';
            end;
        }

        field(50147; "VAT Type"; Option)
        {
            Caption = 'VAT Type';
            OptionMembers = "Zero-0%","Standard-5%";
            trigger OnValidate()
            begin
                case "VAT Type" of
                    0:
                        "VAT %" := 0;
                    1:
                        "VAT %" := 1;
                    else
                        "VAT %" := 0;
                end;
            end;
        }
        field(50148; "VAT %"; Option)
        {
            OptionMembers = "0","5";
            Caption = 'VAT %';
            Editable = false;
        }
        field(50149; "Charges Status"; Option)
        {
            OptionMembers = " ","Regular Charges","Additional Charges";
            Caption = 'Charges Status';
        }
    }


    // procedure countryreturn(): Text
    // var
    //     countryRec: Record Country;
    // begin

    //     countryRec.SetRange("Country Name", Rec.Country);
    //     exit(countryRec."Country Code");
    // end;

    procedure CalculateAmount()
    var
        MarketRate: Decimal;
        UnitSize: Decimal;
    begin
        MarketRate := "Market Rate per Sq. Ft.";
        UnitSize := "Unit Size";

        // Calculate the amount based on Market Rate and Unit Size
        if (MarketRate <> 0) and (UnitSize <> 0) then
            "Amount" := MarketRate * UnitSize
        else
            "Amount" := 0;
    end;





    trigger OnInsert()
    var
        NoSeriesManagement: Codeunit "No. Series";
        NewNo: Code[20];
        NewUnitNo: Code[20];
    begin
        // Ensure UnitID is generated when a new record is created
        if ("No." = '') then begin
            NewNo := NoSeriesManagement.GetNextNo('UNITID', 0D, true); // Use the number series code you created
            "No." := NewNo;
        end;

        if ("FixedNumber" = '') then begin
            NewUnitNo := NoSeriesManagement.GetNextNo('UNITNO', 0D, true); // Use the number series code you created
            FixedNumber := NewUnitNo;
        end;

        // Set the default value for Unit Status to 'Free' on record creation
        // if "Unit Status" = '' then
        //     "Unit Status" := 'Free';
    end;




}