report 50196 CustomerDetailsList
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'CustomerDetailList.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            column(No; "Customer No.") { }
            column(Customer_Name; "Customer Name") { }
            column(InvoiceAmount; InvoiceAmount) { }
            column(CreMemoAmount; CreMemoAmount) { }
            column(CustomerNo; CustomerNo) { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(CustNoFiltered; CustNoFiltered) { }
            column(CustNameFiltered; CustNameFiltered) { }
            column(InvoiceAmtFiltered; InvoiceAmtFiltered) { }
            column(CreMemoFiltered; CreMemoFiltered) { }
            column(AppliedFilter; AppliedFilter) { }
            column(RowVisibility; RowVisibility) { }
            dataitem("Company Information"; "Company Information")
            {
                column(Name; Name) { }
                column(Address; Address) { }
            }
            trigger OnAfterGetRecord()
            var
                CustLedgerEntry: Record "Cust. Ledger Entry";
            begin
                CustLedgerEntry.Reset();
                CustLedgerEntry.SetRange("Customer No.", "Cust. Ledger Entry"."Customer No.");
                CustLedgerEntry.SetFilter("Document Type", '%1', "Document Type"::Invoice);
                if CustLedgerEntry.FindSet() then
                    repeat
                        CustLedgerEntry.CalcFields(Amount);
                        InvoiceAmount += CustLedgerEntry.Amount;
                    until CustLedgerEntry.Next() = 0;
                CustLedgerEntry.SetFilter("Document Type", '%1', "Document Type"::"Credit Memo");
                if CustLedgerEntry.FindSet() then
                    repeat
                        CustLedgerEntry.CalcFields(Amount);
                        CreMemoAmount += CustLedgerEntry.Amount;
                    until CustLedgerEntry.Next() = 0;

                //Filtered Data
                if ((CustomerNo <> '') AND (Format(StartDate) <> '') AND (Format(EndDate) <> '')) then begin
                    AppliedFilter := CustomerNo + ',' + Format(StartDate) + '..' + Format(EndDate);
                    RowVisibility := true;
                    CustLedgerEntry.SetRange("Customer No.", CustomerNo);
                    CustLedgerEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                    if CustLedgerEntry.FindSet() then begin
                        CustNoFiltered := CustLedgerEntry."Customer No.";
                        CustNameFiltered := CustLedgerEntry."Customer Name";
                    end;
                    CustLedgerEntry.SetFilter("Document Type", '%1', "Document Type"::Invoice);
                    if CustLedgerEntry.FindSet() then
                        repeat
                            CustLedgerEntry.CalcFields(Amount);
                            InvoiceAmtFiltered += CustLedgerEntry.Amount;
                        until CustLedgerEntry.Next() = 0;
                    CustLedgerEntry.SetFilter("Document Type", '%1', "Document Type"::"Credit Memo");
                    if CustLedgerEntry.FindSet() then
                        repeat
                            CustLedgerEntry.CalcFields(Amount);
                            CreMemoFiltered += CustLedgerEntry.Amount;
                        until CustLedgerEntry.Next() = 0;

                end
                else begin
                    AppliedFilter := '-';
                    RowVisibility := false;
                end;
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
                    field(CustomerNo; CustomerNo)
                    {
                        ApplicationArea = All;
                        TableRelation = Customer."No.";
                    }
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = all;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }

    }

    var
        CustomerNo: Code[20];
        StartDate: Date;
        EndDate: date;
        InvoiceAmount: Decimal;
        CreMemoAmount: Decimal;

        CustNoFiltered: Code[20];
        CustNameFiltered: Text;
        InvoiceAmtFiltered: Decimal;
        CreMemoFiltered: Decimal;
        AppliedFilter: Text;
        RowVisibility: Boolean;
}