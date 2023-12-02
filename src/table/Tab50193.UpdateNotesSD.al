table 50193 UpdateNotesSD
{
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; Notes; Text[1000])
        {
            DataClassification = ToBeClassified;

        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}