//Author: Scott Larkin
//Date: Sep 2015

var LastUniqueNumber = 0;

function GetUniqueNumber() {
    var d = Date.now();

    this.LastUniqueNumber = d <= this.LastUniqueNumber ? ++this.LastUniqueNumber : d;

    return this.LastUniqueNumber;
}

var RoutineManagement = angular.module("RoutineManagement", []);


RoutineManagement.controller("NavBar", function ($scope) {

    $.ajax({
        url: "http://localhost:57425/Home/GetUserPrivilege",
        type: "GET",
        contentType: 'application/json;',
        dataType: 'json',

        success: function (data) {
            $scope.$apply(function () {
                $scope.privilege = data;
            });
        }

    });

    $.ajax({
        url: "http://localhost:57425/Home/GetUserName",
        type: "GET",
        contentType: 'application/json;',
        dataType: 'json',

        success: function (data) {
            $scope.$apply(function () {
                $scope.userName = data;
            });
        }

    });

    $scope.notifications = Array();

    var longPollNotifications = function () {

        var response = "null";

        $.ajax({
            url: "http://localhost:57425/Home/GetNotifications",
            type: "GET",
            contentType: 'application/json;',
            dataType: 'text',
            timeout: 10000,
            data: { name: $scope.userName },

            success: function (data) {
                response = data;
                console.log(JSON.parse(data));
                //console.log("response is -    " + JSON.parse(response));
               
            },
            complete: function (data) {

               

                if (response != "null") {

                    console.log("response:   " + data);

                    $scope.$apply(function () {
                        $scope.notifications.push(response);
                    });
                }

                console.log($scope.notifications);

                longPollNotifications();
            },
            error: function (data) {
               
            }
        });
    }

    longPollNotifications();

});


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

            complete: function () {
                refreshSchedule();
            },
            fail: function () {
                alert('Failed to schedule routine ');
            }

        });

        $scope.PopupHidden = true;
        resetSelections();

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

    $scope.RoutineClick = function (scheduleID) {
        window.location.href = 'Home/Routine?scheduleID=' + scheduleID;
    }

});

//contains functionality for loading, viewing, and filling in routines
RoutineManagement.controller("CompleteRoutine", function ($scope) {

    $scope.loading = true;
    $scope.fieldTypes = document.ChecksheetLib.FieldTypes;

    $('.js-spinner').removeClass('ng-cloak');

    //ng-model not updating the fieldvalues correctly for checkboxes...this function is a hacky work around
    $scope.CheckboxClick = function (fieldIdx, recordIdx, csIdx, e) {

        if (e.target.type !== 'checkbox') return;

        $scope.routine.Checksheets[csIdx].Records[recordIdx].FieldValues[fieldIdx].Value = e.target.checked;
    }

    $.ajax({
        url: "http://localhost:57425/Home/LoadScheduledRoutine",
        type: "GET",
        contentType: 'application/json;',
        dataType: 'json',
        data: { ScheduleID: scheduleID },

        success: function (data) {
            $scope.$apply(function () {
                $scope.routine = data;
            });
        },
        error: function (data) {
            console.log('failed to load routine: ' + scheduleID);
        },
        complete: function () {

            $scope.$apply(function () {
                $scope.loading = false;
            })

            $('.js-spinner').addClass('ng-cloak');

        }

    });

    $scope.SaveRoutine = function () {

        $.ajax({
            url: "http://localhost:57425/Home/SaveScheduledRoutine",
            type: "POST",
            contentType: 'application/json;',
            dataType: 'json',
            data: JSON.stringify({
                Routine: $scope.routine,
                ScheduleID: scheduleID
            }),

            success: function (data) {

            },
            error: function (data) {
                console.log('failed to save routine: ' + scheduleID);
            }
        });
    }

});


//contsins functionality for creating or editing routines
RoutineManagement.controller("CreateRoutine", function ($scope) {

    var LoadRoutines = function () {
        $.ajax({
            url: "http://localhost:57425/Home/GetRoutineList",
            type: "GET",
            dataType: "json",
            success: function (data) {

                $scope.$apply(function () {
                    $scope.routines = data;
                    console.log($scope.routines);
                });
            },
            error: function (data) {
                console.log("failed to load list of routines");
                console.log(data);
            }
        });
    }

    var ShowRoutine = function(){
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

        $scope.routine = new document.ChecksheetLib.AgendaRoutine("New Routine", "Routine description");
        $scope.routine.Checksheets.push(new document.ChecksheetLib.CreateEmptyChecksheet());
        $scope.routine.Area = $scope.areas[0];

        ShowRoutine();
    }

    $scope.RoutineTableRowClick = function (RoutineId) {

        $.ajax({
            url: "http://localhost:57425/Home/LoadRoutine",
            type: "GET",
            dataType: "json",
            contentType: "application/json",
            data: { RoutineID: RoutineId },
            success: function (data) {

                $scope.$apply(function () {
                    $scope.routine = data;
                    console.log($scope.routine);
                    console.log($scope.fieldTypes);

                    SetFieldTypes();

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

        for(var i = 0; i < $scope.routine.Checksheets.length; i++){

            for (var j = 0; j < $scope.routine.Checksheets[i].Fields.length; j++) {
                $scope.routine.Checksheets[i].Fields[j].Type = $scope.fieldTypes[$scope.routine.Checksheets[i].Fields[j].TypeID -1];
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
        
        if (errors.length > 0) {
            alert("Must resolve errors before saving");
            return;
        }

        document.ChecksheetLib.SaveRoutine($scope.routine);
        ShowTable();
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

