page 50191 DateCalculator

{

    PageType = Card;

    ApplicationArea = All;

    UsageCategory = Administration;

    Caption = 'Play with dates!';



    layout

    {

        area(Content)

        {

            group("Result Data")

            {

                field(UserDate; UserDate)

                {

                    ApplicationArea = All;

                }

            }

        }

    }



    actions

    {

        area(Processing)

        {

            action("Quick Check")

            {

                ApplicationArea = All;

                Image = DateRange;



                trigger OnAction()

                begin

                    Resultant_Date(UserDate);

                end;

            }

        }

    }



    var

        cust: Record Customer;


        Res: Date;

        Res1: Date;

        Res2: Date;

        Res3: Date;

        UserDate: Date;

        Final1: Integer;
        Final2: Integer;


    local procedure Resultant_Date(var UserIn: Date)

    begin

        Res := CalcDate('-CM', UserIn);
        // Final1 := Date2DMY(Res, 2);
        Message(Format(Res));

        Res2 := CalcDate('CM', UserIn);
        Message(Format(Res2));


        // Res1 := CalcDate('CM-2M', UserIn);
        // Final2 := Date2DMY(Res1, 2);
        // Message(Format(Res1));
        // Message(Format(Final2));


    end;

}