namespace PropertyManagement.PropertyManagement;

using Microsoft.Bank.BankAccount;

page 50713 BankAccountFetch
{
    APIGroup = 'payment';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'bankAccountFetch';
    DelayedInsert = true;
    EntityName = 'bankAccount';
    EntitySetName = 'bankAccounts';
    PageType = API;
    SourceTable = "Bank Account";
    ODataKeyFields = SystemId;
    ModifyAllowed = true;
    DeleteAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(automaticStmtImportEnabled; Rec."Automatic Stmt. Import Enabled")
                {
                    Caption = 'Automatic Stmt. Import Enabled';
                }
                field(balance; Rec.Balance)
                {
                    Caption = 'Balance';
                }
                field(balanceLCY; Rec."Balance (LCY)")
                {
                    Caption = 'Balance (LCY)';
                }
                field(balanceLastStatement; Rec."Balance Last Statement")
                {
                    Caption = 'Balance Last Statement';
                }
                field(balanceAtDate; Rec."Balance at Date")
                {
                    Caption = 'Balance at Date';
                }
                field(balanceAtDateLCY; Rec."Balance at Date (LCY)")
                {
                    Caption = 'Balance at Date (LCY)';
                }
                field(bankAccPostingGroup; Rec."Bank Acc. Posting Group")
                {
                    Caption = 'Bank Acc. Posting Group';
                }
                field(bankAccountNo; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                }
                field(bankBranchNo; Rec."Bank Branch No.")
                {
                    Caption = 'Bank Branch No.';
                }
                field(bankClearingCode; Rec."Bank Clearing Code")
                {
                    Caption = 'Bank Clearing Code';
                }
                field(bankClearingStandard; Rec."Bank Clearing Standard")
                {
                    Caption = 'Bank Clearing Standard';
                }
                field(bankStatementImportFormat; Rec."Bank Statement Import Format")
                {
                    Caption = 'Bank Statement Import Format';
                }
                field(bankStmtServiceRecordID; Rec."Bank Stmt. Service Record ID")
                {
                    Caption = 'Bank Stmt. Service Record ID';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(chainName; Rec."Chain Name")
                {
                    Caption = 'Chain Name';
                }
                field(checkReportID; Rec."Check Report ID")
                {
                    Caption = 'Check Report ID';
                }
                field(checkReportName; Rec."Check Report Name")
                {
                    Caption = 'Check Report Name';
                }
                field(checkTransmitted; Rec."Check Transmitted")
                {
                    Caption = 'Check Transmitted';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(contact; Rec.Contact)
                {
                    Caption = 'Contact';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(creditAmount; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                }
                field(creditAmountLCY; Rec."Credit Amount (LCY)")
                {
                    Caption = 'Credit Amount (LCY)';
                }
                field(creditTransferMsgNos; Rec."Credit Transfer Msg. Nos.")
                {
                    Caption = 'Credit Transfer Msg. Nos.';
                }
                field(creditorNo; Rec."Creditor No.")
                {
                    Caption = 'Creditor No.';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(debitAmount; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                }
                field(debitAmountLCY; Rec."Debit Amount (LCY)")
                {
                    Caption = 'Debit Amount (LCY)';
                }
                field(directDebitMsgNos; Rec."Direct Debit Msg. Nos.")
                {
                    Caption = 'Direct Debit Msg. Nos.';
                }
                field(disableAutomaticPmtMatching; Rec."Disable Automatic Pmt Matching")
                {
                    Caption = 'Disable Automatic Payment Matching';
                }
                field(disableBankRecOptimization; Rec."Disable Bank Rec. Optimization")
                {
                    Caption = 'Disable Bank Reconciliation Optimization';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }
                field(formatRegion; Rec."Format Region")
                {
                    Caption = 'Format Region';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(iban; Rec.IBAN)
                {
                    Caption = 'IBAN';
                }
                field(image; Rec.Image)
                {
                    Caption = 'Image';
                }
                field(intercompanyEnable; Rec.IntercompanyEnable)
                {
                    Caption = 'Enable for Intercompany transactions';
                }
                field(languageCode; Rec."Language Code")
                {
                    Caption = 'Language Code';
                }
                field(lastCheckNo; Rec."Last Check No.")
                {
                    Caption = 'Last Check No.';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(lastPaymentStatementNo; Rec."Last Payment Statement No.")
                {
                    Caption = 'Last Payment Statement No.';
                }
                field(lastStatementNo; Rec."Last Statement No.")
                {
                    Caption = 'Last Statement No.';
                }
                field(matchToleranceType; Rec."Match Tolerance Type")
                {
                    Caption = 'Match Tolerance Type';
                }
                field(matchToleranceValue; Rec."Match Tolerance Value")
                {
                    Caption = 'Match Tolerance Value';
                }
                field(minBalance; Rec."Min. Balance")
                {
                    Caption = 'Min. Balance';
                }
                field(mobilePhoneNo; Rec."Mobile Phone No.")
                {
                    Caption = 'Mobile Phone No.';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                }
                field(netChange; Rec."Net Change")
                {
                    Caption = 'Net Change';
                }
                field(netChangeLCY; Rec."Net Change (LCY)")
                {
                    Caption = 'Net Change (LCY)';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(ourContactCode; Rec."Our Contact Code")
                {
                    Caption = 'Our Contact Code';
                }
                field(paymentExportFormat; Rec."Payment Export Format")
                {
                    Caption = 'Payment Export Format';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(pmtRecNoSeries; Rec."Pmt. Rec. No. Series")
                {
                    Caption = 'Payment Reconciliation No. Series';
                }
                field(positivePayExportCode; Rec."Positive Pay Export Code")
                {
                    Caption = 'Positive Pay Export Code';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(sepaDirectDebitExpFormat; Rec."SEPA Direct Debit Exp. Format")
                {
                    Caption = 'SEPA Direct Debit Exp. Format';
                }
                field(swiftCode; Rec."SWIFT Code")
                {
                    Caption = 'SWIFT Code';
                }
                field(searchName; Rec."Search Name")
                {
                    Caption = 'Search Name';
                }
                field(statisticsGroup; Rec."Statistics Group")
                {
                    Caption = 'Statistics Group';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(telexAnswerBack; Rec."Telex Answer Back")
                {
                    Caption = 'Telex Answer Back';
                }
                field(telexNo; Rec."Telex No.")
                {
                    Caption = 'Telex No.';
                }
                field(territoryCode; Rec."Territory Code")
                {
                    Caption = 'Territory Code';
                }
                field(totalOnChecks; Rec."Total on Checks")
                {
                    Caption = 'Total on Checks';
                }
                field(transactionImportTimespan; Rec."Transaction Import Timespan")
                {
                    Caption = 'Transaction Import Timespan';
                }
                field(transitNo; Rec."Transit No.")
                {
                    Caption = 'Transit No.';
                }
                field(useAsDefaultForCurrency; Rec."Use as Default for Currency")
                {
                    Caption = 'Use as Default for Currency';
                }
            }
        }
    }
}
