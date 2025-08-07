namespace PropertyManagement.PropertyManagement;
using System.Utilities;
report 50106 ContractMasterData
{
    ApplicationArea = All;
    Caption = 'ContractMasterData';
    UsageCategory = ReportsAndAnalysis;
    ExcelLayout = 'Contract MasterData.xlsx';
    DefaultLayout = Excel;
    dataset
    {
        dataitem(TenancyContract; "Tenancy Contract")
        {
            column(Report_Period; CustomDateRangeText)
            {
            }
            column(Contract_ID; "Contract ID")
            {
            }
            column(Owner_s_Name; "Owner's Name")
            {
            }
            column(Customer_Name; "Customer Name")
            {
            }
            column(Contract_Start_Date; ContractStartDateText)
            {
            }
            column(Contract_End_Date; ContractEndDateText)
            {
            }
            column(Contract_Type; ContractTypeFormatted)
            {
            }
            column(Proposal_ID; ProposalInfoText)
            {
            }
            column(Contract_Tenor; "Contract Tenor")
            {
            }
            column(Tenant_Contract_Status; TenantStatusFormatted)
            {
            }
            column(Contract_Amount; "Annual Rent Amount")
            {
            }
            column(Annual_Rent_Amount; "Rent Amount")
            {
            }
            column(Security_Deposit_Amount; "Security Deposit Amount")
            {
            }
            column(Property_Name; "Property Name")
            {
            }
            column(Unit_Name; "Unit Name")
            {
            }
            column(UnitID; UnitIDFormatted)
            {
            }
            column(Unit_Number; "Unit Number")
            {
            }
            column(UnitArea_Sq_Feet; "Unit Sq. Feet")
            {
            }
            column(Unit_Usage_Type; "Usage Type")
            {
            }
            column(Suspension_Date; SuspensionDateText)
            {
            }
            column(Suspended_Reason_list; SuspensionReasonText)
            {
            }
            column(Termination_Date; TerminationDateText)
            {
            }
            column(Grace_Start_Date; GraceStartDateText)
            {
            }
            column(Grace_End_Date; GraceEndDateText)
            {
            }
            column(Grace_Period; "Grace Period")
            {
            }
            dataitem("Final Calculation"; "Final Calculation")
            {
                DataItemLink = "Contract ID" = field("Contract ID");
                trigger OnAfterGetRecord()
                begin
                    if "Termination Date" = 0D then
                        TerminationDateText := '-'
                    else
                        TerminationDateText := Format("Termination Date", 0, '<Day,2>/<Month,2>/<Year4>');
                end;

                trigger OnPreDataItem()
                begin
                    if IsEmpty then
                        TerminationDateText := '-';
                end;
            }
            trigger OnAfterGetRecord()
            var
                SuspensionReasonRec: Record SuspendReasonTable;
                FinalCalc: Record "Final Calculation";
                StartDateIsInRange: Boolean;
                EndDateIsInRange: Boolean;
            begin
                TerminationDateText := '-';
                CustomDateRangeText :=
                    Format(CustomStartDatevar, 0, '<Day,2>/<Month,2>/<Year4>') + ' - ' +
                    Format(CustomEndDatevar, 0, '<Day,2>/<Month,2>/<Year4>');
                StartDateIsInRange := ("Contract Start Date" >= CustomStartDatevar) and ("Contract Start Date" <= CustomEndDatevar);
                EndDateIsInRange := ("Contract End Date" >= CustomStartDatevar) and ("Contract End Date" <= CustomEndDatevar);
                if not (StartDateIsInRange or EndDateIsInRange) then
                    CurrReport.SKIP();
                FinalCalc.Reset();
                FinalCalc.SetRange("Contract ID", "Contract ID");
                if FinalCalc.FindFirst() then
                    if FinalCalc."Termination Date" = 0D then
                        TerminationDateText := '-'
                    else
                        TerminationDateText := Format(FinalCalc."Termination Date", 0, '<Day,2>/<Month,2>/<Year4>');
                SuspensionStartDate := 0D;
                SuspensionReasonText := '';
                SuspensionReasonRec.Reset();
                SuspensionReasonRec.SetRange("Contract ID", "Contract ID");
                if SuspensionReasonRec.FindFirst() then begin
                    SuspensionStartDate := SuspensionReasonRec.DateEffective;
                    SuspensionReasonText := Format(SuspensionReasonRec.Reason);
                end;
                case "Contract Type" of
                    "Contract Type"::"New Contract":
                        ProposalInfoText := 'Proposal ID: ' + Format("Proposal ID");
                    "Contract Type"::"Renewal Contract":
                        ProposalInfoText := 'ContractRenewal ID: ' + Format("Renewal Proposal ID");
                    else
                        ProposalInfoText := '-';
                end;
                if Format("Contract ID") = '' then
                    "Contract ID" := '-';
                if Format("Owner's Name") = '' then
                    "Owner's Name" := '-';
                if Format("Customer Name") = '' then
                    "Customer Name" := '-';
                if "Contract Start Date" = 0D then
                    ContractStartDateText := '-'
                else
                    ContractStartDateText := Format("Contract Start Date", 0, '<Day,2>/<Month,2>/<Year4>');
                if "Contract End Date" = 0D then
                    ContractEndDateText := '-'
                else
                    ContractEndDateText := Format("Contract End Date", 0, '<Day,2>/<Month,2>/<Year4>');
                if "Contract Type" = "Contract Type"::" " then
                    ContractTypeFormatted := '-'
                else
                    ContractTypeFormatted := Format("Contract Type");
                if Format("Contract Tenor") = '' then
                    "Contract Tenor" := '-';
                if "Tenant Contract Status" = "Tenant Contract Status"::" " then
                    TenantStatusFormatted := '-'
                else
                    TenantStatusFormatted := Format("Tenant Contract Status");
                if "Annual Rent Amount" = 0 then
                    "Annual Rent Amount" := 0;
                if "Rent Amount" = 0 then
                    "Rent Amount" := 0;
                if "Security Deposit Amount" = 0 then
                    "Security Deposit Amount" := 0;
                if Format("Property Name") = '' then
                    "Property Name" := '-';
                if Format("Unit Name") = '' then
                    "Unit Name" := '-';
                if "Unit ID" = '' then
                    UnitIDFormatted := '-'
                else
                    UnitIDFormatted := "Unit ID";
                if Format("Unit Number") = '' then
                    "Unit Number" := '-';
                if Format("Unit Sq. Feet") = '' then
                    "Unit Sq. Feet" := '-';
                if Format("Usage Type") = '' then
                    "Usage Type" := '-';
                if SuspensionStartDate = 0D then
                    SuspensionDateText := '-'
                else
                    SuspensionDateText := Format(SuspensionStartDate, 0, '<Day,2>/<Month,2>/<Year4>');
                if SuspensionReasonText = '' then
                    SuspensionReasonText := '-';
                if "Grace Start Date" = 0D then
                    GraceStartDateText := '-'
                else
                    GraceStartDateText := Format("Grace Start Date", 0, '<Day,2>/<Month,2>/<Year4>');
                if "Grace End Date" = 0D then
                    GraceEndDateText := '-'
                else
                    GraceEndDateText := Format("Grace End Date", 0, '<Day,2>/<Month,2>/<Year4>');
                if "Grace Period" = 0 then
                    "Grace Period" := 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(DateFilter)
                {
                    field(CustomStartDate; CustomStartDatevar)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Start Date';
                    }
                    field(CustomEndDate; CustomEndDatevar)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'End Date';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        CustomStartDatevar: Date;
        CustomEndDatevar: Date;
        CustomDateRangeText: Text;
        ProposalInfoText: Text;
        SuspensionStartDate: Date;
        ContractTypeFormatted: Text;
        TenantStatusFormatted: Text;
        UnitIDFormatted: Text;
        ContractStartDateText: Text;
        ContractEndDateText: Text;
        GraceStartDateText: Text;
        GraceEndDateText: Text;
        SuspensionDateText: Text;
        SuspensionReasonText: Text;
        TerminationDateText: Text;
}
