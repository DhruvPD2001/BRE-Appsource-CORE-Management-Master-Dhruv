namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

using Microsoft.Foundation.Attachment;

page 50718 DocumentAttachment
{
    APIGroup = 'payment';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'documentAttachment';
    DelayedInsert = true;
    EntityName = 'documentAttachment';
    EntitySetName = 'documentAttachments';
    PageType = API;
    ODataKeyFields = SystemId;
    SourceTable = "Document Attachment";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(attachedBy; Rec."Attached By")
                {
                    Caption = 'Attached By';
                }
                field(attachedDate; Rec."Attached Date")
                {
                    Caption = 'Attached Date';
                }
                field(documentBLOB; Rec."Document BLOB")
                {
                    Caption = 'Document BLOB';
                }
                field(documentFile; Rec."Document File")
                {
                    Caption = 'Document File';
                }
                field(documentFlowPurchase; Rec."Document Flow Purchase")
                {
                    Caption = 'Flow to Purch. Trx';
                }
                field(documentFlowSales; Rec."Document Flow Sales")
                {
                    Caption = 'Flow to Sales Trx';
                }
                field(documentFlowService; Rec."Document Flow Service")
                {
                    Caption = 'Flow to Service Trx';
                }
                field(documentName; Rec."Document Name")
                {
                    Caption = 'Document Name';
                }
                field(documentReferenceID; Rec."Document Reference ID")
                {
                    Caption = 'Document Reference ID';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(documentMedia; Rec.DocumentMedia)
                {
                    Caption = 'DocumentMedia';
                }
                field(fieldNo; Rec."Field No.")
                {
                    Caption = 'Field No.';
                }
                field(fileExtension; Rec."File Extension")
                {
                    Caption = 'File Extension';
                }
                field(fileName; Rec."File Name")
                {
                    Caption = 'Attachment';
                }
                field(fileType; Rec."File Type")
                {
                    Caption = 'File Type';
                }
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(mimeType; Rec."MIME Type")
                {
                    Caption = 'MIME Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field("recordId"; Rec."Record Id")
                {
                    Caption = 'Record Id';
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
                field(tableID; Rec."Table ID")
                {
                    Caption = 'Table ID';
                }
                field(tableName; Rec."Table Name")
                {
                    Caption = 'Table Name';
                }
                field(uploadDocument; Rec."Upload Document")
                {
                    Caption = 'Upload Document';
                }
                field(uploadDocumentType; Rec."Upload Document Type")
                {
                    Caption = 'Upload Document Type';
                }
                field(user; Rec.User)
                {
                    Caption = 'User';
                }
                field(vatReportConfigCode; Rec."VAT Report Config. Code")
                {
                    Caption = 'VAT Report Config. Code';
                }
            }
        }
    }
}
