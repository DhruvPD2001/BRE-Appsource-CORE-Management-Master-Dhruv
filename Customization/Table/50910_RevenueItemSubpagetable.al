table 50910 "Revenue Item Subpage"
{
    DataClassification = ToBeClassified;


    fields
    {
        field(50100; "ProposalID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Proposal ID';
        }

        field(50101; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item';
            TableRelation = Item WHERE("Item type template" = const("Item Type Template Enum"::"Secondary Item"), "Charges Status" = CONST("Regular Charges"));
            // TableRelation = "Secondary Item"."Secondary Item Type";

            trigger OnValidate()
            var
                SecondaryItemRec: Record "Item";
            begin
                // Check if a record with the selected Secondary Item Type exists
                SecondaryItemRec.SetRange("No.", Rec."Secondary Item Type");
                if SecondaryItemRec.FindFirst() then begin
                    // Retrieve the VAT % from the Secondary Item record
                    "Secondary Item Type" := SecondaryItemRec.Description;
                    "VAT %" := SecondaryItemRec."VAT %";
                end else begin
                    // Clear the VAT % field if no matching record is found
                    "VAT %" := 0;
                end;
            end;


        }

        field(50102; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';

            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;

        }

        field(50103; "VAT %"; Option)
        {
            OptionMembers = "0%","5%";
            Caption = 'VAT %';
            Editable = false;

            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }

        field(50104; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
            Editable = false;

            trigger OnValidate()
            var
                vatPer: Integer;
            begin
                if "VAT %" = "VAT %"::"5%" then
                    vatPer := 5
                else
                    vatPer := 0;

                "VAT Amount" := Amount * (vatPer / 100);
            end;

        }

        field(50105; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
            Editable = false;

            trigger OnValidate()
            begin
                "Amount Including VAT" := Amount + "VAT Amount";
            end;
        }

        field(50106; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
            Editable = True;
        }

        field(50107; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
            Editable = True;
        }

        // field(50108; "No. of Installments"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'No. of Installments';
        // }

        field(50109; "Generate Payment Schedule"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Generate Payment Schedule';
            InitValue = 'Generate Payment Schedule';

        }
        field(50110; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(50111; "Payment Type"; Option)
        {
            OptionMembers = "","One Time Payment","Installment";
            Caption = 'Payment Type';


        }


        field(50113; "Link"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Link';
            Editable = false;
            //InitValue = 'link';


        }

        field(50114; "TenantID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(50116; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50117; "Unit Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50118; "Unit Size"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50119; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.", ProposalID)
        {
            Clustered = true;
        }
    }





    //--------------Method to calculate VAT Amount and Amount Including VAT-----------------//
    local procedure CalcVATAndTotal()
    var
        vatPer: Integer;
    begin
        if "VAT %" = "VAT %"::"5%" then
            vatPer := 5
        else
            vatPer := 0;

        "VAT Amount" := Amount * (vatPer / 100);
        "Amount Including VAT" := Amount + "VAT Amount";
    end;

    //--------------Method to calculate VAT Amount and Amount Including VAT-----------------//
}
