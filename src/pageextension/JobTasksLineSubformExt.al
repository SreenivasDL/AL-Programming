pageextension 50199 JoTasksLineSubformExt extends "Job Task Lines Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Contract (Invoiced Price)")
        {
            field(Buyout; Rec.Buyout)
            {
                ApplicationArea = all;
                Style = Strong;
                StyleExpr = StyleIsStrong;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        Position: Text;
    begin
        EventProceduresList.JobTaskBuyout(Rec."Job No.", Rec."Job Task No.", xRec.Buyout);
        // StyleIsStrong := Rec."Job Task No." = '1300';

        if JobTask.Get(Rec."Job No.", Rec."Job Task No.") then
            repeat
                Position := DelStr(Format(Rec."Job Task No."), 4, StrLen(Rec."Job Task No."));
                if Position = '13-' then begin
                    StyleIsStrong := true;
                    Rec.CalcFields("Schedule (Total Cost)");
                    Rec.CalcFields("Schedule (Total Price)");
                    if Rec.Buyout = 0 then
                        Rec.Buyout := Rec."Schedule (Total Cost)" + Rec."Schedule (Total Price)";
                    Rec.Modify();
                end
                else begin
                    StyleIsStrong := false;
                    Rec.Buyout := 0;
                    Rec.Modify();
                end;
            until JobTask.Next() = 0;
        // JobTask.SetFilter("Job Task No.", '13*', Rec."Job Task No.");
        // if JobTask.FindSet() then
        //     repeat
        //         JobTask.CalcFields("Schedule (Total Cost)");
        //         JobTask.CalcFields("Schedule (Total Price)");
        //         JobTask.Buyout := JobTask."Schedule (Total Cost)" + JobTask."Schedule (Total Price)";
        //     until JobTask.Next() = 0
        // else
        //     JobTask.Buyout := 0;

    end;

    var
        EventProceduresList: Codeunit EventProceduresPermissions;
        StyleIsStrong: Boolean;
        JobTask: Record "Job Task";
}