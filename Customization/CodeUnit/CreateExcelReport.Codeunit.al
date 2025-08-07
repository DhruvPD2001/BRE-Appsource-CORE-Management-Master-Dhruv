codeunit 50954 "Create Excel Report"
{

    var
        totals: Dictionary of [Integer, Decimal];
        headerColumnMap: Dictionary of [Integer, Integer];

    procedure GenerateExcelReportForAnyTable(TableId: Integer; FilterFieldNo: Integer; FilterValue: Variant)
    var
        excelBuffer: Record "Excel Buffer";
        rowNo: Integer;
        columnNo: Integer;
        recRef: RecordRef;
        fieldRef: FieldRef;
    begin
        Clear(totals);
        rowNo := 1;
        columnNo := 1;

        excelBuffer.DeleteAll();

        recRef.Open(TableId);
        fieldRef := recRef.Field(FilterFieldNo);
        fieldRef.SetRange(FilterValue);

        excelBuffer.EnterCell(excelBuffer, rowNo, columnNo, StrSubstNo('Report for Table %1', recRef.Name()), true, false, false);
        rowNo += 2;

        CreateTableHeaderDynamic(excelBuffer, rowNo, columnNo, recRef);
        InsertTableDataDynamic(excelBuffer, rowNo, columnNo, recRef);
        AddTotalsDynamic(excelBuffer, rowNo, recRef);

        ExcelBuffer.CreateNewBook('Dynamic Report');
        ExcelBuffer.WriteSheet('Dynamic Report', CompanyName(), UserId());
        ExcelBuffer.CloseBook();
        excelBuffer.OpenExcel();
    end;

    procedure CreateTableHeaderDynamic(var pExcelBuffer: Record "Excel Buffer"; var pRowNo: Integer; var pColumnNo: Integer; var pRecRef: RecordRef)
    var
        field: Record Field;
        checkField: Codeunit "Check Field";
    begin
        field.SetRange(TableNo, pRecRef.Number);
        if field.FindSet() then
            repeat
                if not checkField.SkipField(field) then begin
                    pExcelBuffer.EnterCell(pExcelBuffer, pRowNo, pColumnNo, field.FieldName, true, false, false);
                    HeaderColumnMap.Add(field."No.", pColumnNo);
                    pColumnNo += 1;
                end;
            until field.Next() = 0;

        pRowNo += 1;
        pColumnNo := 1;
    end;

    procedure InsertTableDataDynamic(var pExcelBuffer: Record "Excel Buffer"; var pRowNo: Integer; var pColumnNo: Integer; var pRecRef: RecordRef)
    var
        field: Record Field;
        fieldRef: FieldRef;
        checkField: Codeunit "Check Field";
    begin
        if pRecRef.FindSet() then
            repeat
                field.SetRange(TableNo, pRecRef.Number);
                if field.FindSet() then
                    repeat
                        if not checkField.SkipField(field) then begin
                            fieldRef := pRecRef.Field(field."No.");
                            pExcelBuffer.EnterCell(pExcelBuffer, pRowNo, pColumnNo, fieldRef.Value, false, false, false);

                            if (fieldRef.Type in [FieldType::Decimal, FieldType::Integer]) then begin
                                if not totals.ContainsKey(field."No.") then
                                    totals.Add(field."No.", 0);
                                totals.Set(field."No.", totals.Get(field."No.") + EvaluateAsDecimal(fieldRef.Value));
                            end;

                            pColumnNo += 1;
                        end;
                    until field.Next() = 0;

                pRowNo += 1;
                pColumnNo := 1;
            until pRecRef.Next() = 0;
    end;

    procedure AddTotalsDynamic(var pExcelBuffer: Record "Excel Buffer"; pRowNo: Integer; var pRecRef: RecordRef)
    var
        field: Record Field;
        checkField: Codeunit "Check Field";
        colPos: Integer;
        totalValue: Decimal;
    begin
        pExcelBuffer.EnterCell(pExcelBuffer, pRowNo, 1, 'TOTAL', true, false, false);

        field.SetRange(TableNo, pRecRef.Number);
        if field.FindSet() then
            repeat
                if not checkField.SkipTotalField(field) then begin
                    if totals.ContainsKey(field."No.") then
                        if HeaderColumnMap.Get(field."No.", colPos) then begin
                            totalValue := ROUND(totals.Get(field."No."), 0.01);
                            pExcelBuffer.EnterCell(pExcelBuffer, pRowNo, colPos, totalValue, true, false, false);
                        end;

                end;
            until field.Next() = 0;
    end;

    local procedure EvaluateAsDecimal(Value: Variant): Decimal;
    begin
        if Value.IsDecimal then
            exit(Value);
        if Value.IsInteger then
            exit(Value);
        exit(0);
    end;

}