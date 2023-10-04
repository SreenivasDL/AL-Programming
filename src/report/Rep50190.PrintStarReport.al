report 50190 PrintStarReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'PrintStarReport.rdl';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            column(DocNo; "No.")
            {

            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {

            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Bill_to_City; "Bill-to City")
            {

            }
            column(Bill_to_Contact_No_; "Bill-to Contact No.")
            {

            }
            column(VAT_Registration_No_; "VAT Registration No.")
            {

            }
            column(Bill_to_Address; "Bill-to Address")
            {

            }
            column(Currency_Code; "Currency Code")
            {

            }
            column(Order_No_; "Order No.")
            {

            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(ItemNo_; "No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Line_Discount__; "Line Discount %")
                {

                }
                column(Total; Total)
                {

                }
                column(UpdatedItemNO; UpdatedItemNO)
                {

                }
                column(Sum; Sum)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    Clear(Sum);
                    ITL.Reset();
                    ITL.SetFilter("Item No.", "Sales Shipment Line"."No.");
                    if ITL.FindSet() then
                        repeat
                            if (ITL."Location Code" = 'RED') then
                                Sum += ITL.Quantity;
                            if ((ITL."Location Code" = 'RED') or (ITL."Location Code" = 'YELLOW')) then
                                Sum += ITL.Quantity;
                        until ITL.Next() = 0;
                    // if (Sum = "Sales Shipment Line".Quantity) then
                    //     UpdatedItemNO := '*' + ITL."Item No.";

                    // if Sum = 0 then
                    //     UpdatedItemNO := '**' + ITL."Item No."
                    // else
                    //     UpdatedItemNO := ITL."Item No."
                end;
            }
        }

        // dataitem("Company Information"; "Company Information")
        // {
        //     column(Name; Name)
        //     {

        //     }
        //     column(E_Mail; "E-Mail")
        //     {

        //     }
        //     column(Company_VAT_Registration_No; "VAT Registration No.")
        //     {

        //     }
        // }
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

    // actions
    // {
    //     area(processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;

    //         }
    //     }
    // }
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
        Total: Decimal;

        ITL: Record "Item Ledger Entry";

        Sum: Decimal;

        UpdatedItemNO: Code[20];

}