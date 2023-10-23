codeunit 50190 EventSubscriberList
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Standard Sales - Order Conf." then
            NewReportId := Report::SalesConfirmationSubstitute;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Customer Templ. Mgt.", 'OnApplyTemplateOnBeforeCustomerModify', '', false, false)]
    local procedure TemplateApply(var Customer: Record Customer; CustomerTempl: Record "Customer Templ.")
    begin
        Customer."Payment Collection Method" := CustomerTempl."Payment Collection Method";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Invoices", 'OnAfterActionEvent', "Generate Customer Group", false, false)]
    local procedure ActionCall(var Rec: Record "Sales Invoice Header")
    begin
        EventProceduresPermissions.CustomerGroup(Rec."Sell-to Customer No.");
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeValidateEvent, "Bill-to Contact No.", false, false)]
    // local procedure MyProcedure(var Rec: Record "Sales Header")
    // var
    //     Contact: Record Contact;
    // begin
    //     if Page.RunModal(5052, Contact) = Action::LookupOK then
    //         Message('hi');
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeLookupContact', '', true, true)]
    // local procedure MyProcedure()
    // begin
    //     Message('hi');
    // end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", OnAfterActionEvent, 'Release', true, true)]
    local procedure OpenToRelease(var Rec: Record "Sales Header")
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get('DESKTOP-L86DHRF\SREENIVAS');
        if (UserSetup."Allow To Change Status") = true then begin
            Rec.Status := Rec.Status::Released;
            Rec.Modify();
        end
        else begin
            Rec.Status := Rec.Status::Open;
            Rec.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", OnAfterActionEvent, 'Reopen', true, true)]
    local procedure ReleaseToOpen(var Rec: Record "Sales Header")
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get('DESKTOP-L86DHRF\SREENIVAS');
        if UserSetup."Allow To Change Status" = true then begin
            Rec.Status := Rec.Status::Open;
            Rec.Modify();
        end
        else begin
            Rec.Status := Rec.Status::Released;
            Rec.Modify();
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post and Send", 'OnBeforeConfirmPostAndSend', '', true, true)]
    local procedure MyProcedure(var IsHandled: Boolean; var Result: Boolean; var TempDocumentSendingProfile: Record "Document Sending Profile" temporary; SalesHeader: Record "Sales Header")
    begin
        IsHandled := true;
        if IsHandled = true then
            if PAGE.RunModal(PAGE::"Customer Card", TempDocumentSendingProfile) <> ACTION::Yes then
                exit;
    end;

    var
        EventProceduresPermissions: Codeunit EventProceduresPermissions;

}