
//contsins functionality for creating or editing routines
RoutineManagement.controller("CreateRoutine", function ($scope) {

    $scope.Loaded = false;

    var LoadRoutines = function () {
        $.ajax({
            url: "http://localhost:57425/Routine/GetRoutineList",
            type: "GET",
            dataType: "json",
            success: function (data) {

                $scope.$apply(function () {
                    $scope.routines = data;
                    $scope.Loaded = true;
                });
            },
            error: function (data) {
                console.log("failed to load list of routines");
                
            },

        });
    }

    var ShowRoutine = function () {
        $('.js-routineTableWrap').addClass('hidden');
        $('.js-routineWrap').removeClass('hidden');
    }

    var ShowTable = function () {
        $('.js-routineWrap').addClass('hidden');
        $('.js-routineTableWrap').removeClass('hidden');
    }

    LoadRoutines();

    $scope.fieldTypes = document.ChecksheetLib.FieldTypes;
    $scope.areas = document.ChecksheetLib.PlantAreas;

    $scope.NewRoutineClick = function () {
        document.ChecksheetLib.Init();
        $scope.routine = new document.ChecksheetLib.AgendaRoutine("New Routine", "Routine description");
        $scope.routine.Checksheets.push(new document.ChecksheetLib.CreateEmptyChecksheet());
        $scope.routine.Area = $scope.areas[0];

        ShowRoutine();
    }

    $scope.RoutineTableRowClick = function (RoutineId) {

        $scope.Loaded = false;

        $.ajax({
            url: "http://localhost:57425/Routine/LoadRoutine",
            type: "GET",
            dataType: "json",
            contentType: "application/json",
            data: { RoutineID: RoutineId },
            success: function (data) {

                $scope.$apply(function () {
                    $scope.routine = document.ChecksheetLib.FormatRoutine(data);;
                    
                    SetFieldTypes();

                    $scope.Loaded = true;
                });

            },
            error: function (data) {
                console.log("failed to load selected routine");
                console.log(data);
            },
            complete: function () {
                ShowRoutine();
            }
        });


    }

    var SetFieldTypes = function () {

        for (var i = 0; i < $scope.routine.Checksheets.length; i++) {

            for (var j = 0; j < $scope.routine.Checksheets[i].Fields.length; j++) {
                $scope.routine.Checksheets[i].Fields[j].Type = $scope.fieldTypes[$scope.routine.Checksheets[i].Fields[j].TypeID - 1];
            }
        }
    }

    $scope.UpdateTypeID = function (Field, csIdx, fIdx) {

        for (var i = 1; i < $scope.routine.Checksheets[csIdx].Records.length; i++) {

            $scope.routine.Checksheets[csIdx].Records[i].FieldValues[fIdx].Value = '';
        }

        Field.TypeID = Field.Type.ID;
    }

    $scope.AddChecksheetClick = function () {
        $scope.routine.Checksheets.push(new document.ChecksheetLib.CreateEmptyChecksheet());
    }

    $scope.AddRecordClick = function (Checksheet) {
        document.ChecksheetLib.AddRecordToChecksheet(Checksheet,
            new document.ChecksheetLib.Record("Record " + Checksheet.Records.length));

        var records = Checksheet.Records;
        var fields = Checksheet.Fields;

        for (var i = 0; i < fields.length; i++) {
            records[records.length - 1].FieldValues.Type = fields[i].Type;
        }
    }

    $scope.AddFieldClick = function (Checksheet) {
        document.ChecksheetLib.AddFieldToChecksheet(Checksheet,
            new document.ChecksheetLib.Field("Field " + (Checksheet.Fields.length + 1)));
    }

    $scope.RemoveRecordClick = function (Checksheet, RecordIdx) {
        Checksheet.Records.splice(RecordIdx, 1);
    }

    $scope.RemoveFieldClick = function (Checksheet, FieldIdx) {

        Checksheet.Fields.splice(FieldIdx, 1);

        //remove fieldvalue from each record
        for (var i = 0; i < Checksheet.Records.length; i++) {
            Checksheet.Records[i].FieldValues.splice(FieldIdx, 1);
        }
    }

    $scope.MoveChecksheetClick = function (ChecksheetIndex, Direction) {

        var routine = $scope.routine;routine;

        //dont allow moving up and down if sheet is first/last respectively
        if (Direction === 1 && ChecksheetIndex === routine.Checksheets.length - 1 ||
            Direction === -1 && ChecksheetIndex === 0) {
            return;
        }

        var sheet = routine.Checksheets[ChecksheetIndex];

        //move sheet up or down
        routine.Checksheets.splice(ChecksheetIndex, 1);
        routine.Checksheets.splice(ChecksheetIndex + Direction, 0, sheet);
    }

    $scope.RemoveChecksheetClick = function (idx) {

        if (confirm('Are you sure you want to remove this checksheet?')) {
            $scope.routine.Checksheets.splice(idx, 1);
        }
    }

    $scope.SaveRoutineClick = function () {

        var errors = $('.checksheetTable--fieldInput--error');

        if (errors.length > 0) {
            alert("Must resolve errors before saving");
            return;
        }

        document.ChecksheetLib.SaveRoutine($scope.routine);
        location.reload();
    }

    $scope.ValidateRoutineName = function (rn, a) {

        $.ajax({
            url: "http://localhost:57425/Routine/ValidateRoutineName",
            type: "GET",
            dataType: 'text',
            contentType: 'json',
            data: {
                routineName: rn,
                area: a
            },
            success: function (data) {

                if (data === 'Error') {
                    $('#RoutineNameInput').addClass('checksheetTable--fieldInput--error');
                } else {
                    $('#RoutineNameInput').removeClass('checksheetTable--fieldInput--error');
                }
            }

        });
    }

});