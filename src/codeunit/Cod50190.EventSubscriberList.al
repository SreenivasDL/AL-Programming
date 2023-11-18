codeunit 50190 EventSubscriberList
{

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    // local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    // begin
    //     if ReportId = Report::"Standard Sales - Order Conf." then
    //         NewReportId := Report::SalesConfirmationSubstitute;
    // end;

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

    // [EventSubscriber(ObjectType::Table, Database::"Document Sending Profile", 'OnBeforeSend', '', false, false)]
    // local procedure OnBeforeSendHandler(CustomerFieldNo: Integer; DocName: Text[150]; DocNo: Code[20]; DocumentNoFieldNo: Integer; RecordVariant: Variant; ReportUsage: Integer; sender: Record "Document Sending Profile"; ToCust: Code[20]; var IsHandled: Boolean)
    // begin
    //     Message('hi');
    //     IsHandled := true;

    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeSendEmail', '', true, true)]
    // local procedure MyProcedure(var IsHandled: Boolean)
    // begin
    //     IsHandled := true;
    //     Message('hi');
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnBeforeInsertEvent', '', true, true)]
    local procedure OnBeforeInsertEventHandler(var Rec: Record "Tracking Specification")
    begin
        Rec."Quantity (Base)" := 1;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Contact Card", OnBeforeActionEvent, "Create Sales Order", true, true)]
    local procedure OnBeforeActionEventHandler(var Rec: Record Contact)
    var
        SalesHeader: Record "Sales Header";
        ContactBusinessRelation: Record "Contact Business Relation";
        CustomerRec: Record Customer;
    begin
        Rec.TestField("Company No.");
        ContactBusinessRelation.Reset();
        ContactBusinessRelation.SetRange("Contact No.", Rec."No.");
        if ContactBusinessRelation.FindFirst() then begin
            SalesHeader.Init();
            SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
            SalesHeader.Insert(true);
            CustomerRec.Get(ContactBusinessRelation."No.");
            SalesHeader.Validate("Sell-to Customer No.", CustomerRec."No.");
            SalesHeader.Validate("Salesperson Code", CustomerRec."Salesperson Code");
            SalesHeader.Modify();
            Message('Sales Order has been created with order number %1', SalesHeader."No.");
            if Confirm('Do you want to open the Sales Order ' + SalesHeader."No.", true) then
                Page.Run(Page::"Sales Order", SalesHeader)
            else
                exit;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', "Direct Unit Cost", true, true)]
    local procedure DirectUnitCostHandler(var Rec: Record "Purchase Line")
    var
        PurchaseLine: Record "Purchase Line";
        Temp: Decimal;
    begin
        Rec.Modify();
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", Rec."Document No.");
        if PurchaseLine.FindSet() then
            repeat
                Temp += PurchaseLine."Direct Unit Cost" * PurchaseLine."Qty. to Invoice";
            until PurchaseLine.Next() = 0;
        Rec."Total Cost to Invoice" := Temp;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterValidateEvent, "Qty. to Invoice", true, true)]
    local procedure QuantityRecievedHandler(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line")
    var
        PurchaseLine: Record "Purchase Line";
        Temp: Decimal;
    begin
        Rec.Modify();
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", Rec."Document No.");
        if PurchaseLine.FindSet() then
            repeat
                Temp += PurchaseLine."Direct Unit Cost" * PurchaseLine."Qty. to Invoice";
            until PurchaseLine.Next() = 0;
        Rec."Total Cost to Invoice" := Temp;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', "Qty. to Receive", true, true)]
    local procedure MyProcedure(var Rec: Record "Purchase Line")
    var
        PurchaseLine: Record "Purchase Line";
        Temp: Decimal;
    begin
        Rec.Modify();
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", Rec."Document No.");
        if PurchaseLine.FindSet() then
            repeat
                Temp += PurchaseLine."Direct Unit Cost" * PurchaseLine."Qty. to Invoice";
            until PurchaseLine.Next() = 0;
        Rec."Total Cost to Invoice" := Temp;
    end;

    var
        EventProceduresPermissions: Codeunit EventProceduresPermissions;


}