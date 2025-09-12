tableextension 50102 "Item Ext" extends Item
{
    Caption = 'Unit';
    fields
    {
        field(50100; "UnitID"; code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'UnitID';
        }
        field(50101; "Property ID"; Code[20])
        {
            Caption = 'Property ID';
            DataClassification = ToBeClassified;
            TableRelation = "Property Registration"."Property ID";
            trigger OnValidate()
            var
                PropertyRec: Record "Property Registration";
            begin
                PropertyRec.SetRange("Property ID", Rec."Property ID");
                if PropertyRec.FindFirst() then begin
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
        field(50102; "Unit Number"; Text[50])
        {
            Caption = 'Actual Unit Number';
            DataClassification = ToBeClassified;
        }
        field(50103; "Floor Number"; Integer)
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
        field(50105; "Unit Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Type';
            TableRelation = "Secondary Classification" where("Classification Name" = field("Usage Type"));
            trigger OnValidate()
            var
                secondaryClassification: Record "Secondary Classification";
                id: Integer;
            begin
                Evaluate(id, Rec."Unit Type");
                secondaryClassification.SetRange(ID, id);
                if secondaryClassification.FindFirst() then
                    Rec."Unit Type" := secondaryClassification."Property Type";
            end;
        }
        field(50108; "Unit Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Status';
            OptionMembers = " ",Free,Selected,Occupied;
            OptionCaption = ' ,Free,Selected,Occupied';
            Editable = true;
        }
        field(50123; "Selected"; Boolean)
        {
            Caption = 'Selected';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50124; "MergeSplitOption"; Option)
        {
            Caption = 'Unit Classification';
            OptionMembers = "Single","Merge";
            DataClassification = ToBeClassified;
        }
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
                "Emirate Name" := '';
                "Community" := '';
            end;
        }
        field(50115; "Emirate Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirate';
            TableRelation = Emirate.ID where("Country Code" = field(Country));
            trigger OnValidate()
            var
                emirate: Record "Emirate";
                emirateID: Integer;
            begin
                Evaluate(emirateID, "Emirate Name");
                emirate.SetRange(ID, emirateID);
                if emirate.FindFirst() then begin
                    "Emirate Name" := Format(emirate."Emirate Name");
                    Community := '';
                end else
                    Error('Invalid Emirate Name: %1', "Emirate Name");
            end;
        }
        field(50116; "Community"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Community';
            TableRelation = Community."Community Name"
                 where("Emirate Name" = field("Emirate Name"));
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
            Editable = false;
        }
        field(50121; "FixedNumber"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50125; "Merged Unit ID"; Integer)
        {
            Caption = 'Merged Unit ID';
            DataClassification = ToBeClassified;
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
                CategoryType: Record "Category type";
            begin
                CategoryType.SetRange("Category Types", Rec."Category Types");
                if CategoryType.FindFirst() then
                    "Primary Item Type" := CategoryType."Primary Item Type"
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
    procedure CalculateAmount()
    var
        MarketRate: Decimal;
        UnitSize: Decimal;
    begin
        MarketRate := "Market Rate per Sq. Ft.";
        UnitSize := "Unit Size";
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
        if ("No." = '') then begin
            NewNo := NoSeriesManagement.GetNextNo('UNITID', 0D, true);
            "No." := NewNo;
        end;
        if ("FixedNumber" = '') then begin
            NewUnitNo := NoSeriesManagement.GetNextNo('UNITNO', 0D, true);
            FixedNumber := NewUnitNo;
        end;
    end;
}