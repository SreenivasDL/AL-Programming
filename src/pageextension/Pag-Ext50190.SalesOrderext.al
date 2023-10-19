pageextension 50190 SalesOrderext extends "Sales Order"
{
    layout
    {
        modify(Status)
        {
            Editable = true;
        }
        // Add changes to page layout here
        // modify("Bill-to Contact No.")
        // {
        //     // trigger OnLookup(var Text: Text): Boolean
        //     // begin
        //     //     if Page.RunModal(22) = Action::LookupOK then begin
        //     //         Text := 'hiii';
        //     //         exit(true);
        //     //     end;
        //     // end;
        //     // trigger OnAfterAfterLookup(Selected: RecordRef)
        //     // begin
        //     //     Message(Selected.Name);
        //     // end;
        //     // trigger OnDrillDown()
        //     // begin
        //     //     Page.RunModal(22);
        //     // end;
        //     // trigger OnLookup(var Text: Text): Boolean
        //     // begin
        //     //     Message('Hi');
        //     //     exit(true);
        //     // end;

        // }
        // addfirst(General)
        // {
        //     field("Bill-to Contact No._Updated"; Rec."Bill-to Contact No.")
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Modified Bill to Contact ';
        //         trigger OnLookup(var Text: Text): Boolean
        //         var
        //             Contact: Record Contact;
        //         begin
        //             if Page.RunModal(Page::"Contact List", Contact) = Action::LookupOK then begin
        //                 Text := Contact."No.";
        //                 exit(true);
        //             end;
        //         end;
        //     }
        // }

    }

    actions
    {
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
                    if (UserSetup."Allow To Change Status") = true then begin
                        if Rec.Status = Rec.Status::Released then begin
                            ReleaseSalesDoc.PerformManualReopen(Rec);
                            CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
                        end
                        else
                            if Rec.Status = Rec.Status::Open then begin
                                ReleaseSalesDoc.PerformManualRelease(Rec);
                                CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
                            end;
                    end;
                end;

            }

        }
    }


    var
        myInt: Integer;
        SalesHeader: Record "Sales Header";
}