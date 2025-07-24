table 50111 "Adjustment Security Deposit"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = ID;

    fields
    {
        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }

        field(50101; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            TableRelation = "Tenancy Contract"."Contract ID";

            trigger OnValidate()
            var
                ContractRec: Record "Tenancy Contract";
                AdjustSecurityDeposit: Record "Adjustment Security Deposit";
            begin
                // First check if this contract is already used
                AdjustSecurityDeposit.Reset();
                AdjustSecurityDeposit.SetRange("Contract ID", Rec."Contract ID");
                if not AdjustSecurityDeposit.IsEmpty() then
                    Error('This Contract ID %1 is already used in another record.', Rec."Contract ID");


                // If contract is not used, then proceed with existing logic
                ContractRec.SetRange("Contract ID", "Contract ID");
                if ContractRec.Get() then begin
                    Rec."Main Security Deposit" := ContractRec."Security Deposit Amount";
                    Rec."Security Deposit" := ContractRec."Security Balanced Amount";
                    Rec."Contract Start Date" := ContractRec."Contract Start Date";
                    Rec."Contract End Date" := ContractRec."Contract End Date";
                end;
            end;
        }

        field(50102; "Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Security Deposit';
            Editable = false;
        }

        field(50103; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
            Editable = false;
        }

        field(50104; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
            Editable = false;
        }

        field(50105; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,Approved'; // Include an empty option for flexibility
            OptionMembers = Pending,Approved;
        }

        field(50106; "Security Amount Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Adjust Installment,Termination Charges,All Charges'; // Empty option
            OptionMembers = " ","Adjust Installment","Termination Charges","All Charges";


            trigger OnValidate()
            var
                TermChargesGrid: Record "Additional Charges Sub"; // Your actual grid table name
                TotalAmount: Decimal;
                TotalVATAmount: Decimal;
                TotalAmountInclVAT: Decimal;
            begin
                if Rec."Security Amount Status" = Rec."Security Amount Status"::"Termination Charges" then begin
                    // Check if Contract ID is selected
                    if Rec."Contract ID" = 0 then
                        Error('Please select a Contract ID first');

                    // Clear previous values
                    Clear(TotalAmount);
                    Clear(TotalVATAmount);
                    Clear(TotalAmountInclVAT);

                    // Get the termination charges grid data for this contract
                    TermChargesGrid.Reset();
                    TermChargesGrid.SetRange("Contract ID", Rec."Contract ID");

                    if TermChargesGrid.FindSet() then begin
                        repeat
                            // Sum up the amounts from grid
                            TotalAmount += TermChargesGrid.Amount;
                            TotalVATAmount += TermChargesGrid."VAT Amount";
                            TotalAmountInclVAT += TermChargesGrid."Amount Including VAT";
                        until TermChargesGrid.Next() = 0;

                        // Set the totals
                        Rec.Amount := TotalAmount;
                        Rec."VAT Amount" := TotalVATAmount;
                        Rec."Amount Including VAT" := TotalAmountInclVAT;
                    end;
                end;
            end;
        }

        field(50107; "Payment Series"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';

            // Trasfer from Table Start  
            // trigger OnLookup()
            // var
            //     PaymentMode2Rec: Record "Payment Mode2";
            //     Selection: Page "Payment Mode2 List";
            //     SelectedPaymentSeries: Text[250];
            //     TotalAmount: Decimal;
            //     TotalVATAmount: Decimal;
            //     TotalAmountInclVAT: Decimal;
            // begin
            //     // First check if Contract ID is selected
            //     if Rec."Contract ID" = 0 then
            //         Error('Please select a Contract ID first');

            //     // Filter Payment Mode2 records based on Contract ID
            //     PaymentMode2Rec.Reset();
            //     PaymentMode2Rec.SetRange("Contract ID", Rec."Contract ID");

            //     Selection.LookupMode(true);
            //     Selection.SetTableView(PaymentMode2Rec);

            //     if Selection.RunModal() = ACTION::LookupOK then begin
            //         // Clear totals
            //         Clear(TotalAmount);
            //         Clear(TotalVATAmount);
            //         Clear(TotalAmountInclVAT);
            //         Clear(SelectedPaymentSeries);

            //         Selection.SetSelectionFilter(PaymentMode2Rec);
            //         if PaymentMode2Rec.FindSet() then begin
            //             repeat
            //                 // Add to payment series string
            //                 if SelectedPaymentSeries <> '' then
            //                     SelectedPaymentSeries := SelectedPaymentSeries + ',';
            //                 SelectedPaymentSeries := SelectedPaymentSeries + PaymentMode2Rec."Payment Series";

            //                 // Sum up amounts
            //                 TotalAmount += PaymentMode2Rec.Amount;
            //                 TotalVATAmount += PaymentMode2Rec."VAT Amount";
            //                 TotalAmountInclVAT += PaymentMode2Rec."Amount Including VAT";
            //             until PaymentMode2Rec.Next() = 0;

            //             // Set all values to the record
            //             Rec."Payment Series" := SelectedPaymentSeries;
            //             Rec.Amount := TotalAmount;
            //             Rec."VAT Amount" := TotalVATAmount;
            //             Rec."Amount Including VAT" := TotalAmountInclVAT;
            //         end;
            //     end;
            // end;
            // Trasfer from Table End
        }
        field(50108; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(50109; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
        }
        field(50110; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
        }
        field(50111; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }
        field(50112; "Main Security Deposit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Main Security Deposit';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }


}
