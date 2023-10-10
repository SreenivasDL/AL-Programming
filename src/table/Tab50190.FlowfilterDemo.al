table 50190 "Flowfilter Demo"
{
    Caption = 'Flowfilter Demo';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = Customer."No.";
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("No.")));
        }
        field(3; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Posting Date" = field("Date Filter")));
        }
        field(4; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
