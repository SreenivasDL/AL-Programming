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

    procedure CustomEMail()
    var
        EmailEditor: Page "Email Editor";
    begin
        EmailEditor.Run();
    end;

    procedure SendAnEMail()
    var
        Email: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
    begin
        EmailMsg.Create('AGT@gmail.com', 'Sending my custom Mail', '');
    end;

    procedure AGTCreateNewItemOnAirtable(VAR AGTItemRec: Record Item)
    var
        HttpClient: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        RequestHeaders: HttpHeaders;

        Response: Text;


        ContentHeaders: HttpHeaders;
        HttpContent: HttpContent;
        Token: Text;
        url: Text;
        AGTJsonObj: JsonObject;
        AGTJsonIDValue: JsonValue;
        AGTJsonToken: JsonToken;

    begin
        url := 'https://api.airtable.com/v0/appHcYLyoslhkc8sa/tbl0OUPEayHbgSCFc';
        Token := 'patFiIAp9XIULr5MG.fae4e723af681458d6ac0d93572bef24247786ef97ca8d381b789cd2cb617cef';
        RequestMessage.SetRequestUri(Url);
        RequestMessage.Method('GET');
        RequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Add('Authorization', 'Bearer ' + Token);


        // HttpContent.WriteFrom('{"records": [{"fields": {"Item No": "21729","Description": "APP LBH-300","Item Category": "CONDULET","Unit Price": 0,"Quantity Available": 4}}]}');
        // HttpContent.WriteFrom('{"fields": {"Item No": "' + AGTItemRec."No." + '","Description": "' + AGTItemRec.Description + '","Item Category": "' + AGTItemRec."Item Category Code" + '","Unit Price": ' + Format(AGTItemRec."Unit Price") + ',"Quantity Available": ' + Format(AGTItemRec."Unit Price") + ' }}');
        // HttpContent.GetHeaders(ContentHeaders);
        // ContentHeaders.Remove('Content-Type');
        // ContentHeaders.Add('Content-Type', 'application/json');
        // HttpContent.GetHeaders(ContentHeaders);
        // RequestMessage.Content(HttpContent);

        if HttpClient.Send(RequestMessage, ResponseMessage) then begin
            ResponseMessage.Content.ReadAs(Response);
            if ResponseMessage.IsSuccessStatusCode then begin
                // AGTJsonObj.ReadFrom(Response);
                // AGTJsonObj.Get('id', AGTJsonToken);

                // AGTItemRec.AGTAirtableID := AGTJsonToken.AsValue().AsCode();
                // AGTItemRec.Modify();
                Message('Response : %1', Response);
                //Update the in the table for that created item

            end else
                Message('Request failed!: %1', Response);
        end;
    end;

}