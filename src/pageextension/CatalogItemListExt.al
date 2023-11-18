pageextension 50209 CatalogItemCardExt extends "Catalog Item Card"
{
    layout
    {
        addafter("Vendor Item No.")
        {
            field("Lead Time Calculation"; Rec."Lead Time Calculation")
            {
                ApplicationArea = all;

            }
        }
        modify("Vendor No.")
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }
    }

}