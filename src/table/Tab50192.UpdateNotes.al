table 50192 UpdateNotes
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Name; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Notes; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Pending","Updated","Rejected";
        }
    }

    keys
    {
        key(pk; No, Name, Date, Status, Notes)
        {
            Clustered = true;
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