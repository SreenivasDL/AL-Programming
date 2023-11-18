pageextension 50200 UserSetupExt extends "User Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {
            field("Allow To Change Status"; Rec."Allow To Change Status")
            {
                Visible = false;
            }

            field("Approve By"; Rec."Approver Name")
            {
                ApplicationArea = all;
                Caption = 'Approver Name';
            }

            field("Approver Email"; Rec."Approver Email")
            {
                ApplicationArea = all;
            }
        }
    }
}