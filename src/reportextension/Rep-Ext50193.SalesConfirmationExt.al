reportextension 50193 SalesConfirmationExt extends "Standard Sales - Order Conf."
{
    dataset
    {
        // Add changes to dataitems and columns here
        add(Header)
        {
            column(Custom_ExternalDocNo; "External Document No.")
            {

            }
        }


    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout(CustomLayout)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }
}