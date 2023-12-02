reportextension 50190 JobCreateSalesInvoiceExt extends "Job Create Sales Invoice"
{
    dataset
    {
        // Add changes to dataitems and columns here
    }

    requestpage
    {
        // Add changes to the requestpage here
        layout
        {
            addafter(PostingDate)
            {
                field(JobTaskNo; JobTaskNo)
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        JobTask: Record "Job Task";
                    begin
                        if Page.RunModal(Page::"Job List") = Action::LookupOK then
                            JobTask.SetRange("Job Task No.", JobTaskNo);
                        if JobTask.FindFirst() then begin
                            Temp := JobTask."Job Task No.";
                            "Job Task"."Job Task No." := Temp;
                            "Job Task".Modify();
                        end;
                    end;

                }
            }
        }
    }


    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }

    var
        JobTaskNo: Code[20];

        Temp: Code[30];
}