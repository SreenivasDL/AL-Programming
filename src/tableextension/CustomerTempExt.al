tableextension 50193 CustomerTempExt extends "Customer Templ."
{
    fields
    {
        // Add changes to table fields here
        field(50190; "Payment Collection Method"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}