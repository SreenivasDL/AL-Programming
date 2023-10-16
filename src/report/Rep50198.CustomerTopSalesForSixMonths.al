report 50198 CustomerTopSalesForSixMonths
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'CustomerTopSalesForSixMonths.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(No_; "No.") { }
            column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(SalesInFirstMonth; SalesInFirstMonth) { }
            column(SalesInSecondMonth; SalesInSecondMonth) { }
            column(SalesInThirdMonth; SalesInThirdMonth) { }
            column(SalesInFourthMonth; SalesInFourthMonth) { }
            column(SalesInFifthMonth; SalesInFifthMonth) { }
            column(SalesInSixthMonth; SalesInSixthMonth) { }
            column(TotalSales; TotalSales) { }
            column(CompanyName; CompanyName) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyPhn; CompanyPhn) { }
            column(FirstMonth; ArrayMonth[1]) { }
            column(SecondMonth; ArrayMonth[2]) { }
            column(ThirdMonth; ArrayMonth[3]) { }
            column(FourthMonth; ArrayMonth[4]) { }
            column(FifthMonth; ArrayMonth[5]) { }
            column(SixthMonth; ArrayMonth[6]) { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");

                trigger OnAfterGetRecord()
                begin
                    SalesInFirstMonthCalc();
                    SalesInSecondMonthCalc();
                    SalesInThirdMonthCalc();
                    SalesInFourthMonthCalc();
                    SalesInFifthMonthCalc();
                    SalesInSixthMonthCalc();
                    TotalSales := SalesInFirstMonth + SalesInSecondMonth + SalesInThirdMonth + SalesInFourthMonth + SalesInFifthMonth + SalesInSixthMonth;

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
        CompanyInfo: Record "Company Information";
        i: Integer;
    begin
        CompanyInfo.Get();
        CompanyName := CompanyInfo.Name;
        CompanyAddress := CompanyInfo.Address;
        CompanyPhn := CompanyInfo."Phone No.";
        ArrayMonthCalc[1] := CalcDate('CM-5M', ReportingDate);
        ArrayMonthCalc[2] := CalcDate('CM-4M', ReportingDate);
        ArrayMonthCalc[3] := CalcDate('CM-3M', ReportingDate);
        ArrayMonthCalc[4] := CalcDate('CM-2M', ReportingDate);
        ArrayMonthCalc[5] := CalcDate('CM-1M', ReportingDate);
        ArrayMonthCalc[6] := CalcDate('CM', ReportingDate);

        for i := 1 to 6 do
            ArrayMonth[i] := Format(ArrayMonthCalc[i], 0, '<Month Text,3>');
    end;

    local procedure SalesInFirstMonthCalc()
    var
        StartDate: Date;
        EndDate: Date;
    begin
        StartDate := CalcDate('-CM-5M', ReportingDate);
        EndDate := CalcDate('CM-5M', ReportingDate);
        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvoiceLine.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
        SalesInvoiceLine.SetRange("Posting Date", StartDate, EndDate);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            SalesInFirstMonth := SalesInvoiceLine.Amount;
        end
        else
            SalesInFirstMonth := 0;
    end;

    local procedure SalesInSecondMonthCalc()
    var
        StartDate: Date;
        EndDate: Date;
    begin
        StartDate := CalcDate('-CM-4M', ReportingDate);
        EndDate := CalcDate('CM-4M', ReportingDate);
        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvoiceLine.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
        SalesInvoiceLine.SetRange("Posting Date", StartDate, EndDate);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            SalesInSecondMonth := SalesInvoiceLine.Amount;
        end
        else
            SalesInSecondMonth := 0;
    end;

    local procedure SalesInThirdMonthCalc()
    var
        StartDate: Date;
        EndDate: Date;
    begin
        StartDate := CalcDate('-CM-3M', ReportingDate);
        EndDate := CalcDate('CM-3M', ReportingDate);
        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvoiceLine.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
        SalesInvoiceLine.SetRange("Posting Date", StartDate, EndDate);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            SalesInThirdMonth := SalesInvoiceLine.Amount;
        end
        else
            SalesInThirdMonth := 0;
    end;

    local procedure SalesInFourthMonthCalc()
    var
        StartDate: Date;
        EndDate: Date;
    begin
        StartDate := CalcDate('-CM-2M', ReportingDate);
        EndDate := CalcDate('CM-2M', ReportingDate);
        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvoiceLine.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
        SalesInvoiceLine.SetRange("Posting Date", StartDate, EndDate);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            SalesInFourthMonth := SalesInvoiceLine.Amount;
        end
        else
            SalesInFourthMonth := 0;
    end;

    local procedure SalesInFifthMonthCalc()
    var
        StartDate: Date;
        EndDate: Date;
    begin
        StartDate := CalcDate('-CM-1M', ReportingDate);
        EndDate := CalcDate('CM-1M', ReportingDate);
        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvoiceLine.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
        SalesInvoiceLine.SetRange("Posting Date", StartDate, EndDate);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            SalesInFifthMonth := SalesInvoiceLine.Amount;
        end
        else
            SalesInFifthMonth := 0;
    end;

    local procedure SalesInSixthMonthCalc()
    var
        StartDate: Date;
        EndDate: Date;
    begin
        StartDate := CalcDate('-CM', ReportingDate);
        EndDate := CalcDate('CM', ReportingDate);
        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvoiceLine.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
        SalesInvoiceLine.SetRange("Posting Date", StartDate, EndDate);
        if SalesInvoiceLine.FindSet() then begin
            SalesInvoiceLine.CalcSums(Amount);
            SalesInSixthMonth := SalesInvoiceLine.Amount;
        end
        else
            SalesInSixthMonth := 0;
    end;

    local procedure SalesByMonth()
    begin

    end;

    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        ReportingDate: Date;

        SalesInFirstMonth: Decimal;
        SalesInSecondMonth: Decimal;

        SalesInThirdMonth: Decimal;
        SalesInFourthMonth: Decimal;
        SalesInFifthMonth: Decimal;
        SalesInSixthMonth: Decimal;

        TotalSales: Decimal;

        CompanyName: Text[100];
        CompanyAddress: Text[100];
        CompanyPhn: Text[100];

        ArrayMonthCalc: array[6] of Date;
        ArrayMonth: array[6] of Text[20];

        StartDate: array[6] of Date;
        EndDate: array[6] of Date;

}