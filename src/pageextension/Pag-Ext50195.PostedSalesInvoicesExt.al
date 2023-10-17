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
            action("Generate Customer Group")
            {
                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    Customer: Record Customer;
                begin
                    Customer.Reset();
                    SalesInvoiceHeader.Reset();
                    Customer.SetRange("No.", Rec."Sell-to Customer No.");
                    if Customer.FindSet() then begin
                        SalesInvoiceHeader.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                        if SalesInvoiceHeader.FindSet() then
                            repeat
                                SalesInvoiceHeader."Customer Group" := Customer."Customer Group";
                                SalesInvoiceHeader.Modify();
                            until SalesInvoiceHeader.Next() = 0;
                    end;
                end;
            }
        }
    }
}