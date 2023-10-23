pageextension 50198 CustomerTempCardExt extends "Customer Templ. Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Check Date Separator")
        {
            field("Payment Collection Method"; Rec."Payment Collection Method")
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