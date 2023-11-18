tableextension 50190 SalesLineExt extends "Sales Line"
{
    fields
    {
        field(50190; BagSize; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50191; "BC SO No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50192; "BC SO Doc Line No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}