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

    var
        EventProceduresPermissions: Codeunit EventProceduresPermissions;

}