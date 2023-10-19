pageextension 50200 UserSetupExt extends "User Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {
            field("Allow To Change Status"; Rec."Allow To Change Status")
            {
                ApplicationArea = all;
            }
        }
    }
}