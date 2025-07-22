pageextension 50101 Items extends "Item Card"
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

        // modify(Description)
        // {
        //     //  Visible = isVenderService or Unitcharges;
        //     Visible = Unitcharges;
        // }
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
        // modify("Gen. Prod. Posting Group")
        // {
        //     ShowMandatory = false;
        //     // Editable = hideshowfields;
        //     Visible = hideshowfields and isVenderService;

        // }
        addafter(Description)
        {
            group("Posting setup")
            {
                ShowCaption = false;
                Visible = hideshowfields and isVenderService or Unitcharges;

            }

        }
        movefirst("Posting setup"; "Gen. Prod. Posting Group", "VAT Prod. Posting Group")

        // modify("VAT Prod. Posting Group")
        // {
        //     ShowMandatory = false;
        //     //  Editable = hideshowfields;
        //     Visible = hideshowfields and isVenderService or Unitcharges;
        // }
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
                    //Editable = true;
                    Editable = editablefalsefieldNonInventoryType;
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
                    // Editable = true;
                    Editable = editablefalsefieldNonInventoryType;
                }
            }

        }
        // addafter(Type)
        // {
        //     field("Select Unit Type"; Rec."Select Unit Type")
        //     {
        //         ApplicationArea = All;
        //         trigger OnValidate()
        //         begin
        //             UpdateGroupVisibility();
        //         end;

        //     }
        // }
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
                    //Visible = hideshowfields;
                }
            }
        }
        addafter(Item)
        {
            group(UnitManagement)
            {
                Visible = isUnitService;
                Caption = 'Unit Management';
                // Visible = IsUnitManagementVisible;
                field(FixedNumber; Rec.FixedNumber)
                {
                    ApplicationArea = All;
                    Caption = 'FixedNumber';
                    Editable = false;
                    Visible = false;
                }
                field("Country"; Rec.Country)
                {
                    ApplicationArea = All;
                    Caption = 'Country';
                    Lookup = true;
                    Editable = editablefalsefieldNonInventoryType;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec); // Call to auto-generate the Unit Name when Merge Units changes
                    end;

                }
                field(Emirate; Rec.Emirate)
                {
                    ApplicationArea = All;
                    Caption = 'Emirate';
                    Lookup = true;
                    Editable = editablefalsefieldNonInventoryType;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec); // Call to auto-generate the Unit Name when Merge Units changes
                    end;
                }
                field("Community"; Rec.Community)
                {
                    ApplicationArea = All;
                    Caption = 'Community';
                    Lookup = true;
                    Editable = editablefalsefieldNonInventoryType;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec); // Call to auto-generate the Unit Name when Merge Units changes
                    end;
                }
                field("Property ID"; Rec."Property ID") // OOB Field (or create custom if not OOB)
                {
                    ApplicationArea = All;
                    Caption = 'Property ID';
                    // ShowMandatory = true;
                    Editable = editablefalsefieldNonInventoryType;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec);
                    end;
                }

                field("Property Name"; Rec."Property Name") // Custom Field
                {
                    ApplicationArea = All;
                    Caption = 'Property Name';
                    Editable = false;
                }
                field("Floor Number"; Rec."Floor Number") // Custom Field
                {
                    ApplicationArea = All;
                    Caption = 'Floor Number';
                    //Editable = true;
                    Editable = editablefalsefieldNonInventoryType;
                }
                field("Unit Number"; Rec."Unit Number") // Custom Field
                {
                    ApplicationArea = All;
                    Caption = 'Unit Number';
                    // Editable = true;
                    Editable = editablefalsefieldNonInventoryType;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec); // Call to auto-generate the Unit Name when Merge Units changes
                    end;
                }

                field("Unit ID"; Rec.UnitID) // Auto-generated Unit ID
                {
                    ApplicationArea = All;
                    Caption = 'Unit ID';
                    Editable = false;
                }
                field("Unit Name"; Rec."Unit Name") // Custom Field
                {
                    ApplicationArea = All;
                    Caption = 'Unit Name';
                    Editable = false;
                }

                field("Usage Type"; rec."Usage Type")
                {
                    ApplicationArea = All;
                    Lookup = true;
                    Editable = false;
                }

                field("Unit Type"; rec."Unit Type")
                {
                    ApplicationArea = All;
                    Lookup = true;
                    Editable = editablefalsefieldNonInventoryType;
                }
                field("Unit Address"; rec."Unit Address")
                {
                    ApplicationArea = All;
                    Editable = editablefalsefieldNonInventoryType;
                }
                field("Merging/Splitting"; rec."MergeSplitOption")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Unit Status"; rec."Unit Status")
                {
                    ApplicationArea = All;
                    Lookup = true;
                }
            }
            part("Document Attachments"; "Unit Document SubPage")
            {
                SubPageLink = UnitID = FIELD("No."); // Link to filter attachments for this owner only
                ApplicationArea = All;
                // Visible = isVisible;
                Editable = editablefalsefieldNonInventoryType;
                Visible = ShowFinancialFields and isUnitService and isVisible;
            }
        }
        addafter("Item Category Code")
        {

        }

    }

    actions
    {
        modify(CopyItem)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                AutoGenerateUnitName(Rec);
            end;
        }
        addafter("Item Journal")
        {
            action("Add New Line")
            {
                ApplicationArea = All;
                // Promoted = true;
                Visible = isService;
                trigger OnAction()
                var
                    CustomLinesPage: Record "Revenue Structure Subpage";
                    CustomLinesPage2: Record "Revenue Structure";
                // DocumentUploadDetails: Record DocumentUploadDetails;
                begin
                    if CustomLinesPage.FindSet() then begin
                        CustomLinesPage.DeleteAll();
                        // DocumentUploadDetails.DeleteAll();
                    end;

                    if CustomLinesPage2.FindSet() then begin
                        CustomLinesPage2.DeleteAll();
                        // DocumentUploadDetails.DeleteAll();
                    end;
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

        Country: Text;
        Emirates: Text;
        Community: Text;
        Unitnumber: Text;
    begin
        // Fixed starting number for new records
        // FixedNumber := 101;

        // Get Property Name and Format it
        PropertyCode := FormatName(TargetItem."Property Name");

        // Convert Option fields to Text using Format
        Country := Format(TargetItem.Country); // Assuming Rec has an "Option" field for Country
        Emirates := Format(TargetItem.Emirate); // Assuming Rec has an "Option" field for Emirates
        Community := Format(TargetItem."Community"); // Assuming Rec has an "Option" field for Community
        Unitnumber := Format(TargetItem."Unit Number"); // Assuming "Unit Number" is a field in the record


        // Format Country, Emirates, and Community the same way as Property Name
        CountryCode := FormatName(Country);
        EmiratesCode := FormatName(Emirates);
        CommunityCode := FormatName(Community);
        UnitnumberCode := Format(Unitnumber); // Assuming "Unit Number" is a field in the record

        // Step 1: Generate Unit Name: PropertyCode-UnitType-FixedNumber
        TargetItem."Unit Name" := PropertyCode + '-SU-' + Format(TargetItem.FixedNumber); // Assuming 'SU' is the Unit Type for Single Unit

        // Step 2: Generate Unit ID: CountryCode-EmiratesCode-CommunityCode-PropertyCode-FixedNumber
        UnitID := CountryCode + '-' + EmiratesCode + '-' + CommunityCode + '-' + PropertyCode + '-' + UnitnumberCode;

        // Set the Unit ID in the record
        TargetItem.UnitID := UnitID;
        TargetItem.Modify();
    end;


    // Helper function to format the name
    procedure FormatName(Name: Text): Text
    var
        Words: List of [Text];
        Word: Text;
        Code: Text;
        i: Integer;
    begin
        // Split the Name into words
        Words := Name.Split(' '); // Split by space

        // Check if it's a single word or multiple words
        if Words.Count() = 1 then begin
            // For single-word names, use the first three letters
            Code := CopyStr(Words.Get(1), 1, 3);
        end else begin
            // For multi-word names, use the first letter of each word
            Code := '';
            for i := 1 to Words.Count() do begin
                Word := Words.Get(i);
                Code += CopyStr(Word, 1, 1); // Take the first letter of each word
            end;
        end;

        exit(Code); // Return the formatted code
    end;

    //-------------------------------------- Unit Management Page Extension ------------------------------------------//
    var
        isVisible: Boolean;
        isUnitService: Boolean;
        isVenderService: Boolean;


    procedure EvaluateFastTabVisibility(): Boolean
    begin
        if Rec."Item Template" = Enum::"Item Template Enum"::Service then begin
            if Rec."Item type template" = Enum::"Item Type Template Enum"::"Unit Service" then
                exit(true)
            else
                exit(false);
        end;
    end;

    procedure EvaluateFastTabVisibilityService(): Boolean
    begin
        if Rec."Item Template" = Enum::"Item Template Enum"::Service then begin
            if Rec."Item type template" = Enum::"Item Type Template Enum"::"Vendor Service" then
                exit(true)
            else
                exit(false);
        end;
    end;

    procedure UnitChargesFieldsVisiblity(): Boolean
    begin
        if Rec."Item Template" = Enum::"Item Template Enum"::Service then begin
            if Rec."Item type template" = Enum::"Item Type Template Enum"::"Secondary Item" then
                exit(true)
            else
                exit(false);
        end;
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
        if Rec."Property Name" = '' then begin
            exit; // Default value for new records
        end
        else if Rec."Property Name" <> '' then begin
            AutoGenerateUnitName(Rec); // Call to auto-generate the Unit Name when a new record is inserted
        end;
    end;

    trigger OnAfterGetRecord()
    // UpdateGroupVisibility();
    begin
        CurrPage."Document Attachments".Page.SetUnitId(Rec."No.");
        if Format(Rec."No.") <> '' then begin
            isVisible := true;
        end
        else begin
            isVisible := false;
        end;
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
        documentattachment: Codeunit UploadAttachment;

        hideshowfields: Boolean;
        editablefalsefieldNonInventoryType: Boolean;

        Unitcharges: Boolean;

    local procedure IsUserInProfile(ProfileID: Code[20]): Boolean
    var
        AccessControl: Record "User Personalization";
    begin
        AccessControl.SetRange("User ID", UserId());
        AccessControl.SetRange("Profile ID", ProfileID);
        exit(AccessControl.FindFirst());
    end;



}