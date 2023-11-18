pageextension 50208 ILEntriesExt extends "Item Ledger Entries"
{
    // layout
    // {
    //     // Add changes to page layout here
    // }

    actions
    {
        addafter("Ent&ry")
        {
            action("View Document")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    AGTViewDocument();
                end;
            }
        }
    }

    procedure AGTViewDocument()
    var
        SalesShipment: Record "Sales Shipment Header";
        ReturnReceipt: Record "Return Receipt Header";
        PurchaseReceipt: Record "Purch. Rcpt. Header";
        ReturnShipmentHeader: Record "Return Shipment Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        TransferReceiptHeader: Record "Transfer Receipt Header";
    begin
        if Rec."Document Type" = Rec."Document Type"::"Sales Shipment" then begin
            SalesShipment.SetRange("No.", Rec."Document No.");
            if SalesShipment.FindFirst() then
                Page.Run(130, SalesShipment);
        end;
        if Rec."Document Type" = Rec."Document Type"::"Sales Return Receipt" then begin
            ReturnReceipt.SetRange("No.", Rec."Document No.");
            if ReturnReceipt.FindFirst() then
                Page.Run(6660, ReturnReceipt);
        end;
        if Rec."Document Type" = Rec."Document Type"::"Purchase Receipt" then begin
            PurchaseReceipt.SetRange("No.", Rec."Document No.");
            if PurchaseReceipt.FindSet() then
                Page.Run(136, PurchaseReceipt);
        end;
        if Rec."Document Type" = Rec."Document Type"::"Purchase Return Shipment" then begin
            ReturnShipmentHeader.SetRange("No.", Rec."Document No.");
            if ReturnShipmentHeader.FindFirst() then
                Page.Run(6650, ReturnShipmentHeader);
        end;

        if Rec."Document Type" = Rec."Document Type"::"Transfer Shipment" then begin
            TransferShipmentHeader.SetRange("No.", Rec."Document No.");
            if TransferShipmentHeader.FindFirst() then
                Page.Run(5743, TransferShipmentHeader);
        end;

        if Rec."Document Type" = Rec."Document Type"::"Transfer Receipt" then begin
            TransferReceiptHeader.SetRange("No.", Rec."Document No.");
            if TransferReceiptHeader.FindFirst() then
                Page.Run(5745, TransferReceiptHeader);
        end;

    end;

}