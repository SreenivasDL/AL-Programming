codeunit 50191 EventProceduresPermissions
{
    Permissions = tabledata Customer = rimd, tabledata "Sales Invoice Header" = rimd;
    procedure CustomerGroup(var CustomerNo: Code[20])
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
}