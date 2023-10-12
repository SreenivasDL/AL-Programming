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
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                trigger OnAfterGetRecord()
                begin
                    MTDCalc();
                    LYMTDCalc();
                    YTDCalc();
                    LYTDCalc();
                    LYRClac();
                    SalesInvoiceLine.Reset();
                    SalesInvoiceLine.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
                    if SalesInvoiceLine.FindSet() then
                        repeat
                            OpenSalesOrders += SalesInvoiceLine.Amount;
                        until SalesInvoiceLine.Next() = 0
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

    local procedure MTDCalc()
    Var
        StartDate: Date;
    begin
        StartDate := CalcDate('-CM', ReportingDate);
        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvoiceLine.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
        SalesInvoiceLine.SetRange("Posting Date", StartDate, ReportingDate);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            MTD := SalesInvoiceLine.Amount;
        end
        else
            MTD := 0;
    end;

    local procedure LYMTDCalc()
    var
        StartDate: Date;
        EndDate: Date;
    begin
        EndDate := CalcDate('CD-1Y', ReportingDate);
        StartDate := CalcDate('-CM', EndDate);
        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvoiceLine.SetRange("Posting Date", StartDate, EndDate);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            LYMTD := SalesInvoiceLine.Amount;
        end
        else
            LYMTD := 0;
    end;

    local procedure YTDCalc()
    var
        SartDate: Date;
    begin
        SartDate := CalcDate('-CY', ReportingDate);
        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvoiceLine.SetRange("Posting Date", SartDate, ReportingDate);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            YTD := SalesInvoiceLine.Amount;
        end
        else
            YTD := 0;
    end;

    local procedure LYTDCalc()
    var
        StartDate: Date;
        EndDate: Date;
    begin
        StartDate := CalcDate('-CY-1Y', ReportingDate);
        EndDate := CalcDate('CD-1Y', ReportingDate);
        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvoiceLine.SetRange("Posting Date", StartDate, EndDate);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            LYTD := SalesInvoiceLine.Amount;
        end
        else
            LYTD := 0;

    end;

    local procedure LYRClac()
    var
        StartDate: Date;
    begin
        StartDate := CalcDate('-CY-1Y', ReportingDate);
        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvoiceLine.SetRange("Posting Date", StartDate);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            LYR := SalesInvoiceLine.Amount;
        end
        else
            LYR := 0;

    end;

    var
        ReportingDate: Date;

        MTD: Decimal;
        LYMTD: Decimal;
        MTDVar: Decimal;

        YTD: Decimal;

        LYTD: Decimal;
        LYR: Decimal;
        SalesInvoiceLine: Record "Sales Invoice Line";
        PreviousYear: Integer;
        OpenSalesOrders: Decimal;
}