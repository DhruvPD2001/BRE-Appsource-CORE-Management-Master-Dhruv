table 50509 "PDC Approval"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = SystemId;
    fields
    {
        field(50501; Id; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50509; Status; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50510; "PDC Id"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50502; Tenant_Id; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50503; Contract_Id; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50504; Check_No; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50505; Deposite_Bank; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50506; Total_Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50507; Due_Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50508; View; Text[2048])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; Id)
        {
            Clustered = true;
        }
    }

}