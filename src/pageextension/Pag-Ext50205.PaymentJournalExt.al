pageextension 50205 PaymentJournalExt extends "Payment Journal"
{
    layout
    {
        addafter(Description)
        {
            field("Approval Status"; Rec."Approval Status")
            {
                ApplicationArea = all;
                Editable = ApprovalStatusHandler;
            }
        }
    }

    actions
    {
        addafter(Reconcile)
        {
            action("Send for Approval")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    AGTSendEmailForApproval();
                end;
            }
        }
    }

    procedure AGTSendEmailForApproval()

    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        SendTo: Text;
        Outstr: OutStream;
        Reportparameter: Text;
        XmlParameters: Text;
        recRef: RecordRef;
        FileName: Text;
        E_Mail: Text;
        HyperLink: Text;
        Receipient: Text;
        UserSetup: Record "User Setup";
        PaymentJournal: Page "Payment Journal";
        GenJournalLine: Record "Gen. Journal Line";
        FilterPage: FilterPageBuilder;
    begin

        //PaymentJournalApproval.PaymentJournalFilter(Rec."Journal Template Name", Rec."Journal Batch Name");
        UserSetup.Get(UserId);
        Receipient := UserSetup."Approver Email";

        TempBlob.CreateOutStream(Outstr);
        TempBlob.CreateInStream(InStr);

        FileName := 'Click to Approve the Payment Journal';
        EmailMessage.Create(Receipient, '', '', true);
        E_Mail := 'Payment Journal Approval ';
        EmailMessage.AppendToBody(E_Mail);
        // GenJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        // GenJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        //HyperLink := '<a href=' + GetUrl(ClientType::Current, GenJournalLine.CurrentCompany, ObjectType::Page, Page::PaymentJournalApproval) + '>Click to open</a>';
        // //HyperLink := '<a href=' + GetUrl(ClientType::Current, GenJournalLine.CurrentCompany, ObjectType::Page, Page::PaymentJournalApproval) + '&filter=' + 'Document No.' + 'IS' + '1010' + '>Click to open</a>';
        HyperLink := '<a href=http://localhost:8080/BC220/?company=CRONUS%20USA%2C%20Inc.&page=50195&filter=%27Gen.%20Journal%20Line%27.%27Journal%20Template%20Name%27%20IS%20%27' + Rec."Journal Template Name" + '%27%20AND%20%27Gen.%20Journal%20Line%27.%27Journal%20Batch%20Name%27%20IS%20%27' + Rec."Journal Batch Name" + '%27>Click</a>';
        EmailMessage.AppendToBody(HyperLink);
        EmailMessage.SetSubject('Payment Journal Approval');
        Email.OpenInEditor(EmailMessage, Enum::"Email Scenario"::Default);


    end;

    var
        ApprovalStatusHandler: Boolean;
        PaymentJournalApproval: Page PaymentJournalApproval;
}