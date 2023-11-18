pageextension 50194 SalesOrderSubformExt extends "Sales Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("BC SO No"; Rec."BC SO No")
            {
                ApplicationArea = all;
            }
            field("BC SO Doc Line No"; Rec."BC SO Doc Line No")
            {
                ApplicationArea = all;
            }
        }
        addafter(Quantity)
        {
            field(BagSize; Rec.BagSize)
            {
                ApplicationArea = all;
            }
        }
        modify("Item Reference No.")
        {
            trigger OnAfterValidate()
            begin
                Rec."BC SO No" := Rec."Document No.";
            end;
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