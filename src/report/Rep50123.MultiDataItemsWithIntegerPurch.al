report 50123 MultiDataItemsWithIntegerPurch
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'MultiDataItemsWithIntegerPurch.rdl';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = where("No." = const('01863656'));
            column(No_; "No.")
            {

            }
        }
        dataitem(Integer; Integer)
        {
            column(VenNo; VenNo)
            {

            }
            column(DocNo; DocNo)
            {

            }
            column(Type_; Type)
            {

            }
            column(LineNo; LineNo)
            {

            }
            column(No; No)
            {

            }
            column(DocType; DocType)
            {

            }
            column(Amt; Amt)
            {

            }
            trigger OnPreDataItem()
            begin
                TestInteger(Vendor."No.");
                if (CountPurchInvLine + CountPurchCrLine) = 0 then
                    CurrReport.Break();
                Integer.SetFilter(Number, '%1..%2', 1, (CountPurchInvLine + CountPurchCrLine));
                PurchInvLine.FindSet();
                PurchCrLine.FindSet();
            end;

            trigger OnAfterGetRecord()
            begin
                if Integer.Number <= CountPurchInvLine then begin
                    VenNo := PurchInvLine."Buy-from Vendor No.";
                    DocNo := PurchInvLine."Document No.";
                    LineNo := PurchInvLine."Line No.";
                    Type := PurchInvLine.Type;
                    No := PurchInvLine."No.";
                    DocType := 'Invoice';
                    Amt := PurchInvLine.Amount;
                    PurchInvLine.Next();
                end
                else begin
                    VenNo := PurchCrLine."Buy-from Vendor No.";
                    DocNo := PurchCrLine."Document No.";
                    LineNo := PurchCrLine."Line No.";
                    Type := PurchCrLine.Type;
                    No := PurchCrLine."No.";
                    DocType := 'Credit Memo';
                    Amt := PurchCrLine.Amount;
                    PurchCrLine.Next();
                end;
            end;
        }
    }

    procedure TestInteger(VenNo: Code[20])
    begin
        PurchInvLine.SetFilter("Buy-from Vendor No.", VenNo);
        CountPurchInvLine := PurchInvLine.Count;

        PurchCrLine.SetFilter("Buy-from Vendor No.", VenNo);
        CountPurchCrLine := PurchCrLine.Count;
    end;

    var
        VenNo: Code[20];
        DocNo: Code[20];
        No: Code[20];
        LineNo: Integer;
        Type: Enum "Purchase Line Type";

        DocType: Text[20];

        Amt: Decimal;

        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrLine: Record "Purch. Cr. Memo Line";

        CountPurchInvLine: Integer;
        CountPurchCrLine: Integer;
}