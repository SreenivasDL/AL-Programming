table 70151 UpdateFieldValue
{
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        // field(1; "Company Information"; Text[100])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Table Information"."Company Name";
        // }
        field(2; "TableNo"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Table Information"."Table No.";
        }
        field(3; Table; Text[30])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Table Information"."Table Name" where("Table No." = field(TableNo)));
        }
        field(4; FieldNo; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Field."No." where(TableNo = field(TableNo));

        }
        field(7; FieldName; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Existing Value"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "New Value"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; TableNo)
        {
            Clustered = true;
        }
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