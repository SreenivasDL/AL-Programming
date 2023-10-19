codeunit 50191 EventProceduresPermissions
{
    Permissions = tabledata Customer = rimd, tabledata "Sales Invoice Header" = rimd, tabledata "Job Task" = rimd, tabledata "Sales Header" = rimd;
    procedure CustomerGroup(CustomerNo: Code[20])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Customer: Record Customer;
    begin
        SalesInvoiceHeader.Reset();
        if (Customer.Get(CustomerNo) and (Customer."Customer Group" <> '')) then begin
            SalesInvoiceHeader.SetRange("Sell-to Customer No.", CustomerNo);
            if SalesInvoiceHeader.FindSet() then
                repeat
                    SalesInvoiceHeader."Customer Group" := Customer."Customer Group";
                    SalesInvoiceHeader.Modify();
                until SalesInvoiceHeader.Next() = 0;
        end;
    end;

    procedure JobTaskBuyout(JobNo: Code[20]; JobTaskNo: Code[20]; XrecBuyout: Decimal)
    var
        JobTask: Record "Job Task";
        CodeToInt: Integer;
    begin
        Clear(CodeToInt);
        if JobTask.Get(JobNo, JobTaskNo) then
            repeat
                if ((Evaluate(CodeToInt, JobTask."Job Task No.") = false)) then begin
                    JobTask.CalcFields("Schedule (Total Cost)");
                    JobTask.CalcFields("Schedule (Total Price)");
                    JobTask.Buyout := JobTask."Schedule (Total Cost)" + JobTask."Schedule (Total Price)";
                    if JobTask.Buyout <> XrecBuyout then
                        JobTask.Modify();
                end
                else begin
                    if JobTask.Buyout <> XrecBuyout then begin
                        JobTask.Buyout := 0;
                        JobTask.Modify();
                    end;
                end;
            until JobTask.Next() = 0;
    end;

}