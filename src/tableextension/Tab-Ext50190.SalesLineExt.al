tableextension 50190 SalesLineExt extends "Sales Line"
{
    fields
    {
        field(50190; BagSize; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}