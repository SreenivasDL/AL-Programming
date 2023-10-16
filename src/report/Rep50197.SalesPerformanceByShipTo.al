report 50197 SalesPerformanceByShipTo
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'SalesPerformanceByShipTo.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(No_; "No.") { }
            column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(Posting_Date; "Posting Date") { }
            column(Salesperson_Code; "Salesperson Code") { }
            column(Ship_to_Code; "Ship-to Code") { }
            column(MTD; MTD) { }
            column(LYMTD; LYMTD) { }
            column(MTDVar; MTDVar) { }
            column(YTD; YTD) { }
            column(LYTD; LYTD) { }
            column(OpenSalesOrders; OpenSalesOrders) { }
            column(LYR; LYR) { }
            column(ReportingDate; ReportingDate) { }
            column(PreviousYear; PreviousYear) { }
            column(MTDCreMemo; MTDCreMemo) { }
            column(LYMTDCreMemo; LYMTDCreMemo) { }
            column(YTDCreMemo; YTDCreMemo) { }
            column(LYTDCreMemo; LYTDCreMemo) { }
            column(LYRCreMemo; LYRCreMemo) { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                trigger OnAfterGetRecord()
                begin
                    DateCalculation();
                    SalesLine.Reset();
                    SalesLine.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
                    if SalesLine.FindSet() then
                        repeat
                            OpenSalesOrders += SalesLine.Amount;
                        until SalesLine.Next() = 0
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
                    field(ReportingDate; ReportingDate)
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

    trigger OnPreReport()
    var
        CalcPreviousYear: Date;
    begin
        CalcPreviousYear := CalcDate('CY-1Y', ReportingDate);
        PreviousYear := Date2DMY(CalcPreviousYear, 3);
    end;

    trigger OnPostReport()
    begin
        Message(Format(MTDCreMemo));
    end;

    local procedure DateCalculation()
    begin
        ArrayDateCalc[1, 1] := CalcDate('-CM', ReportingDate);
        ArrayDateCalc[2, 1] := CalcDate('CD-1Y-CM', ReportingDate);
        ArrayDateCalc[3, 1] := CalcDate('-CY', ReportingDate);
        ArrayDateCalc[4, 1] := CalcDate('-CY-1Y', ReportingDate);
        ArrayDateCalc[5, 1] := CalcDate('-CY-1Y', ReportingDate);
        ArrayDateCalc[1, 2] := ReportingDate;
        ArrayDateCalc[2, 2] := CalcDate('CD-1Y', ReportingDate);
        ArrayDateCalc[3, 2] := CalcDate('CY', ReportingDate);
        ArrayDateCalc[4, 2] := CalcDate('CD-1Y', ReportingDate);
        ArrayDateCalc[5, 2] := CalcDate('CY-1Y', ReportingDate);

        Clear(MTD);
        Clear(LYMTD);
        Clear(YTD);
        Clear(LYTD);
        Clear(LYR);

        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvoiceLine.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");

        SalesInvoiceLine.SetRange("Posting Date", ArrayDateCalc[1, 1], ArrayDateCalc[1, 2]);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            MTD := SalesInvoiceLine.Amount;
        end;

        SalesInvoiceLine.SetRange("Posting Date", ArrayDateCalc[2, 1], ArrayDateCalc[2, 2]);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            LYMTD := SalesInvoiceLine.Amount;
        end;

        SalesInvoiceLine.SetRange("Posting Date", ArrayDateCalc[3, 1], ArrayDateCalc[3, 2]);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            YTD := SalesInvoiceLine.Amount;
        end;

        SalesInvoiceLine.SetRange("Posting Date", ArrayDateCalc[4, 1], ArrayDateCalc[4, 2]);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            LYTD := SalesInvoiceLine.Amount;
        end;

        SalesInvoiceLine.SetRange("Posting Date", ArrayDateCalc[5, 1], ArrayDateCalc[5, 2]);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            LYR := SalesInvoiceLine.Amount;
        end;

        SalesCrMemoLine.Reset();
        SalesCrMemoLine.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
        SalesCrMemoLine.SetRange("Posting Date", ArrayDateCalc[1, 1], ArrayDateCalc[1, 2]);
        if SalesCrMemoLine.FindSet() then begin
            SalesCrMemoLine.CalcSums(Amount);
            MTDCreMemo := SalesCrMemoLine.Amount;
        end;

        SalesCrMemoLine.SetRange("Posting Date", ArrayDateCalc[2, 1], ArrayDateCalc[2, 2]);
        if SalesCrMemoLine.FindSet() then begin
            SalesCrMemoLine.CalcSums(Amount);
            LYMTDCreMemo := SalesCrMemoLine.Amount;
        end;

        SalesCrMemoLine.SetRange("Posting Date", ArrayDateCalc[3, 1], ArrayDateCalc[3, 2]);
        if SalesCrMemoLine.FindSet() then begin
            SalesCrMemoLine.CalcSums(Amount);
            YTDCreMemo := SalesCrMemoLine.Amount;
        end;

        SalesCrMemoLine.SetRange("Posting Date", ArrayDateCalc[4, 1], ArrayDateCalc[4, 2]);
        if SalesCrMemoLine.FindSet() then begin
            SalesCrMemoLine.CalcSums(Amount);
            LYTDCreMemo := SalesCrMemoLine.Amount;
        end;

        SalesCrMemoLine.SetRange("Posting Date", ArrayDateCalc[5, 1], ArrayDateCalc[5, 2]);
        if SalesCrMemoLine.FindSet() then begin
            SalesCrMemoLine.CalcSums(Amount);
            LYRCreMemo := SalesCrMemoLine.Amount;
        end;

    end;

    var
        ReportingDate: Date;

        MTD: Decimal;
        LYMTD: Decimal;
        MTDVar: Decimal;

        YTD: Decimal;

        LYTD: Decimal;
        LYR: Decimal;

        MTDCreMemo: Decimal;

        LYMTDCreMemo: Decimal;

        YTDCreMemo: Decimal;
        LYTDCreMemo: Decimal;
        LYRCreMemo: Decimal;

        SalesLine: Record "Sales Line";
        SalesInvoiceLine: Record "Sales Invoice Line";

        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        PreviousYear: Integer;
        OpenSalesOrders: Decimal;

        ArrayDateCalc: array[5, 5] of Date;
}