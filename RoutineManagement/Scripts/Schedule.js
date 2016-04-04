
RoutineManagement.controller("Schedule", function ($scope) {

    var refreshSchedule = function () {
        $.ajax({
            url: "Schedule/LoadSchedule",
            type: "GET",
            contentType: 'application/json;',
            dataType: 'json',

            success: function (data) {
                $scope.$apply(function () {
                    $scope.schedule = data;
                    $scope.Loaded = true;
                });
            },
            fail: function (data) {
                console.log('failed to load schedule: ');
            }

        });
    }

    $.ajax({
        url: "http://localhost:57425/Home/GetUserName",
        type: "GET",
        contentType: 'application/json;',
        dataType: 'text',
        async: false,
        success: function (data) {
            $scope.UserName = data;
        },
        error: function (data) {
            console.log(data);
        }
    });

    $scope.Loaded = false;

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

    $scope.ShowCompleted = true;
    $scope.ShowOnlyMe = false;

    $scope.TimePeriod = ['Days', 'Weeks', 'Months', 'Years'];
    $scope.PopupHidden = true;

    var resetSelections = function () {    
        
        $scope.selectedDate = '';
        $scope.selectedRate = 1;
        $scope.selectedPeriod = $scope.TimePeriod[0];
        $scope.selectedNumber = 1;
        $scope.PopupHidden = true;

        $scope.Routines = new Array();
        $scope.Teams = new Array();
        $scope.Users = new Array();

    }

    resetSelections();

    $scope.Areas = document.ChecksheetLib.PlantAreas;

    console.log($scope.Areas);

    $scope.getRoutinesByArea = function (areaName) {

        $.ajax({
            url: "Routine/GetRoutinesByArea",
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
            url: "Home/GetTeamsByArea",
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

        teamName = teamName ;

        $.ajax({
            url: "Home/GetUsersByTeam",
            type: "GET",
            contentType: 'application/json;',
            dataType: 'json',
            data: { TeamName: teamName },

            success: function (data) {
                $scope.$apply(function () {
                    $scope.Users = data;
                    $scope.selectedTeam = teamName;
                    console.log(data);
                });

            },
            fail: function (data) {
                console.log('failed to get users: ');
            }

        });
    }

    $scope.areaChanged = function (areaName) {
        areaName = areaName ;
        $scope.getRoutinesByArea(areaName);
        $scope.getTeamsByArea(areaName);
        $scope.selectedArea = areaName;
    }

    //for some reason the ng-model on routine select / user select isnt working..?
    //funcs below is a work around to force seletced routine to update
    $scope.RoutineSelected = function (routine) {
        $scope.selectedRoutine = routine ;
    }

    $scope.UserChanged = function (user) {
        $scope.selectedUser = user ;
    }

    $scope.SaveScheduleClick = function () {

        if ($scope.selectedArea === undefined || $scope.selectedRoutine === undefined || $scope.selectedTeam === undefined || $scope.selectedDate === '') {
            var missingSelections = '';

            var addAnd = function (s) {

                missingSelections += missingSelections !== '' ? ', and ' + s : s;
            }

            //build a string to tell user which required input fields are missing
            if ($scope.selectedArea === undefined) {
                missingSelections += 'an Area';
            }
            if ($scope.selectedRoutine === undefined) {
                addAnd('a Routine');
            }
            if ($scope.selectedTeam === undefined) {
                addAnd('a Team');
            }
            if ($scope.selectedDate === '') {
                addAnd('a Date');
            }

            //TODO: 
            //alert is a bit primitive... make my own popup dialog / find dsomething online. LOW PRIORITY
            alert('Must select ' + missingSelections);

            return;
        }

        var sr = new document.ChecksheetLib.ScheduledRoutine();
        sr.AssignedUser = $scope.selectedUser;
        sr.AssignedTeam = $scope.selectedTeam;
        sr.DueOn = $scope.selectedDate;
        sr.Routine = $scope.selectedRoutine;
        sr.Rate = $scope.selectedRate;
        sr.Period = $scope.selectedPeriod;
        sr.Number = $scope.selectedNumber;
      
        $.ajax({
            url: "Schedule/ScheduleRoutine",
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

        resetSelections();

        console.log($scope.selectedArea);
        console.log($scope.selectedRoutine);

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