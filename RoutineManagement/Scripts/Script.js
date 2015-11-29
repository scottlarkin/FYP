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

    var refreshSchedule = function () {
        $.ajax({
            url: "http://localhost:57425/Home/LoadSchedule",
            type: "GET",
            contentType: 'application/json;',
            dataType: 'json',

            success: function (data) {
                $scope.$apply(function () {
                    $scope.schedule = data;
                });
            },
            fail: function (data) {
                console.log('failed to load schedule: ');
            }

        });
    }

    refreshSchedule();

    $scope.predicate = 'DueOn';
    $scope.reverse = false;
    $scope.order = function (predicate) {
        $scope.reverse = ($scope.predicate === predicate) ? !$scope.reverse : false;
        $scope.predicate = predicate;
    };

    $scope.Areas = new Array();
    $scope.Routines = new Array();
    $scope.Teams = new Array();
    $scope.Users = new Array();

    $scope.TimePeriod = ['Days', 'Weeks', 'Months', 'Years'];
    $scope.PopupHidden = true;

    var resetSelections = function () {
        $scope.SelectedArea = '';
        $scope.SelectedRoutine = '';
        $scope.SelectedTeam = '';
        $scope.SelectedUser = '';
        $scope.SelectedDate = '';
        $scope.SelectedRate = 1;
        $scope.SelectedPeriod = $scope.TimePeriod[0];
        $scope.SelectedNumber = 1;
        $scope.PopupHidden = true;
    }

    resetSelections();

    $scope.Areas = document.ChecksheetLib.PlantAreas;

    $scope.getRoutinesByArea = function (areaName) {

        $.ajax({
            url: "http://localhost:57425/Home/GetRoutinesByArea",
            type: "GET",
            contentType: 'application/json;',
            dataType: 'json',
            data: { AreaName: areaName },

            success: function (data) {
                $scope.$apply(function () {
                    $scope.Routines = data;
                });
            },
            fail: function (data) {
                console.log('failed to get routines: ');
            }

        });
    }

    $scope.getTeamsByArea = function (areaName) {

        $.ajax({
            url: "http://localhost:57425/Home/GetTeamsByArea",
            type: "GET",
            contentType: 'application/json;',
            dataType: 'json',
            data: { AreaName: areaName },

            success: function (data) {
                $scope.$apply(function () {
                    $scope.Teams = data;
                });
            },
            fail: function (data) {
                console.log('failed to get teams: ');
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
                    $scope.Users = data;
                    $scope.SelectedTeam = teamName;
                });

            },
            fail: function (data) {
                console.log('failed to get users: ');
            }

        });
    }

    $scope.areaChanged = function (areaName) {
        $scope.getRoutinesByArea(areaName);
        $scope.getTeamsByArea(areaName);
    }

    //for some reason the ng-model on routine select / user select isnt working..?
    //funcs below is a work around to force seletced routine to update
    $scope.RoutineSelected = function (routine) {
        $scope.SelectedRoutine = routine;
    }

    $scope.userChanged = function (user) {
        $scope.SelectedUser = user;
    }

    $scope.SaveScheduleClick = function () {

        if ($scope.SelectedArea === '' || $scope.SelectedRoutine === '' || $scope.SelectedTeam === '' || $scope.SelectedDate === '') {
            var missingSelections = '';

            var addAnd = function (s) {

                missingSelections += missingSelections !== '' ? ', and ' + s : s;
            }

            //build a string to tell user which required input fields are missing
            if ($scope.SelectedArea === '') {
                missingSelections += 'an Area';
            }
            if ($scope.SelectedRoutine === '') {
                addAnd('a Routine');
            }
            if ($scope.SelectedTeam === '') {
                addAnd('a Team');
            }
            if ($scope.SelectedDate === '') {
                addAnd('a Date');
            }

            //TODO: 
            //alert is a bit primitive... make my own popup dialog / find dsomething online. LOW PRIORITY
            alert('Must select ' + missingSelections);

            return;
        }

        var sr = new document.ChecksheetLib.ScheduledRoutine();
        sr.AssignedUser = $scope.SelectedUser;
        sr.AssignedTeam = $scope.SelectedTeam;
        sr.DueOn = $scope.SelectedDate;
        sr.Routine = $scope.SelectedRoutine;
        sr.Rate = $scope.SelectedRate;
        sr.Period = $scope.SelectedPeriod;
        sr.Number = $scope.SelectedNumber;
        
        $.ajax({
            url: "http://localhost:57425/Home/ScheduleRoutine",
            type: "POST",
            contentType: 'application/json;',
            dataType: 'json',
            data: JSON.stringify(sr),

            success: function () {
            },
            fail: function () {
                alert('Failed to schedule routine ');
            }

        });

        resetSelections();

        refreshSchedule();

    }

    $scope.ScheduleRoutineClick = function () {
        if ($scope.Areas === null) {
            $scope.Areas = document.ChecksheetLib.PlantAreas;
        }
        $scope.PopupHidden = false;
    }

    $scope.CancelScheduleClick = function () {
        $scope.PopupHidden = true;
        resetSelections();
    }

    $scope.RoutineClick = function (routineID) {
        window.location.href = 'Home/Routine?routineID=' + routineID;
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
        data: { RoutineID: routineID },

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

    $scope.routine = new document.ChecksheetLib.AgendaRoutine("New Routine", "Routine description");
    $scope.routine.Checksheets.push(new document.ChecksheetLib.CreateEmptyChecksheet());

    $scope.fieldTypes = document.ChecksheetLib.FieldTypes;
    $scope.areas = document.ChecksheetLib.PlantAreas;
    $scope.SelectedArea = null;


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

    $scope.SaveRoutineClick = function () {

        var errors = $('.checksheetTable--fieldInput--error');
        console.log(errors);
        if (errors.length > 0) {
            alert("Must resolve errors before saving");
            return;
        }

        document.ChecksheetLib.SaveRoutine($scope.routine);
    }

    $scope.ValidateRoutineName = function (rn, a) {

        $.ajax({
            url: "http://localhost:57425/Home/ValidateRoutineName",
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

