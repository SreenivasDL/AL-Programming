report 50191 NoOfCopies
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'NoOfCopies.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Document No." = field("No.");

                dataitem(CopyLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    dataitem(PageLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(DocNo; "Sales Header"."No.")
                        {

                        }
                        column(Sell_to_Customer_No_; "Sales Header"."Sell-to Customer No.")
                        {

                        }
                        column(Sell_to_Customer_Name; "Sales Header"."Sell-to Customer Name")
                        {

                        }
                        column(Posting_Date; "Sales Header"."Posting Date")
                        {

                        }
                        column(Bill_to_City; "Sales Header"."Bill-to City")
                        {

                        }
                        column(Bill_to_Contact_No_; "Sales Header"."Bill-to Contact No.")
                        {

                        }
                        column(VAT_Registration_No_; "Sales Header"."VAT Registration No.")
                        {

                        }
                        column(Bill_to_Address; "Sales Header"."Bill-to Address")
                        {

                        }
                        column(Currency_Code; "Sales Header"."Currency Code")
                        {

                        }
                        column(OrderNo; OrderNo)
                        {

                        }
                        column(ShowUnitCost; ShowUnitCost)
                        {

                        }
                        column(Outputno; OutputNo)
                        {

                        }
                        column(CopyText; CopyText)
                        {

                        }
                        column(ItemNo_; "Sales Line"."No.")
                        {

                        }
                        column(Description; "Sales Line".Description)
                        {

                        }
                        column(Quantity; "Sales Line".Quantity)
                        {

                        }
                        column(Unit_Price; "Sales Line"."Unit Price")
                        {

                        }
                        column(Line_Discount__; "Sales Line"."Line Discount %")
                        {

                        }
                        column(Total; Total)
                        {

                        }
                        column(TotalQuantity; TotalQuantity)
                        {

                        }
                        column(Amount_Including_VAT; "Sales Line"."Amount Including VAT")
                        {

                        }
                        column(AmountEcludingVAT; "Sales Line"."Line Amount")
                        {

                        }
                        column(VAT__; "Sales Line"."VAT %")
                        {

                        }
                        column(TotalDiscount; TotalDiscount)
                        {

                        }
                        column(TotalExcludingVAT; TotalExcludingVAT)
                        {

                        }
                        column(TotalIncludingVAT; TotalIncludingVAT)
                        {

                        }
                        column(TotalAmount; TotalAmount)
                        {

                        }


                    }
                    trigger OnAfterGetRecord();
                    begin
                        if Number > 1 then begin
                            CopyText := FormatDocument.GetCOPYText;
                            OutputNo += 1;
                        end;

                    end;

                    trigger OnPreDataItem();
                    begin
                        NoOfLoops := ABS(NoOfCopies) + 2;
                        CopyText := '';
                        SETRANGE(Number, 1, NoOfLoops);
                        OutputNo := 1;

                    end;
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    TotalQuantity := 0;
                    TotalExcludingVAT := 0;
                    TotalIncludingVAT := 0;
                    TotalAmount := 0;
                    SalesLine.SetFilter("Document No.", "Sales Header"."No.");
                    if SalesLine.FindSet() then
                        repeat
                            TotalQuantity += SalesLine.Quantity;
                            TotalExcludingVAT += SalesLine."Line Amount";
                            TotalIncludingVAT += SalesLine."Amount Including VAT";
                            TotalDiscount += SalesLine."Line Discount Amount";
                        until SalesLine.Next() = 0;
                    TotalAmount := TotalIncludingVAT + TotalIncludingVAT;
                end;
            }

        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Advanced;
                    }
                }
            }
        }

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
    }

    var
        myInt: Integer;

        OrderNo: Code[20];

        Total: Decimal;

        ShowUnitCost: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        FormatDocument: Codeunit "Format Document";

        TotalQuantity: Decimal;
        TotalExcludingVAT: Decimal;
        TotalIncludingVAT: Decimal;
        TotalDiscount: Decimal;
        TotalAmount: Decimal;

        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
}