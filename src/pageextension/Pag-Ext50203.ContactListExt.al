pageextension 50203 ContactListExt extends "Contact List"
{
    actions
    {
        addafter("Export Contact")
        {
            action("Get Sales Orders List")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                    Salesheader.SetRange("Sell-to Contact No.", Rec."No.");
                    if SalesHeader.FindSet() then
                        Page.Run(Page::"Sales Order List", SalesHeader)
                    else
                        Message('No Sales has been created with this Contact');
                end;
            }
        }

    }
}