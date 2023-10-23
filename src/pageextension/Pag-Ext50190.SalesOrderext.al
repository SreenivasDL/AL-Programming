pageextension 50190 SalesOrderext extends "Sales Order"
{
    layout
    {

    }

    actions
    {
        modify(PostAndSend)
        {
            Visible = false;
        }
        addafter("F&unctions")
        {
            action(NoOfCopies)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(SalesHeader);
                    Report.Run(50191, true, false, SalesHeader);
                end;
            }
            action(ChangeDocumentStatus)
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                begin
                    UserSetup.Get('DESKTOP-L86DHRF\SREENIVAS');
                    if UserSetup."Allow To Change Status" = true then begin
                        if Rec.Status = Rec.Status::Released then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify();
                        end
                        else
                            if Rec.Status = Rec.Status::Open then begin
                                Rec.Status := Rec.Status::Released;
                                Rec.Modify();
                            end;
                    end;
                end;

            }
            action(DummyPostandSend)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PostSalesOrder(CODEUNIT::"Sales-Post (Yes/No)", "Navigate After Posting"::"Posted Document");
                end;
            }

        }
        addafter(SendEmailConfirmation)
        {
            action("Custom EMail")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    EventProceduresPermissions: Codeunit EventProceduresPermissions;
                begin
                    EventProceduresPermissions.CustomEMail();
                end;
            }
        }
    }


    var
        SalesHeader: Record "Sales Header";
}