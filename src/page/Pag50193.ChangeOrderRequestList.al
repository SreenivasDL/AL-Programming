page 50193 ChangeOrderRequestList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ChangeOrderRequest;
    CardPageId = ChangeOrderRequest;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Change Order No."; Rec."Change Order No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

}