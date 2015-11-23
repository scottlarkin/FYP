//Author: Scott Larkin
//Date: Sep 2015


document.ChecksheetLib =
{
 
    FieldTypes: [
            { id: '1', name: 'Text', htmlType: "text" },
            { id: '2', name: 'Checkbox', htmlType: "checkbox" },
            { id: '3', name: 'Number', htmlType: "number" }
    ],

    Schedule:function(){
        this.ScheduledRoutines = new Array();
    },

    ScheduledRoutine: function () {
        this.Area = null;
        this.AssignedTeam = null;
        this.AssignedUser = null;
        this.DueOn = null;
        this.CompletedOn = null;
        this.CompletedBy = null;
        this.Routine = null;
    },

    AgendaRoutine: function (Name, Description, Area, ID) {
        console.log(routineID);
        this.ID = routineID || 300;
        this.Name = Name || "New Routine";
        this.Description = Description || "desc ";
        this.Area = Area;
        this.Checksheets = new Array();
    },

    Checksheet: function (Name, Description, ID) {
        this.ID = ID;
        this.Name = Name || "New Checksheet";
        this.Description = Description || "desc ";
        this.Records = new Array();
        this.Fields = new Array();
    },

    Record: function (Name) {

        this.Name = Name || "New Record";
        this.FieldValues = new Array();
    },

    Field: function (Name, Editable, Persistant, TypeID) {

        this.Name = Name || "New Field";
        this.Editable = Editable || true;
        this.Type = document.ChecksheetLib.FieldTypes[0];
        this.TypeID = this.Type.ID;
    },

    FieldValue: function (Value, Editable) {
        this.Value = Value;
        this.Editable = Editable;
    },

    ScheduledRoutine: function(){
        this.RoutineName = '';
        this.CreatedBy = '';
        this.DueDate = '';
        this.CompletedBy = '';
    },

    AddRecordToChecksheet: function (Checksheet, Record) {

        //dont add fieldvalues to title record
        if (Checksheet.Records.length >= 1) {

            var f;

            for (var i = 0; i < Checksheet.Fields.length; i++) {

                f = Checksheet.Fields[i];
                Record.FieldValues.push(new this.FieldValue(null, f.Editable));
            }
        }

        Checksheet.Records.push(Record);
    },

    AddFieldToChecksheet: function (Checksheet, Field) {

        Checksheet.Fields.push(Field);

        //start loop at 1 to skip title record
        for (var i = 1; i < Checksheet.Records.length; i++) {
            Checksheet.Records[i].FieldValues.push(new this.FieldValue(null, Field.Editable, Field.Persistant));
        }
    },

    SaveRoutine: function (Routine) {
        console.log("saving");
        $.ajax({
            url: "http://localhost:57425/Home/SaveRoutine",
            type: "POST",
            contentType: 'application/json;',
            dataType: 'json',
            data: JSON.stringify(Routine),

            success: function () {

            },
            fail: function () {

            }

        });
    },

    CreateEmptyChecksheet: function (Name, Description) {
        var lib = document.ChecksheetLib;
        var sheet = new lib.Checksheet(Name, Description);
        
        lib.AddRecordToChecksheet(sheet, new lib.Record("Title Record"));
        lib.AddRecordToChecksheet(sheet, new lib.Record("Record 1"));
        lib.AddFieldToChecksheet(sheet, new lib.Field("Field 1", true, false));

        return sheet;
    }

};

