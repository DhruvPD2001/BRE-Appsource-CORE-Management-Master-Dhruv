table 50701 "testData"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Company ID";

    fields
    {
        field(50100; "Company ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(50101; "Company Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50103; "Company Logo"; Text[50])
        {
            DataClassification = ToBeClassified;

        }

        field(50104; "Logo URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Logo URL';
        }
        field(50108; "View Document URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Document URL';
        }
        field(50109; "Tenant id"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Document URL';
            Editable = false;
        }
        field(50110; "Environment Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Environment Name';
            Editable = false;
        }

        field(50111; "Access Validity"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Access Validity (Days)';
            Editable = true;
        }
        field(50112; "API URL"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'API URL';
            Editable = true;
        }
        field(50113; "Revenue Methods"; Option)
        {
            OptionMembers = " ","Fixed Monthly Rent","Per Day Rent";
            Caption = 'Revenue Methods';
        }
    }

    keys
    {
        key(PK; "Company ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Company ID", "Company Name")
        {

        }
    }

    //--------------Record Insertion-----------------//
    trigger OnInsert()
    var
        CompanyInfo: Record "Company Information";
        Msg: Label 'Tenant Id is ''%1''.\Tenant Guid is ''%2''.';
        BCURLList: List of [Text];
        TenantIdTxt: Text;
        TenantGuidTxt: Text;
        EnvironmentNameTxt: Text;

    begin
        if CompanyInfo.Get() then
            "Company Name" := CompanyInfo.Name;

        // // Assign the Tenant ID to the "Tenant id" field
        // "Tenant id" := Database.TenantId();
        TenantIdTxt := TenantId();
        BCURLList := GetUrl(ClientType::Web).Split('/');
        TenantGuidTxt := BCURLList.Get(4);
        EnvironmentNameTxt := BCURLList.Get(5);

        // Store the Tenant GUID in the "Tenant id" field
        "Tenant id" := TenantGuidTxt;
        "Environment Name" := EnvironmentNameTxt;

        Message(Msg, TenantIdTxt, TenantGuidTxt, EnvironmentNameTxt);
    end;



    //--------------Record Insertion-----------------//
}