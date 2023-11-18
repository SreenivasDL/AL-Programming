tableextension 50195 UserSetupExt extends "User Setup"
{
    fields
    {
        field(50190; "Allow To Change Status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50191; "Approver Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50192; "Approver Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

}