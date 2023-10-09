pageextension 50191 PurchaseOrderExt extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("F&unctions")
        {
            action("1900Report")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(PurchaseHeader);
                    Report.Run(50192, true, false, PurchaseHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;

        PurchaseHeader: Record "Purchase Header";
}