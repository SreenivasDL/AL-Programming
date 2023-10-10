codeunit 50190 EventSubscriberList
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Standard Sales - Order Conf." then
            NewReportId := Report::SalesConfirmationSubstitute;
    end;
}