tableextension 50191 CustomerExt extends Customer
{
    fields
    {
        field(50190; "Customer Group"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50191; "Payment Collection Method"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
}