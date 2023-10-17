pageextension 50197 PostedSalesInvoiceExt extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Order No.")
        {
            field("Customer Group"; Rec."Customer Group")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
        addafter("&Electronic Document")
        {
            action("Generate Customer Group")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Customer.Reset();
                    Customer.SetRange(Name, Rec."Sell-to Customer Name");
                    if Customer.FindSet() then begin
                        Rec."Customer Group" := Customer."Customer Group";
                        Rec.Modify();
                    end;
                end;
            }
        }
    }

    var
        Customer: Record Customer;
}