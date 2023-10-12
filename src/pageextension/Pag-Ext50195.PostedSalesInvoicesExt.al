pageextension 50195 PostedSalesInvoicesExt extends "Posted Sales Invoices"
{

    actions
    {
        // Add changes to page actions here
        addafter(Print)
        {
            action(SalesPerformancebyShipTo)
            {
                trigger OnAction()
                begin
                    Report.Run(50197);
                end;
            }
        }
    }
}