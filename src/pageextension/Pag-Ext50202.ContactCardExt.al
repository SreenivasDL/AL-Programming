pageextension 50202 ContactCardExt extends "Contact Card"
{

    actions
    {
        addafter("NewSalesQuote")
        {
            action("Create Sales Order")
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    SalesHeader: Record "Sales Header";
                    SalesQuoteToOrderYesOrNO: Codeunit "Sales-Quote to Order (Yes/No)";
                    EventSubsList: Codeunit EventSubscriberList;
                begin
                    // Rec.CreateSalesQuoteFromContact();
                    // SalesHeader.Reset();
                    // SalesHeader.SetCurrentKey("No.");
                    // SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Quote);
                    // if SalesHeader.FindLast() then begin
                    //     if ApprovalsMgmt.PrePostApprovalCheckSales(SalesHeader) then
                    //         CODEUNIT.Run(CODEUNIT::"Sales-Quote to Order (Yes/No)", SalesHeader);
                    // end;
                end;
            }
        }
    }

}