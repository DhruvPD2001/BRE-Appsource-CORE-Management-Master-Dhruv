codeunit 53751 "Fetch Month"
{
    procedure GetMonthName(MonthNo: Integer): Text
    begin
        case MonthNo of
            1:
                exit('January');
            2:
                exit('February');
            3:
                exit('March');
            4:
                exit('April');
            5:
                exit('May');
            6:
                exit('June');
            7:
                exit('July');
            8:
                exit('August');
            9:
                exit('September');
            10:
                exit('October');
            11:
                exit('November');
            12:
                exit('December');
            else
                exit(Format(MonthNo));
        end;
    end;

    procedure GetMonthNo(Month: Text): Integer
    begin
        case Month of
            'January':
                exit(1);
            'February':
                exit(2);
            'March':
                exit(3);
            'April':
                exit(4);
            'May':
                exit(5);
            'June':
                exit(6);
            'July':
                exit(7);
            'August':
                exit(8);
            'September':
                exit(9);
            'October':
                exit(10);
            'November':
                exit(11);
            'December':
                exit(12);
            else
                exit(0);
        end;
    end;

    procedure GetNoofDaysInMonth(MonthNo: Integer; Year: Integer): Integer
    var
        DaysInMonth: array[12] of Integer;
    begin
        DaysInMonth[1] := 31;
        DaysInMonth[2] := 28;
        DaysInMonth[3] := 31;
        DaysInMonth[4] := 30;
        DaysInMonth[5] := 31;
        DaysInMonth[6] := 30;
        DaysInMonth[7] := 31;
        DaysInMonth[8] := 31;
        DaysInMonth[9] := 30;
        DaysInMonth[10] := 31;
        DaysInMonth[11] := 30;
        DaysInMonth[12] := 31;
        if (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0)) then
            DaysInMonth[2] := 29;
        exit(DaysInMonth[MonthNo]);
    end;
}