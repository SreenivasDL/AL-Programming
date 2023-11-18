page 50196 UpdateNotes
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = UpdateNotes;
    Editable = true;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;

                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        Rec.Status := Rec.Status::Updated;
                        Rec.Modify();
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {

        }
    }


    actions
    {
        area(Processing)
        {
            action("Update Notes")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    UpdateNotesSD: Record UpdateNotesSD;
                begin
                    if Page.RunModal(50197, UpdateNotesSD) = Action::LookupOK then begin
                        if UpdateNotesSD.Notes <> '' then begin
                            Rec.Notes := UpdateNotesSD.Notes;
                            Rec.Status := Rec.Status::Updated;
                        end;
                    end;
                end;
            }
        }
    }

}