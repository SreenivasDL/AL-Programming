pageextension 50196 CustomerCardExt extends "Customer Card"
{
    layout
    {
        addafter("CFDI Customer Name")
        {
            field("Customer Group"; Rec."Customer Group")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}