report 50121 "Multi DataItems Same"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    DefaultLayout = RDLC;
    RDLCLayout = 'MultiDataitemsSame.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("No." = const('20000'));
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Sell-to Customer No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(Sell_to_Customer_No_; "Sell-to Customer No.")
                {

                }
                column(Document_No; "Document No.")
                {

                }
                column(Line_No; "Line No.")
                {

                }
                column(Type_; Type)
                {

                }
                column(No; "No.")
                {

                }
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Sell-to Customer No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(Sell_to_Customer_No; "Sell-to Customer No.")
                {

                }
                column(Document_No_; "Document No.")
                {

                }
                column(Line_No_; "Line No.")
                {

                }
                column(Type; Type)
                {

                }
                column(No_; "No.")
                {

                }
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

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        myInt: Integer;
}