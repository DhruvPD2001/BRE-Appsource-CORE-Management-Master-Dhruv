table 50901 "Final Calculation"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50112; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(50113; "ContractYear(Termination Date)"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Year On Termination Date';
        }
        field(50101; "FC ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50104; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';
        }
        field(50105; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';
        }
        field(50102; "Unit Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Type';
        }
        field(50103; "Contract Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount';
        }
        field(50109; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
            TableRelation = "Lease Proposal Details"."Tenant ID";
        }
        field(50106; "Intimation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Intimation Date';
        }
        field(50107; "Termination Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Termination Date';
            trigger OnValidate()
            var
            begin
                if ("Contract End Date" = "Termination Date") then
                    "Termination Status" := "Termination Status"::"Regular Termination"
                else
                    if ("Contract End Date" > "Termination Date") then
                        "Termination Status" := "Termination Status"::"Early Termination"
                    else
                        Error('Termination Date cannot be greater than Contract End Date.');
            end;
        }
        field(50110; "Original Contract Tenure"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Original Contract Tenure';
        }
        field(50111; "Actual Contract Tenure"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Actual Contract Tenure';
        }
        field(50114; "Total No. Of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total No. Of Days(Termination Year)';
        }
        field(50115; "Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Per Day Rent(Termination Year)';
        }
        field(50116; "Annual Rent Amount TermiYear"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Annual Rent Amount of Termination Year';
        }
        field(50117; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,Approved;
        }
        field(50118; "Security Deposit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Security Deposit';
        }
        field(50119; "Adjustment Security Deposit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Adjustment Security Deposit';
        }
        field(50120; "Net Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Net Balance';
        }
        field(50121; "Chiller Deposit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Chiller Deposit';
        }
        field(50122; "Other Deposit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Deposit';
        }
        field(50123; "Termination Status"; Option)
        {
            OptionMembers = " ","Regular Termination","Early Termination","Suspension to Termination";
            Editable = false;
        }
        field(50124; "Total Refundable Deposit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50125; "Total Claim"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Claim';
        }
        field(50126; "Total Refund"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Refund';
        }
        field(50127; "Summery Net Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Net Balance';
        }
        field(50128; "Amount Refundable"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Refundable To The Tenant';
        }
        field(50129; "Net Receivable From The Tenant"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Net Receivable From The Tenant';
        }
        field(50137; "Total Receive"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Receive';
        }
        field(50130; "Final Calculation Document"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Calculation Document';
            InitValue = 'Final Calculation Document';
        }
        field(50131; "Total Adjustment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Adjustment';
        }
        field(50132; "Final Calculation URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Calculaion URL';
        }
        field(50133; "Tenant Email"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Email';
        }
        field(50134; "Tenant Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Name';
        }
        field(50135; "Credit Note Document"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note Document';
            InitValue = 'Credit Note Document';
        }
        field(50136; "Credit Note URL"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note View';
            InitValue = 'Credit Note View';
        }
    }
    keys
    {
        key(PK; "FC ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Contract ID", "FC ID")
        {
        }
    }
    trigger OnDelete()
    var
    begin
        deletefinalrevenuecalculation();
        deletebillingcaculation();
        PendingreceivablePayable();
        TerminationAdditionalCharges();
        RentCalculationGrid();
        RevenueStructureGrid();
        RevenueStructureyearlyBrokdownGrid();
        finalsettlement();
        finalsettlementrefund();
    end;

    procedure deletefinalrevenuecalculation()
    var
        finalrevenuecalculation: Record "Final Revenue Calculation Grid";
    begin
        finalrevenuecalculation.SetRange("Contract Id", Rec."Contract ID");
        if finalrevenuecalculation.FindSet() then
            finalrevenuecalculation.DeleteAll();
    end;

    procedure deletebillingcaculation()
    var
        billingcalculation: Record "Final Billing Calculation Grid";
    begin
        billingcalculation.SetRange("Contract ID", rec."Contract ID");
        if billingcalculation.FindSet() then
            billingcalculation.DeleteAll();
    end;

    procedure PendingreceivablePayable()
    var
        pendingRecevieable: Record "Pending Receviable Grid";
    begin
        pendingRecevieable.SetRange("Contract ID", Rec."Contract ID");
        if pendingRecevieable.FindSet() then
            pendingRecevieable.DeleteAll();
    end;

    procedure TerminationAdditionalCharges()
    var
        TerminationAdditional: Record "Additional Charges Sub";
    begin
        TerminationAdditional.SetRange("Contract ID", Rec."Contract ID");
        if TerminationAdditional.FindSet() then
            TerminationAdditional.DeleteAll();
    end;

    procedure RentCalculationGrid()
    var
        RentCalculation: Record "Rent Calculate Sub";
    begin
        RentCalculation.SetRange("Contract ID", Rec."Contract ID");
        if RentCalculation.FindSet() then
            RentCalculation.DeleteAll();
    end;

    procedure RevenueStructureGrid()
    var
        RevenueStructureyearlyBrokdown: Record "Other Payment Calculate Sub";
    begin
        RevenueStructureyearlyBrokdown.SetRange("Contract ID", Rec."Contract ID");
        if RevenueStructureyearlyBrokdown.FindSet() then
            RevenueStructureyearlyBrokdown.DeleteAll();
    end;

    procedure RevenueStructureyearlyBrokdownGrid()
    var
        RevenueStructure: Record "Revenue Calculate Sub";
    begin
        RevenueStructure.SetRange("Contract ID", Rec."Contract ID");
        if RevenueStructure.FindSet() then
            RevenueStructure.DeleteAll();
    end;

    procedure Deletepaymentdetails()
    var
        paymentdetails: Record "Payment Details";
    begin
        paymentdetails.SetRange("Contract ID", Rec."Contract ID");
        if paymentdetails.FindSet() then
            paymentdetails.DeleteAll();
    end;

    procedure finalsettlement()
    var
        finalsettlementRec: Record FinalSettlement;
    begin
        finalsettlementRec.SetRange("FC Id", Rec."FC ID");
        if finalsettlementRec.FindSet() then
            finalsettlementRec.DeleteAll();
    end;

    procedure finalsettlementrefund()
    var
        finalsettlementrefundRec: Record FinalSettlementRefund;
    begin
        finalsettlementrefundRec.SetRange("FC Id", Rec."FC ID");
        if finalsettlementrefundRec.FindSet() then
            finalsettlementrefundRec.DeleteAll();
    end;
}
