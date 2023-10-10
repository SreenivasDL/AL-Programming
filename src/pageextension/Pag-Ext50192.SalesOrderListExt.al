pageextension 50192 SalesOrderListExt extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("F&unctions")
        {
            action(CalcFields)
            {
                ApplicationArea = all;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    TotalAmount: Decimal;
                begin
                    Clear(TotalAmount);
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", '1020', '1035');
                    if SalesHeader.FindSet() then begin
                        repeat
                            SalesHeader.CalcFields(Amount);
                            TotalAmount += SalesHeader.Amount;

                        until SalesHeader.Next() = 0;
                        Message(Format(TotalAmount));
                    end;

                end;
            }
        }
    }

    var
        myInt: Integer;
}