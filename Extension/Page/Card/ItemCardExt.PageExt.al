pageextension 50101 "Item Card Ext" extends "Item Card"
{
    Caption = 'Unit Card';

    layout
    {
        modify("No.")
        {
            Editable = false;
        }
        modify("Item Category Code")
        {
            Visible = isVenderService;
        }
        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }
        modify("Common Item No.")
        {
            Visible = false;
        }
        modify("Purchasing Code")
        {
            Visible = false;
        }
        modify("VariantMandatoryDefaultNo")
        {
            Visible = false;
        }
        modify(Blocked)
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify(InventoryGrp)
        {
            Visible = isVenderService;
        }
        modify("Costs & Posting")
        {
            Visible = isVenderService;
        }
        modify("Prices & Sales")
        {
            Visible = isVenderService;
        }
        modify(Replenishment)
        {
            Visible = isVenderService;
        }
        modify(Planning)
        {
            Visible = isVenderService;
        }
        modify(ItemTracking)
        {
            Visible = isVenderService;
        }
        modify(Warehouse)
        {
            Visible = isVenderService;
        }
        modify(GTIN)
        {
            Visible = false;
        }
        addafter(Description)
        {
            group("Posting setup")
            {
                ShowCaption = false;
                Visible = hideshowfields and isVenderService or Unitcharges;
            }
        }
        movefirst("Posting setup"; "Gen. Prod. Posting Group", "VAT Prod. Posting Group")
        modify("Service Item Group")
        {
            Editable = editablefalsefieldNonInventoryType;
            Visible = false;
        }
        modify(Item)
        {
            caption = 'Unit';
        }
        addafter(Type)
        {
            group("Unit Charges Description")
            {
                ShowCaption = false;
                Visible = Unitcharges or isVenderService;

                field("Primary Item Type"; Rec."Primary Item Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Primary Item Type';
                }
                field("Category Types"; Rec."Category Types")
                {
                    ApplicationArea = All;
                    ToolTip = 'Category Types';
                }
                field("VAT Type"; Rec."VAT Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'VAT Type';
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                    ToolTip = 'VAT Percentage';
                }
                field("Charges Status"; Rec."Charges Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Charges Status';
                }
            }
        }
        movefirst("Unit Charges Description"; Description)
        addafter("Base Unit of Measure")
        {
            group("BaseUnitofMeasure")
            {
                ShowCaption = false;
                Visible = isUnitService;
                field("Market Rate per Sq. Ft."; rec."Market Rate per Sq. Ft.")
                {
                    ApplicationArea = All;
                    Editable = editablefalsefieldNonInventoryType;
                    ToolTip = 'Market Rate per Square Foot';
                }
            }
        }
        addafter("Market Rate per Sq. Ft.")
        {
            group("MarketRateperSq.Ft.")
            {
                ShowCaption = false;
                Visible = isUnitService;
                field("Unit Size"; rec."Unit Size")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Size';
                    ToolTip = 'Size of the Unit in Square Feet';
                    Editable = editablefalsefieldNonInventoryType;
                }
            }

        }
        addafter("Unit Size")
        {
            group("UnitSize")
            {
                ShowCaption = false;
                Visible = isUnitService;
                field("Amount"; rec."Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
                    ToolTip = 'Calculated Amount based on Market Rate and Unit Size';
                    Editable = false;
                }
            }
        }
        addafter("Gen. Prod. Posting Group")
        {
            group("Gen.Prod.PostingGroup")
            {
                ShowCaption = false;
                Visible = isUnitService;
                field("Primary Classification Type"; Rec."Primary Classification Type")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Classification Type';
                    Editable = ISPrimaryType;
                    ToolTip = 'Primary Classification Type for the Unit';
                }
            }
        }
        addafter(Item)
        {
            group(UnitManagement)
            {
                Visible = isUnitService;
                Caption = 'Unit Management';

                field(FixedNumber; Rec.FixedNumber)
                {
                    ApplicationArea = All;
                    Caption = 'FixedNumber';
                    ToolTip = 'Fixed Number for the Unit';
                    Editable = false;
                    Visible = false;
                }
                field("Country"; Rec.Country)
                {
                    ApplicationArea = All;
                    Caption = 'Country';
                    ToolTip = 'Country where the Unit is located';
                    Lookup = true;
                    Editable = editablefalsefieldNonInventoryType;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec);
                    end;

                }
                field(Emirate; Rec."Emirate Name")
                {
                    ApplicationArea = All;
                    Caption = 'Emirate';
                    ToolTip = 'Emirate where the Unit is located';
                    Lookup = true;
                    Editable = editablefalsefieldNonInventoryType;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec);
                    end;
                }
                field("Community"; Rec.Community)
                {
                    ApplicationArea = All;
                    Caption = 'Community';
                    ToolTip = 'Community where the Unit is located';
                    Lookup = true;
                    Editable = editablefalsefieldNonInventoryType;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec);
                    end;
                }
                field("Property ID"; Rec."Property ID")
                {
                    ApplicationArea = All;
                    Caption = 'Property ID';
                    ToolTip = 'Unique Identifier for the Property';
                    Editable = editablefalsefieldNonInventoryType;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec);
                    end;
                }
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = All;
                    Caption = 'Property Name';
                    ToolTip = 'Name of the Property where the Unit is located';
                    Editable = false;
                }
                field("Floor Number"; Rec."Floor Number")
                {
                    ApplicationArea = All;
                    Caption = 'Floor Number';
                    ToolTip = 'Floor Number of the Unit';
                    Editable = editablefalsefieldNonInventoryType;
                }
                field("Unit Number"; Rec."Unit Number")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Number';
                    ToolTip = 'Actual Unit Number within the Property';
                    Editable = editablefalsefieldNonInventoryType;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec);
                    end;
                }

                field("Unit ID"; Rec.UnitID)
                {
                    ApplicationArea = All;
                    Caption = 'Unit ID';
                    ToolTip = 'Unique Identifier for the Unit';
                    Editable = false;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Name';
                    ToolTip = 'Name of the Unit';
                    Editable = false;
                }

                field("Usage Type"; rec."Usage Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usage Type of the Unit';
                    Lookup = true;
                    Editable = false;
                }

                field("Unit Type"; rec."Unit Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type of the Unit';
                    Lookup = true;
                    Editable = editablefalsefieldNonInventoryType;
                }
                field("Unit Address"; rec."Unit Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Address of the Unit';
                    Editable = editablefalsefieldNonInventoryType;
                }
                field("Merging/Splitting"; rec."MergeSplitOption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Option for Merging or Splitting the Unit';
                    Editable = false;
                }

                field("Unit Status"; rec."Unit Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Current Status of the Unit';
                    Lookup = true;
                }
            }
            part("Document Attachments"; "Unit Document SubPage")
            {
                SubPageLink = UnitID = FIELD("No.");
                ApplicationArea = All;
                Editable = editablefalsefieldNonInventoryType;
                Visible = ShowFinancialFields and isUnitService and isVisible;
            }
        }
    }

    actions
    {
        modify(CopyItem)
        {
            trigger OnAfterAction()
            begin
                AutoGenerateUnitName(Rec);
            end;
        }
        addafter("Item Journal")
        {
            action("Add New Line")
            {
                ApplicationArea = All;
                ToolTip = 'Add a new line to the Unit Charges';
                Visible = isService;
                trigger OnAction()
                var
                    CustomLinesPage: Record "Revenue Structure Subpage";
                    CustomLinesPage2: Record "Revenue Structure";
                begin
                    if CustomLinesPage.FindSet() then
                        CustomLinesPage.DeleteAll();

                    if CustomLinesPage2.FindSet() then
                        CustomLinesPage2.DeleteAll();
                end;
            }
        }
    }

    procedure AutoGenerateUnitName(var TargetItem: Record Item)
    var
        PropertyCode: Text;
        UnitID: Text;
        CountryCode: Text;
        EmiratesCode: Text;
        CommunityCode: Text;
        UnitnumberCode: Text;
        lCountry: Text;
        Emirates: Text;
        lCommunity: Text;
        Unitnumber: Text;
    begin
        PropertyCode := FormatName(TargetItem."Property Name");
        lCountry := Format(TargetItem.Country);
        Emirates := Format(TargetItem."Emirate Name");
        lCommunity := Format(TargetItem."Community");
        Unitnumber := Format(TargetItem."Unit Number");
        CountryCode := FormatName(lCountry);
        EmiratesCode := FormatName(Emirates);
        CommunityCode := FormatName(lCommunity);
        UnitnumberCode := Format(Unitnumber);
        TargetItem."Unit Name" := PropertyCode + '-SU-' + Format(TargetItem.FixedNumber);
        UnitID := CountryCode + '-' + EmiratesCode + '-' + CommunityCode + '-' + PropertyCode + '-' + UnitnumberCode;
        TargetItem.UnitID := CopyStr(UnitID, 1, StrLen(UnitID));
        TargetItem.Modify();
    end;

    procedure FormatName(Name: Text): Text
    var
        Words: List of [Text];
        Word: Text;
        Code: Text;
        i: Integer;
    begin
        Words := Name.Split(' ');

        if Words.Count() = 1 then
            Code := CopyStr(Words.Get(1), 1, 3)
        else begin
            Code := '';
            for i := 1 to Words.Count() do begin
                Word := Words.Get(i);
                Code += CopyStr(Word, 1, 1);
            end;
        end;

        exit(Code);
    end;

    var
        isVisible: Boolean;
        isUnitService: Boolean;
        isVenderService: Boolean;

    procedure EvaluateFastTabVisibility(): Boolean
    begin
        if Rec."Item Template" = Enum::"Item Template Enum"::Service then
            if Rec."Item type template" = Enum::"Item Type Template Enum"::"Unit Service" then
                exit(true)
            else
                exit(false);
    end;

    procedure EvaluateFastTabVisibilityService(): Boolean
    begin
        if Rec."Item Template" = Enum::"Item Template Enum"::Service then
            if Rec."Item type template" = Enum::"Item Type Template Enum"::"Vendor Service" then
                exit(true)
            else
                exit(false);
    end;

    procedure UnitChargesFieldsVisiblity(): Boolean
    begin
        if Rec."Item Template" = Enum::"Item Template Enum"::Service then
            if Rec."Item type template" = Enum::"Item Type Template Enum"::"Secondary Item" then
                exit(true)
            else
                exit(false);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CurrPage."Document Attachments".Page.SetUnitId(Rec."No.");
        ISPrimaryType := SetPrimaryType();
        hideshowfields := hidefields();
        editablefalsefieldNonInventoryType := editablefalseNonInventory();
        isUnitService := EvaluateFastTabVisibility();
        isVenderService := EvaluateFastTabVisibilityService();
        Unitcharges := UnitChargesFieldsVisiblity();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage."Document Attachments".Page.SetUnitId(Rec."No.");
        isVisible := true;

        if Rec."Property Name" = '' then
            exit
        else
            AutoGenerateUnitName(Rec);
    end;

    trigger OnAfterGetRecord()

    begin
        CurrPage."Document Attachments".Page.SetUnitId(Rec."No.");
        if Format(Rec."No.") <> '' then
            isVisible := true
        else
            isVisible := false;

        ISPrimaryType := SetPrimaryType();
        hideshowfields := hidefields();
        editablefalsefieldNonInventoryType := editablefalseNonInventory();
        isUnitService := EvaluateFastTabVisibility();
        isVenderService := EvaluateFastTabVisibilityService();
        Unitcharges := UnitChargesFieldsVisiblity();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ISPrimaryType := SetPrimaryType();
        hideshowfields := hidefields();
        editablefalsefieldNonInventoryType := editablefalseNonInventory();
        Unitcharges := UnitChargesFieldsVisiblity();
    end;

    procedure SetPrimaryType(): Boolean
    var
    begin
        if Rec.Type = Rec.Type::"Non-Inventory" then
            exit(true)
        else
            exit(false);
    end;

    procedure hidefields(): Boolean
    var
    begin
        if Rec.Type = Rec.Type::Service then
            exit(false)
        else
            exit(true);
    end;

    procedure editablefalseNonInventory(): Boolean
    var
    begin
        if Rec.Type = Rec.Type::"Non-Inventory" then
            exit(false)
        else
            exit(true);
    end;

    trigger OnOpenPage()
    var
    begin
        hideshowfields := hidefields();
        editablefalsefieldNonInventoryType := editablefalseNonInventory();
        ShowFinancialFields := not IsUserInProfile('FINANCE MANAGER');
    end;

    var
        ISPrimaryType: Boolean;
        ShowFinancialFields: Boolean;
        hideshowfields: Boolean;
        editablefalsefieldNonInventoryType: Boolean;
        Unitcharges: Boolean;

    local procedure IsUserInProfile(ProfileID: Code[20]): Boolean
    var
        AccessControl: Record "User Personalization";
    begin
        AccessControl.SetRange("User ID", UserId());
        AccessControl.SetRange("Profile ID", ProfileID);
        exit(not AccessControl.IsEmpty());
    end;
}