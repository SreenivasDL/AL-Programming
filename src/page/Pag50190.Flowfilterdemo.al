page 50190 "Flowfilter demo"
{
    ApplicationArea = All;
    Caption = 'Flowfilter demo';
    PageType = List;
    SourceTable = "Flowfilter Demo";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = all;
                }
                field("Total Amount 2"; Rec."Total Amount")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
