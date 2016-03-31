RoutineManagement.controller("Admin", function ($scope) {


    $scope.ShowAddArea = false;
    $scope.ShowAddTeam = false;
    $scope.ShowEditUser = false;

    $scope.Users = null;
    $scope.AccessLevels = null;
    $scope.SelectedUser = null;
    $scope.SelectedArea = "";

    var LoadedUserNames = false;
    var LoadedUserAccess = false;
    $scope.Loaded = false;

    document.ChecksheetLib.GetAreas();
    $scope.areas = document.ChecksheetLib.PlantAreas;


    var SetLoaded = function () {
        $scope.$apply(function () {
            $scope.Loaded = LoadedUserNames && LoadedUserAccess;
        });
    }


    $.ajax({
        url: "http://localhost:57425/Home/GetUserPrivilege",
        type: "GET",
        contentType: 'application/json;',
        dataType: 'json',

        success: function (data) {
            $scope.$apply(function () {
                $scope.privilege = data;
            });
        },
        complete: function () {
            LoadedUserAccess = true;
            SetLoaded();
            console.log("asdjkhgfsduf  " + $scope.Loaded);
        }
    });

    $.ajax({
        url: "http://localhost:57425/Home/GetAllUserNames",
        type: "GET",
        contentType: 'application/json;',
        dataType: 'json',
        success: function (data) {
            $scope.$apply(function () {
                $scope.Users = data;
            });
        },
        complete: function () {
            LoadedUserNames = true;
            SetLoaded();
            console.log("asdjkhgfsduf  " + $scope.Loaded);
        }

    });

    var ButtonClick = function () {

        $scope.ShowAddArea = false;
        $scope.ShowAddTeam = false;
        $scope.ShowEditUser = false;
    }

    $scope.CreateAreaClick = function () {
        ButtonClick();
        $scope.ShowAddArea = true;
    }

    $scope.CreateTeamClick = function () {
        ButtonClick();
        $scope.ShowAddTeam = true;
    }

    $scope.EditUserPrivilegeClick = function () {
        ButtonClick();
        $scope.ShowEditUser = true;
    }

    $scope.UserClick = function (userName) {

        $.ajax({
            url: "http://localhost:57425/Admin/GetUserAccessLevels",
            type: "GET",
            contentType: 'application/json;',
            dataType: 'json',
            data: { UserName: userName },
            success: function (data) {
                $scope.$apply(function () {
                    $scope.SelectedUser = userName;
                    $scope.AccessLevels = data;
                });
            }
        });
    }

    $scope.AccessLevelClick = function (userName, alid) {

        $scope.AccessLevels['Reader'] = false;
        $scope.AccessLevels['Writer'] = false;
        $scope.AccessLevels['Editor'] = false;
        $scope.AccessLevels['TeamReader'] = false;
        $scope.AccessLevels['TeamWriter'] = false;
        $scope.AccessLevels['TeamEditor'] = false;
        $scope.AccessLevels['AreaReader'] = false;
        $scope.AccessLevels['AreaWriter'] = false;
        $scope.AccessLevels['AreaEditor'] = false;
        $scope.AccessLevels['Admin'] = false;
    
        if (alid == 1) $scope.AccessLevels['Reader'] = true;
        else if (alid == 2) $scope.AccessLevels['Writer'] = true;
        else if (alid == 3) $scope.AccessLevels['Editor'] = true;
        else if (alid == 4) $scope.AccessLevels['TeamReader'] = true;
        else if (alid == 5) $scope.AccessLevels['TeamWriter'] = true;
        else if (alid == 6) $scope.AccessLevels['TeamEditor'] = true;
        else if (alid == 7) $scope.AccessLevels['AreaReader'] = true;
        else if (alid == 8) $scope.AccessLevels['AreaWriter'] = true;
        else if (alid == 9) $scope.AccessLevels['AreaEditor'] = true;
        else if (alid == 10) $scope.AccessLevels['Admin'] = true;

        console.log(JSON.stringify({
            UserName: userName,
            AccessLevelID: alid
        }));

        $.ajax({
            url: "http://localhost:57425/Admin/UpdateUserAccessLevel",
            type: "POST",
            contentType: 'application/json;',
            dataType: 'json',
            data: JSON.stringify({
                UserName: userName,
                AccessLevelID: alid
            }),
        });
      
    }

    $scope.AddAreaClick = function () {

        var areaName = $('.js-newAreaName').val();

        $.ajax({
            url: "http://localhost:57425/Admin/AddArea",
            type: "POST",
            contentType: 'application/json;',
            dataType: 'json',
            data: JSON.stringify({
                AreaName: areaName,
                ParentAreaName: $scope.SelectedArea
            }),
            complete: function () {
                document.ChecksheetLib.GetAreas();
                $scope.areas = document.ChecksheetLib.PlantAreas;
            }
        });
    }

    $scope.AddTeamClick = function () {

        var areaName = $('.js-newTeamName').val();

        $.ajax({
            url: "http://localhost:57425/Admin/AddTeam",
            type: "POST",
            contentType: 'application/json;',
            dataType: 'json',
            data: JSON.stringify({
                TeamName: teamName
            }),
        });
    }

});