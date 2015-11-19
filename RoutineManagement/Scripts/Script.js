//Author: Scott Larkin
//Date: Sep 2015

var LastUniqueNumber = 0;

function GetUniqueNumber() {
    var d = Date.now();

    this.LastUniqueNumber = d <= this.LastUniqueNumber ? ++this.LastUniqueNumber : d;

    return this.LastUniqueNumber;
}

var RoutineManagement = angular.module("RoutineManagement", []);


RoutineManagement.controller("Schedule", function ($scope) {

    $scope.schedule = new document.ChecksheetLib.Schedule();

    $.ajax({
        url: "http://localhost:57425/Home/GetAreas",
        type: "GET",
        contentType: 'application/json;',
        dataType: 'json',

        success: function (data) {
            $scope.$apply(function () {
                $scope.areas = data;
                console.log(data);
            });
        },
        fail: function (data) {
            console.log('failed to lget areas: ');
        }

    });

    $scope.getTeamsByArea = function (areaName) {

        $.ajax({
            url: "http://localhost:57425/Home/GetTeamsByArea",
            type: "GET",
            contentType: 'application/json;',
            dataType: 'json',
            data: { AreaName: areaname },

            success: function (data) {
                $scope.$apply(function () {
                    $scope.Teams = data;
                });
            },
            fail: function (data) {
                console.log('failed to lget areas: ');
            }

        });
    }

    $scope.getUsersByTeam = function (teamName) {

        $.ajax({
            url: "http://localhost:57425/Home/GetUsersByTeam",
            type: "GET",
            contentType: 'application/json;',
            dataType: 'json',
            data: { TeamName: teamName },

            success: function (data) {
                $scope.$apply(function () {
                    $scope.Teams = data;
                });
            },
            fail: function (data) {
                console.log('failed to lget areas: ');
            }

        });
    }

    $scope.schedule.ScheduledRoutines.push(new document.ChecksheetLib.ScheduledRoutine());
    $scope.schedule.ScheduledRoutines.push(new document.ChecksheetLib.ScheduledRoutine());
    $scope.schedule.ScheduledRoutines.push(new document.ChecksheetLib.ScheduledRoutine());
    $scope.schedule.ScheduledRoutines.push(new document.ChecksheetLib.ScheduledRoutine());

    $scope.ScheduleRoutineClick = function () {

    }

    $scope.RoutineCLick = function () {

    }

});

//contains functionality for loading, viewing, and filling in routines
RoutineManagement.controller("CompleteRoutine", function ($scope) {

    $scope.fieldTypes = document.ChecksheetLib.FieldTypes;

    $.ajax({
        url: "http://localhost:57425/Home/LoadRoutine",
        type: "GET",
        contentType: 'application/json;',
        dataType: 'json',
        data: {RoutineID: routineID},

        success: function (data) {
            $scope.$apply(function () {
                $scope.routine = data;
            });
        },
        fail: function (data) {
            console.log('failed to load routine: ' + routineID);
        }

    });

});


//contsins functionality for creating or editing routines
RoutineManagement.controller("CreateRoutine", function ($scope) {
    $scope.routine = new document.ChecksheetLib.AgendaRoutine("test name", "test description");
    $scope.routine.Checksheets.push(new document.ChecksheetLib.CreateEmptyChecksheet());

    $scope.fieldTypes = document.ChecksheetLib.FieldTypes;

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

        var routine = $scope.routine;

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

    $scope.SaveRoutineClick = function()
    {
        document.ChecksheetLib.SaveRoutine($scope.routine);
    }

});

//TODO: Do this with AngularJS instead of jQuery...
function ValidateInput() {

    if (!$(this)[0].validity.valid) {
        $(this).addClass('checksheetTable--fieldInput--error');
    }
    else {
        $(this).removeClass('checksheetTable--fieldInput--error');
    }
}

$(document).on('keyup', '.js-input', ValidateInput);
          
    