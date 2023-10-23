table 50191 ChangeOrderRequest
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Change Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No.";

        }
        field(2; "Customer Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Sell-to Customer Name" where("No." = field("Change Order No.")));
        }
        field(3; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Open","Requested","Rejected","Approved";
        }
        field(4; Date; Date)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Change Order No.")
        {
            Clustered = true;
        }
    }

}