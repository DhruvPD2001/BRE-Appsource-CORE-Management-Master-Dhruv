table 50510 "Payment Transaction"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "PT Id";
    fields
    {
        field(50501; "PT Id"; Code[50])
        {
            DataClassification = ToBeClassified;

        }

        field(50502; "Tenant Id"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(50503; "Tenant Name"; Text[100])
        {

            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Tenant Id"))); // Displays Customer Name
        }

        field(50504; "Contract Id"; Integer)
        {

            TableRelation = "Tenancy Contract";
        }

        field(50505; "Approval Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "PT Id")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";

    begin
        if "PT Id" = '' then
            "PT Id" := NoSeriesMgt.GetNextNo('PT-ID', Today(), true);
    end;


}