report 50129 PrintingReportMultipleTimes
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    CaptionML = ENU = 'AL Item List ';
    DefaultLayout = RDLC;
    RDLCLayout = 'PrintingReportMultipleTimes.rdl';
    dataset
    {
        dataitem(Item; Item)
        {
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(ItemNo; Item."No.") { }
                    column(ItemName; Item.Description) { }
                    column(ItemUOM; Item."Base Unit of Measure") { }
                    Column(ItemCost; Item."Unit Cost") { }
                    column(ItemPrice; Item."Unit Price") { }
                    column(ShowUnitCost; ShowUnitCost) { }
                    column(Outputno; OutputNo) { }
                    column(CopyText; CopyText) { }
                }
                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText;
                        OutputNo += 1;
                    end;
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("Show Unit Cost"; ShowUnitCost)
                    { }
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Advanced;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        ShowUnitCost: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        FormatDocument: Codeunit "Format Document";
}