codeunit 50953 "Check Field"
{
    procedure SkipField(var pField: Record Field): Boolean
    begin
        case
        pField.FieldName of
            'Line No.':
                exit(true);
            'Header No.':
                exit(true);
            'RR_No.':
                exit(true);
            'Entry No.':
                exit(true);
            '$systemId':
                exit(true);
            'SystemCreatedAt':
                exit(true);
            'SystemCreatedBy':
                exit(true);
            'SystemModifiedAt':
                exit(true);
            'SystemModifiedBy':
                exit(true);
            else begin
                exit(false);
            end;
        end;
    end;

    procedure SkipTotalField(var pField: Record Field): Boolean
    begin
        case
        pField.FieldName of
            'Contract ID':
                exit(true);
            'Contract Id':
                exit(true);
            'Line No.':
                exit(true);
            'Header No.':
                exit(true);
            'RR_No.':
                exit(true);
            'Entry No.':
                exit(true);
            'Grace Days':
                exit(true);
            'Posting Year':
                exit(true);
            'No Of Days':
                exit(true);
            '$systemId':
                exit(true);
            'SystemCreatedAt':
                exit(true);
            'SystemCreatedBy':
                exit(true);
            'SystemModifiedAt':
                exit(true);
            'SystemModifiedBy':
                exit(true);
            else begin
                exit(false);
            end;
        end;
    end;
}