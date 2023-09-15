report 50122 MultiDataItemsWithIntegerCust
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'MultiDataItemsWithIntegerCust.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("No." = const('20000'));
            column(No_; "No.")
            {

            }
            dataitem(Integer; Integer)
            {
                column(CustNo; CustNo)
                {

                }
                column(DocNo; DocNo)
                {

                }
                column(Type_; Type)
                {

                }
                column(LineNo; LineNo)
                {

                }
                column(No; No)
                {

                }
                column(DocType; DocType)
                {

                }
                column(Amt; Amt)
                {

                }
                trigger OnPreDataItem()
                begin
                    IntegerProcedure(Customer."No.");
                    if (CountSalesInvLine + CountSalesCrLine) = 0 then
                        CurrReport.Break();
                    Integer.SetFilter(Number, '%1..%2', 1, (CountSalesInvLine + CountSalesCrLine));
                    SalesInvLine.FindSet();
                    SalesCrLine.FindSet();
                end;

                trigger OnAfterGetRecord()
                begin
                    if Integer.Number <= CountSalesInvLine then begin
                        CustNo := SalesInvLine."Sell-to Customer No.";
                        DocNo := SalesInvLine."Document No.";
                        LineNo := SalesInvLine."Line No.";
                        Type := SalesInvLine.Type;
                        No := SalesInvLine."No.";
                        DocType := 'Invoice';
                        Amt := SalesInvLine.Amount;
                        SalesInvLine.Next();
                    end
                    else begin
                        CustNo := SalesCrLine."Sell-to Customer No.";
                        DocNo := SalesCrLine."Document No.";
                        LineNo := SalesCrLine."Line No.";
                        Type := SalesCrLine.Type;
                        No := SalesCrLine."No.";
                        DocType := 'Credit Memo';
                        Amt := SalesCrLine.Amount;
                        SalesCrLine.Next();
                    end;
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
                    field(Name; no)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    procedure IntegerProcedure(CustomerNo: Code[20])
    begin
        SalesInvLine.SetFilter("Sell-to Customer No.", CustomerNo);
        CountSalesInvLine := SalesInvLine.Count;

        SalesCrLine.SetFilter("Sell-to Customer No.", CustomerNo);
        CountSalesCrLine := SalesCrLine.Count;
    end;

    var
        SalesInvLine: Record "Sales Invoice Line";
        SalesCrLine: Record "Sales Cr.Memo Line";

        CountSalesInvLine: Integer;
        CountSalesCrLine: Integer;

        CustNo: Code[20];
        DocNo: Code[20];
        No: Code[20];
        LineNo: Integer;
        Type: Enum "Sales Line Type";

        DocType: Text[20];

        NoOfTimes: Integer;

        Amt: Decimal;
}