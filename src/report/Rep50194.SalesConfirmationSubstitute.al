report 50194 SalesConfirmationSubstitute
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'SalesConfirmationSubstitute.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(Bill_to_Name; "Bill-to Name") { }
            column(Bill_to_Address; "Bill-to Address") { }
            column(Bill_to_City; "Bill-to City") { }
            column(Bill_to_County; "Bill-to County") { }
            column(Bill_to_Post_Code; "Bill-to Post Code") { }
            column(Bill_to_Country_Region_Code; "Bill-to Country/Region Code") { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_County; "Ship-to County") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(No_; "No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
            column(Shipping_Agent_Code; "Shipping Agent Code") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Salesperson_Code; "Salesperson Code") { }
            column(Header_Shipment_Date; "Shipment Date") { }
            column(External_Document_No_; "External Document No.") { }
            column(SubtotalExclTax; SubtotalExclTax) { }
            column(SubtotalInclTax; SubtotalInclTax) { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Quantity; Quantity) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(ItemNo_; "No.") { }
                column(Description; Description) { }
                column(Shipment_Date; "Shipment Date") { }
                column(Unit_Price; "Unit Price") { }
                column(Amount_Including_VAT; "Amount Including VAT") { }

                dataitem("Company Information"; "Company Information")
                {
                    column(Picture; Picture) { }
                    column(Name; Name) { }
                    column(Address; Address) { }
                    column(Phone_No_; "Phone No.") { }
                    column(Fax_No_; "Fax No.") { }
                }
                trigger OnAfterGetRecord()
                var
                    SalesLine: Record "Sales Line";
                begin
                    SalesLine.Reset();
                    SalesLine.SetRange("Document No.", "Sales Header"."No.");
                    if SalesLine.FindSet() then begin
                        //Summing Line Amount of the orders in SalesLine based on current No.(Document No.)
                        SalesLine.CalcSums("Line Amount");
                        SubtotalExclTax := SalesLine."Line Amount";
                        //Summing Amt Inc VAT of the orders in SalesLine based on current No. (Document No.)
                        SalesLine.CalcSums("Amount Including VAT");
                        SubtotalInclTax := SalesLine."Amount Including VAT";
                    end;
                end;
            }

        }
    }
    trigger OnPreReport()
    var
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        SubtotalExclTax: Decimal;
        SubtotalInclTax: Decimal;
}