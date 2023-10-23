page 50194 SalesLinePart
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ChangeOrderRequest;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; ItemNo)
                {
                    ApplicationArea = All;
                    TableRelation = "Sales Line"."No." where("Document No." = field("Change Order No."));
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    TableRelation = "Sales Line".Description where("Document No." = field("Change Order No."));
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = all;
                    TableRelation = "Sales Line".Quantity where("Document No." = field("Change Order No."));
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                    TableRelation = "Sales Line".Amount where("Document No." = field("Change Order No."));
                }
            }
        }

    }

    var
        ItemNo: Code[20];
        Description: Text[100];
        Quantity: Decimal;
        Amount: Decimal;
}