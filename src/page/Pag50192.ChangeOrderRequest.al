page 50192 ChangeOrderRequest
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ChangeOrderRequest;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Change Order No."; Rec."Change Order No.")
                {
                    ApplicationArea = all;
                    Editable = ChangeOrderNoEditHandler;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        ChangeOrderRequest: Page ChangeOrderRequest;
                        SalesLinePart: Page SalesLinePart;
                    begin
                        if Rec.Status = Rec.Status::Requested then
                            ChangeOrderNoEditHandler := false
                        else
                            ChangeOrderNoEditHandler := true;

                        if Rec.Status = Rec.Status::Open then
                            CaptionClassExpr := 'Changed Date'
                        else
                            CaptionClassExpr := 'Date';

                        if Rec.Status = Rec.Status::Approved then begin
                            ChangeOrderRequest.SetRecord(Rec);
                            SalesLinePart.SetRecord(Rec);
                            ChangeOrderRequest.Editable(false);
                            CurrPage.Close();
                            ChangeOrderRequest.Run();
                        end;

                    end;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    CaptionClass = CaptionClassExpr;
                }
            }
            group("ListPart")
            {
                part("List Part"; SalesLinePart)
                {
                    ApplicationArea = all;
                    SubPageLink = "Change Order No." = field("Change Order No.");
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Make Editable")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    ChangeOrderRequest: Page ChangeOrderRequest;
                begin
                    if Rec.Status = Rec.Status::Approved then begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                        ChangeOrderRequest.SetRecord(Rec);
                        CurrPage.Close();
                        ChangeOrderRequest.Editable(true);
                        ChangeOrderRequest.Run();

                    end;

                end;
            }
        }

    }

    var
        ChangeOrderNoEditHandler: Boolean;
        CaptionClassExpr: Text;

}