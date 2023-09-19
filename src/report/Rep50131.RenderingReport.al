report 50131 RenderingReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = RdlLayout1;

    dataset
    {
        dataitem(DataItemName; Customer)
        {
            column(No_; "No.")
            {

            }
            column(Name; Name)
            {

            }
            column(Address; Address)
            {

            }
            column(Address_2; "Address 2")
            {

            }
            column(E_Mail; "E-Mail")
            {

            }
        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }

    rendering
    {
        layout(RdlLayout1)
        {
            Type = RDLC;
            LayoutFile = 'RdlLayout1.rdl';
        }
        layout(RdlLayout2)
        {
            Type = RDLC;
            LayoutFile = 'RdlLayout2.rdl';
        }
    }

    var
        myInt: Integer;
}