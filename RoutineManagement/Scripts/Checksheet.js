//Author: Scott Larkin
//Date: Sep 2015


document.ChecksheetLib =
{
    //ares and types loaded from db, see Init function
    PlantAreas: null,
    FieldTypes: null,

    Schedule:function(){
        this.ScheduledRoutines = new Array();
    },

    ScheduledRoutine: function (au, at, d, co, cb, r, rate, period, number  ) {
        this.AssignedUser = au;
        this.AssignedTeam = at;
        this.DueOn = d;
        this.CompletedOn = co;
        this.CompletedBy = cb;
        this.Routine = r;
        this.Rate = rate || 1;
        this.Period = period || 'Days';
        this.Number = number || 1;
    },

    AgendaRoutine: function (Name, Description, Area, ID) {

        this.ID = routineID || -1;
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
    },

    Init: function () {

        $.ajax({
            url: "http://localhost:57425/Home/GetAreas",
            type: "GET",
            contentType: 'application/json;',
            dataType: 'json',
            async: false,
            success: function (data) {
                document.ChecksheetLib.PlantAreas = data;
            },
            fail: function (data) {
                console.log('failed to get areas: ');
            }

        });

        $.ajax({
            url: "http://localhost:57425/Home/GetFieldTypes",
            type: "GET",
            contentType: 'application/json;',
            dataType: 'json',
            async: false,
            success: function (data) {
                document.ChecksheetLib.FieldTypes = data;
            },
            fail: function (data) {
                console.log('failed to get types: ');
            }

        });

    }
    
};

document.ChecksheetLib.Init();
