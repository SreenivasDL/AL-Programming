reportextension 50131 LabelReportDemoExt extends LabelReportDemo
{
    dataset
    {
        addafter("Sales Line")
        {
            dataitem(Customer; Customer)
            {
                DataItemLink = Name = field("Sell-to Customer Name");
                column(No_; Customer."No.")
                {

                }
                column(Address_Cust; Address)
                {

                }
                column(Name; Name)
                {

                }

            }
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }
}