page 70150 UpdateFieldValue
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = UpdateFieldValue;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(TableNo; Rec.TableNo)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        TableInfo: Record "Table Information";
                    begin
                        TableInfo.SetFilter("Table No.", '%1', Rec.TableNo);
                        if TableInfo.FindSet() then
                            Table := TableInfo."Table Name";
                    end;
                }
                field(Table; Table)
                {
                    ApplicationArea = all;

                }
                field(FieldNo; Rec.FieldNo)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        Field: Record Field;
                    begin
                        Field.SetFilter(TableNo, '%1', Rec.TableNo);
                        Field.SetFilter("No.", '%1', Rec.FieldNo);
                        if Field.FindSet() then
                            FieldName := Field.FieldName;
                    end;
                }
                field(FieldName; FieldName)
                {
                    ApplicationArea = all;
                }
                field("Existing Value"; Rec."Existing Value")
                {
                    ApplicationArea = all;
                    // trigger OnLookup(var Text: Text): Boolean
                    // var
                    //     myInt: Integer;
                    //     customer: Record Customer;
                    // begin
                    //     if Page.RunModal(Page::"Customer List", customer) = Action::LookupOK then begin
                    //         Text := customer.Name;
                    //         exit(true);
                    //     end;

                    // end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        RecRef.Open(Rec.TableNo);
                        VarRecRef := RecRef;
                        if Page.RunModal(0, VarRecRef) = Action::LookupOK then begin
                            FRef := RecRef.Field(rec.FieldNo);
                            Text := Format(FRef.Value);
                            exit(true);
                        end;

                    end;

                }
                field("New Value"; Rec."New Value")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UpdateFieldValue)
            {
                ApplicationArea = All;

                trigger OnAction()
                // var
                //     customer: Record Customer;
                begin
                    // customer.SetFilter(Name, Rec."Existing Value");
                    // if customer.FindSet() then begin
                    //     customer.Name := Rec."New Value";
                    //     customer.Modify();
                    //     Message('Value Updated');
                    // end;
                    FRef := RecRef.Field(Rec.FieldNo);
                    FRef.Value := Rec."New Value";
                    RecRef.Modify();
                    RecRef.Close();
                    Message('Record Modified');

                end;
            }
        }
    }

    var
        myInt: Integer;
        Table: Text[100];
        FieldName: Text[100];
        RecRef: RecordRef;
        FRef: FieldRef;
        RecID: RecordId;
        VarRecRef: Variant;
}