pageextension 50190 SalesOrderext extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
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
        }
    }

    var
        myInt: Integer;
        SalesHeader: Record "Sales Header";
}