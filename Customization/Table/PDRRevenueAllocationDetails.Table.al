table 50108 "PDR Revenue Allocation Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Year"; Text[30]) { }
        field(50101; "Unit ID"; Text[2048]) { }
        field(50102; "Sq. Ft."; Decimal) { }
        field(50103; "Per Day Rent Per Unit"; Decimal) { }
        field(50104; "Total Revenue"; Decimal) { }
        field(50105; "Praposal ID"; Decimal) { }
    }

    keys
    {
        key(PK; "Year", "Unit ID") { Clustered = true; }
    }
}
