codeunit 50110 "Copy Item Ext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Item", OnAfterCopyItem, '', false, false)]
    local procedure OnAfterCopyItem(var TargetItem: Record Item)
    var
        NoSeriesManagement: Codeunit "No. Series";
        unitpage: Page "Item Card";
        NewUnitNo: Code[20];
    begin
        NewUnitNo := NoSeriesManagement.GetNextNo('UNITNO', 0D, true);
        TargetItem.FixedNumber := NewUnitNo;
        TargetItem."Unit Status" := TargetItem."Unit Status"::Free;
        TargetItem.MergeSplitOption := TargetItem.MergeSplitOption::Single;
        TargetItem.Modify();

        unitpage.AutoGenerateUnitName(TargetItem);
    end;
}