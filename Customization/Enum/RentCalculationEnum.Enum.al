enum 50100 "Rent Calculation Enum"
{
    Extensible = true;

    value(0; "None")
    {
        Caption = ' ';
    }
    value(1; "Single Unit with square feet rate")
    {
        Caption = 'Single Unit with square feet rate';
    }
    value(2; "Merged Unit with same square feet")
    {
        Caption = 'Merged Unit with same square feet';
    }
    value(3; "Merged Unit with differential square feet rate")
    {
        Caption = 'Merged Unit with differential square feet rate';
    }
    value(4; "Merged Unit with lumpsum annual amount")
    {
        Caption = 'Merged Unit with lumpsum annual amount';
    }
}
