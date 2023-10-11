report 50195 QuantityBagSize
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'QuantityBagSize.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");


                dataitem(CopyLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    dataitem(PageLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(DocNo_; "Sales Header"."No.")
                        {

                        }
                        column(Ship_to_Name; "Sales Header"."Ship-to Name")
                        {

                        }
                        column(Ship_to_Address; "Sales Header"."Ship-to Address")
                        {

                        }
                        column(No_; "Sales Line"."No.")
                        {

                        }
                        column(Status; "Sales Header".Status)
                        {

                        }
                        column(Description; "Sales Line".Description)
                        {

                        }
                        column(ItemNo; ItemNo)
                        {

                        }
                        column(Line_No_; "Sales Line"."Line No.")
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
                        column(Remainder; Remainder)
                        {

                        }
                        column(Quotient; Quotient)
                        {

                        }
                        column(BagSize; "Sales Line".BagSize)
                        {

                        }

                    }
                    trigger OnAfterGetRecord();
                    begin
                        if Number > 1 then begin
                            OutputNo += 1;
                        end;

                    end;

                    trigger OnPreDataItem();
                    begin
                        NoOfLoops := NoOfCopies + CountOfLabelCopies;
                        SETRANGE(Number, 1, NoOfLoops);
                        OutputNo := 1;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    Clear(CountOfLabelCopies);
                    Clear(RoundedQuantity);
                    Clear(Quotient);
                    Clear(Remainder);
                    // if (NoOfCopies < 0) then
                    //     CountOfLabelCopies := 1;
                    if (NoOfCopies > 0) then
                        CountOfLabelCopies := 1;
                    if (NoOfCopies = 0) then begin
                        RoundedQuantity := ROUND("Sales Line".Quantity, 1, '=');
                        Quotient := RoundedQuantity DIV "Sales Line".BagSize;
                        Remainder := RoundedQuantity MOD "Sales Line".BagSize;
                    end;
                    if Remainder = 0 then
                        CountOfLabelCopies := Quotient
                    else
                        CountOfLabelCopies := Quotient + 1;
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
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = All;

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
        ItemNo: Code[20];

        Quotient: Integer;
        Remainder: Integer;
        CountOfLabelCopies: Integer;
        RoundedQuantity: Integer;
}