report 50193 SalespersonReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'SalespersonReport.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(No_; "No.")
            {

            }
            column(Salesperson_Code; "Salesperson Code")
            {

            }
            column(Salesperson_Name; Salesperson_Name)
            {

            }
            column(Amount; Amount)
            {

            }
            column(FirstDate; FirstDayOfMonth)
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(SalesOnFirstDate; SalesOnFirstDate)
            {

            }
            column(FirstWeekDay1; FirstWeekDay1)
            {

            }
            column(FirstWeekDay2; FirstWeekDay2)
            {

            }
            column(SecondWeekDay1; SecondWeekDay1)
            {

            }
            column(SecondWeekDay2; SecondWeekDay2)
            {

            }
            column(ThirdWeekDay1; ThirdWeekDay1)
            {

            }
            column(ThirdWeekDay2; ThirdWeekDay2)
            {

            }
            column(FourthWeekDay1; FourthWeekDay1)
            {

            }
            column(ForuthWeekDay2; FourthWeekDay2)
            {

            }
            column(FifthWeekDay1; FifthWeekDay1)
            {

            }
            column(FifthWeekDay2; FifthWeekDay2)
            {

            }
            column(FirstWeekSalesTotal; FirstWeekSalesTotal)
            {

            }
            column(SecondWeekSalesTotal; SecondWeekSalesTotal)
            {

            }
            column(ThirdWeekSalesTotal; ThirdWeekSalesTotal)
            {

            }
            column(FourthWeekSalesTotal; FourthWeekSalesTotal)
            {

            }
            column(FifthWeekSalesTotal; FifthWeekSalesTotal)
            {

            }
            column(TotalAmount; TotalAmount)
            {

            }
            trigger OnAfterGetRecord()
            var
                SalespersoncodeRec: Record "Salesperson/Purchaser";
                SalesHeader: Record "Sales Header";
                SalesLine: Record "Sales Line";
            begin
                SalespersoncodeRec.SetFilter(Code, "Sales Header"."Salesperson Code");
                if SalespersoncodeRec.FindSet() then
                    Salesperson_Name := SalespersoncodeRec.Name;

                SalesLine.Reset();
                SalesLine.SetFilter("Document No.", "Sales Header"."No.");

                SalesLine.SetFilter("Posting Date", '%1', FirstWeekDay1);
                if SalesLine.FindSet() then
                    repeat
                        SalesOnFirstDate := SalesLine.Amount;
                    until SalesLine.Next() = 0
                else
                    SalesOnFirstDate := 0;

                SalesLine.SetFilter("Posting Date", '%1..%2', FirstWeekDay1, FirstWeekDay2);
                if SalesLine.FindSet() then
                    repeat
                        FirstWeekSalesTotal += SalesLine.Amount;
                    until SalesLine.Next() = 0
                else
                    FirstWeekSalesTotal := 0;

                SalesLine.SetFilter("Posting Date", '%1..%2', SecondWeekDay1, SecondWeekDay2);
                if SalesLine.FindSet() then
                    repeat
                        SecondWeekSalesTotal += SalesLine.Amount;
                    until SalesLine.Next() = 0
                else
                    SecondWeekSalesTotal := 0;
                SalesLine.SetFilter("Posting Date", '%1..%2', ThirdWeekDay1, ThirdWeekDay2);
                if SalesLine.FindSet() then
                    repeat
                        ThirdWeekSalesTotal += SalesLine.Amount;
                    until SalesLine.Next() = 0
                else
                    ThirdWeekSalesTotal := 0;
                SalesLine.SetFilter("Posting Date", '%1..%2', FourthWeekDay1, FourthWeekDay2);
                if SalesLine.FindSet() then
                    repeat
                        FourthWeekSalesTotal += SalesLine.Amount;
                    until SalesLine.Next() = 0
                else
                    FourthWeekSalesTotal := 0;
                SalesLine.SetFilter("Posting Date", '%1..%2', FifthWeekDay1, FifthWeekDay2);
                if SalesLine.FindSet() then
                    repeat
                        FifthWeekSalesTotal += SalesLine.Amount;
                    until SalesLine.Next() = 0
                else
                    FifthWeekSalesTotal := 0;

                TotalAmount := FirstWeekSalesTotal + SecondWeekSalesTotal + ThirdWeekSalesTotal + FourthWeekSalesTotal + FifthWeekSalesTotal;

            end;
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
                    field(SalesForMonth; SalesForMonth)
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
    begin
        FirstDayOfMonth := CalcDate('-CM', SalesForMonth);
        FirstWeekDay1 := FirstDayOfMonth;
        FirstWeekDay2 := FirstDayOfMonth + 6;
        SecondWeekDay1 := FirstWeekDay2 + 1;
        SecondWeekDay2 := SecondWeekDay1 + 6;
        ThirdWeekDay1 := SecondWeekDay2 + 1;
        ThirdWeekDay2 := ThirdWeekDay1 + 6;
        FourthWeekDay1 := ThirdWeekDay2 + 1;
        FourthWeekDay2 := FourthWeekDay1 + 6;
        FifthWeekDay1 := FourthWeekDay2 + 1;
        FifthWeekDay2 := CalcDate('+CM', SalesForMonth);
    end;

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        Salesperson_Name: Text[200];

        FirstWeekSalesTotal: Decimal;
        SecondWeekSalesTotal: Decimal;
        ThirdWeekSalesTotal: Decimal;
        FourthWeekSalesTotal: Decimal;
        FifthWeekSalesTotal: Decimal;
        TotalAmount: Decimal;

        SalesForMonth: Date;
        FirstDayOfMonth: Date;
        SalesOnFirstDate: Decimal;
        FirstWeekDay1: Date;
        FirstWeekDay2: Date;
        SecondWeekDay1: Date;
        SecondWeekDay2: Date;
        ThirdWeekDay1: Date;
        ThirdWeekDay2: Date;
        FourthWeekDay1: Date;
        FourthWeekDay2: Date;
        FifthWeekDay1: Date;
        FifthWeekDay2: Date;


}