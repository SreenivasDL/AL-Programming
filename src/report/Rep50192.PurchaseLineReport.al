report 50192 PurchaseLineReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'PurchaseLine1900SReport.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");

                dataitem(CopyLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    dataitem(PageLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(DocNo_; "Purchase Header"."No.")
                        {

                        }
                        column(Ship_to_Name; "Purchase Header"."Ship-to Name")
                        {

                        }
                        column(Ship_to_Address; "Purchase Header"."Ship-to Address")
                        {

                        }
                        column(No_; "Purchase Line"."No.")
                        {

                        }
                        column(Description; "Purchase Line".Description)
                        {

                        }
                        column(ItemNo; ItemNo)
                        {

                        }
                        column(ItemWeight; ItemWeight)
                        {

                        }
                        column(LOTNO; LOTNO)
                        {

                        }
                        column(Line_No_; "Purchase Line"."Line No.")
                        {

                        }
                        column(ShowUnitCost; ShowUnitCost)
                        {

                        }
                        column(Outputno; OutputNo)
                        {

                        }
                        column(CopyText; CopyText)
                        {

                        }
                    }
                    trigger OnAfterGetRecord();
                    begin
                        if Number > 1 then begin
                            CopyText := FormatDocument.GetCOPYText;
                            OutputNo += 1;
                        end
                    end;

                    trigger OnPreDataItem();
                    begin
                        if "Purchase Line"."No." = '1900-S' then begin
                            NoOfLoops := ABS(NoOfCopies) + 2;
                            CopyText := '';
                            SETRANGE(Number, 1, NoOfLoops);
                            OutputNo := 1;
                        end
                        else begin
                            NoOfLoops := ABS(NoOfCopies) + 1;
                            CopyText := '';
                            SETRANGE(Number, 1, NoOfLoops);
                            OutputNo := 1;
                        end;


                    end;
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    ItemUnitOfMeasure.SetFilter("Item No.", "Purchase Line"."No.");
                    if ItemUnitOfMeasure.FindSet() then
                        ItemWeight := ItemUnitOfMeasure.Weight;

                    ItemLedgerEntry.SetFilter("Item No.", "Purchase Line"."No.");
                    if ItemLedgerEntry.FindSet() then
                        LOTNO := ItemLedgerEntry."Lot No.";
                end;
            }
        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        myInt: Integer;

        ItemNo: code[20];
        LOTNO: Code[20];
        PurchaseLine: Record "Purchase Line";
        ItemWeight: Decimal;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemNoArray: array[100] of Code[30];

        ShowUnitCost: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        FormatDocument: Codeunit "Format Document";
}