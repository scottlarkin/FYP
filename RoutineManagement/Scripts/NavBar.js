RoutineManagement.controller("NavBar", function ($scope) {

    $scope.newNotifications = 0;
    $scope.showNotifications = false;

    var GetNumberOfNewNotifications = function () {

        var n = 0;

        for (var i = 0; i < $scope.notifications.length; i++){
            if ($scope.notifications[i].seen == 'false') {
                n++;
            }
        }

        return n;
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
        }
    });

    $.ajax({
        url: "http://localhost:57425/Home/GetUserName",
        type: "GET",
        contentType: 'application/json;',
        dataType: 'text',
        async: false,
        success: function (data) {
            $scope.userName = data;
        },
        error: function (data) {
            console.log(data);
        }
    });
   
    $scope.notifications = Array();

    var getNotifications = function () {

        $.ajax({
            url: "http://localhost:57425/Notification/GetNotifications",
            type: "GET",
            contentType: 'application/json;',
            dataType: 'json',
            data: { user: $scope.userName },

            success: function (data) {
                $scope.$apply(function () {
                   
                    $scope.notifications = data;
                    $scope.newNotifications = GetNumberOfNewNotifications();
                    
                });
            }
        });
    }

    getNotifications();

    (function poll() {

        $.ajax({
            url: "http://localhost:57425/Notification/GetNewNotifications",
            type: "GET",
            contentType: 'application/json;',
            dataType: 'json',
            data: { user: $scope.userName },
            success: function (data) {
                response = data;
                if (response) {
                    getNotifications();
                }
            },
            error: function(data){
                console.log(data);
            },
            complete: function () {
               
                poll();
            },
            
            timeout: 10000000 //timeout handled on the server side - see Notification.cs
        });
    })();

    $scope.ClearNotificationClick = function () {

        $.ajax({
            url: "http://localhost:57425/Notification/ClearNotifications",
            type: "POST",
            contentType: 'application/json;',
            dataType: 'json',
            data: JSON.stringify({ user: $scope.userName }),
            complete: function (data) {

                getNotifications();
            }
        });
    }

    var markNotificationsRead = function () {

        $.ajax({
            url: "http://localhost:57425/Notification/ReadNotifications",
            type: "POST",
            contentType: 'application/json;',
            dataType: 'json',
            data: JSON.stringify({ user: $scope.userName }),
            complete: function (data) {
               
                getNotifications();
            }
        });

    }

    $scope.NotificationBellClick = function () {

        $scope.showNotifications = !$scope.showNotifications;

        if (!$scope.showNotifications)
            markNotificationsRead();
    }

    $('.js-notificationWrap').click(function (event) {
        
        event.stopPropagation();

    });

    $('html').click(function () {
       
        if ($scope.showNotifications) {
            $scope.$apply(function () {
                $scope.showNotifications = false;
                markNotificationsRead();
            });
        }

    });

});