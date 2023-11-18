page 50195 PaymentJournalApproval
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Gen. Journal Line";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = all;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = all;
                }
                field("Recipient Bank Account"; Rec."Recipient Bank Account")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = all;
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = all;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = all;
                }
                field("Business Unit Code"; Rec."Business Unit Code")
                {
                    ApplicationArea = all;
                }
                field("Remit-to Code"; Rec."Remit-to Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Update Status")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.Modify();
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        PaymentJournal: Page "Payment Journal";
        GenJournalLine: Record "Gen. Journal Line";
    begin
        //PaymentJournal.PaymentJournalFilter();
        // GenJournalLine.SetRange("Journal Template Name", 'PAYMENT');
        // GenJournalLine.SetRange("Journal Batch Name", 'CASH');
        // if GenJournalLine.FindSet() then begin
        //     CurrPage.SetTableView(GenJournalLine);
        // end;

        // GenJournalLine.SetRange("Journal Template Name", GJournalTemplate);
        // GenJournalLine.SetRange("Journal Batch Name", GJournalBatch);
        // if GenJournalLine.FindSet() then begin
        //     CurrPage.SetTableView(GenJournalLine);
        // end;
    end;

    // procedure PaymentJournalFilter(JournalTemplate: Code[50]; JournalBatch: Code[50])
    // begin
    //     GJournalTemplate := JournalTemplate;
    //     GJournalBatch := JournalBatch;
    // end;

    var
        GJournalTemplate: Code[50];
        GJournalBatch: Code[50];
}