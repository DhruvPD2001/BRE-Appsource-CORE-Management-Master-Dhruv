pageextension 50108 "G/L Posting Preview Ext" extends "G/L Posting Preview"
{
    actions
    {
        addafter(Process)
        {
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost';
                Image = PostOrder;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                var
                    GenJournal: Record "Gen. Journal Line";
                begin
                    if GenJournal.FindSet() then
                        GenJournal.SendToPosting(Codeunit::"Gen. Jnl.-Post");
                end;
            }
        }
    }
}