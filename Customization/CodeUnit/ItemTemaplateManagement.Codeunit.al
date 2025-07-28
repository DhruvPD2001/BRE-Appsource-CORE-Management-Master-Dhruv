codeunit 51251 "Item Temaplate Management"
{
    var
        ItemRec: Record Item;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Templ. Mgt.", OnBeforeOpenBlankCardConfirmed, '', false, false)]
    local procedure OnBeforeOpenBlankCardConfirmed(var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Templ. Mgt.", OnInsertItemFromTemplate, '', false, false)]
    local procedure OnInsertItemFromTemplate(var Item: Record Item; var Result: Boolean; var IsHandled: Boolean)
    var
        ItemTempl: Record "Item Templ.";
        itemTemplMgt: Codeunit "Item Templ. Mgt.";
        itemTemplPage: Page "Item Templ. List";
        itemDialogBox: Page "Item Dialog Box";
        itemCategory: Enum "Item Template Enum";
    begin
        if itemDialogBox.RunModal() = Action::OK then
            itemCategory := itemDialogBox.GetItemCategory();
        ItemTempl.SetRange(Types, itemCategory);
        if ItemTempl.Count = 1 then begin
            ItemTempl.FindFirst();
            IsHandled := true;
            Result := true;
            exit;
        end;
        itemTemplPage.SetTableView(ItemTempl);
        itemTemplPage.LookupMode(true);
        if itemTemplPage.RunModal() = Action::LookupOK then begin
            itemTemplPage.GetRecord(ItemTempl);
            IsHandled := true;
            Result := true;
        end else begin
            IsHandled := true;
            Result := false;
        end;
        item.Init();
        InitItemNo(item, ItemTempl);
        item."Item Template" := ItemTempl.Types;
        item.Insert(true);
        ItemRec := item;
        itemTemplMgt.ApplyItemTemplate(item, ItemTempl, true);
    end;

    procedure InitItemNo(var Item: Record Item; ItemTempl: Record "Item Templ.")
    var
        NoSeries: Codeunit "No. Series";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;
        if ItemTempl."No. Series" = '' then
            exit;
        Item."No. Series" := ItemTempl."No. Series";
        if Item."No." <> '' then begin
            NoSeries.TestManual(Item."No. Series");
            exit;
        end;
        NoSeries.TestAutomatic(Item."No. Series");
        Item."No." := NoSeries.GetNextNo(Item."No. Series");
    end;
}