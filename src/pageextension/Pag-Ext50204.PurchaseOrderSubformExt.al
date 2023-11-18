pageextension 50204 PurchaseOrderSubformExt extends "Purchase Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control43)
        {
            field("Total Cost to Invoice"; Rec."Total Cost to Invoice")
            {
                ApplicationArea = all;
                Caption = 'Total Cost to Invoice';

            }
        }
    }
    trigger OnAfterGetRecord()
    var
        PurchaseLine: Record "Purchase Line";
        Temp: Decimal;
    begin
        Rec.Modify();
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", Rec."Document No.");
        if PurchaseLine.FindSet() then
            repeat
                Temp += PurchaseLine."Direct Unit Cost" * PurchaseLine."Qty. to Invoice";
            until PurchaseLine.Next() = 0;
        Rec."Total Cost to Invoice" := Temp;
    end;

}