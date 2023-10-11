pageextension 50194 SalesOrderSubformExt extends "Sales Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field(BagSize; Rec.BagSize)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter("&Line")
        {
            action(QuantityBagSize)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(SalesLine);
                    Report.Run(50195, true, false, SalesLine);
                end;
            }
        }
    }

    var
        SalesLine: Record "Sales Line";
}