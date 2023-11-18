tableextension 50198 NonStockItemExt extends "Nonstock Item"
{
    fields
    {
        // Add changes to table fields here
        field(50190; "Lead Time Calculation"; DateFormula)
        {
            FieldClass = FlowField;
            //CalcFormula=lookup(Item."Lead Time Calculation" where("Vendor No."=field("Vendor No."),"Vendor Item No."=field("Vendor Item No.")));
            CalcFormula = lookup(Vendor."Lead Time Calculation" where("No." = field("Vendor No.")));
        }

    }
}