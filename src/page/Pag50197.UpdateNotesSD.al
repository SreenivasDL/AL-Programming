page 50197 UpdateNotesSD
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = UpdateNotesSD;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;

                }
                // field(Notes; Notes)
                // {
                //     ApplicationArea = all;
                // }

            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Insert(true);
    end;

    // trigger OnClosePage()
    // begin
    //     if CurrPage.RunModal() = Action::OK then
    //         Message('Hurray');
    // end;


    var
        Notes: Text[1000];
}