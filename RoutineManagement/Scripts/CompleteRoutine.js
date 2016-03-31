//contains functionality for loading, viewing, and filling in routines
RoutineManagement.controller("CompleteRoutine", function ($scope) {

    $scope.loading = true;
    $scope.fieldTypes = document.ChecksheetLib.FieldTypes;
    $scope.comments = null;
    
    $('.js-spinner').removeClass('ng-cloak');

    //ng-model not updating the fieldvalues correctly for checkboxes...this function is a hacky work around
    $scope.CheckboxClick = function (fieldIdx, recordIdx, csIdx, e) {

        if (e.target.type !== 'checkbox') return;

        $scope.routine.Checksheets[csIdx].Records[recordIdx].FieldValues[fieldIdx].Value = e.target.checked;
    }

    var LoadComments = function () {
        $.ajax({
            url: "http://localhost:57425/Schedule/LoadCommentsForSchedule",
            type: "GET",
            contentType: 'application/json;',
            dataType: 'json',
            data: { ScheduleID: scheduleID },

            success: function (data) {
                $scope.$apply(function () {
                    $scope.comments = data;
                });
            }
        });
    }

    LoadComments();
   
    $.ajax({
        url: "http://localhost:57425/Routine/LoadScheduledRoutine",
        type: "GET",
        contentType: 'application/json;',
        dataType: 'json',
        data: { ScheduleID: scheduleID },

        success: function (data) {
            $scope.$apply(function () {
                $scope.routine = document.ChecksheetLib.FormatRoutine(data);
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
            url: "http://localhost:57425/Routine/SaveScheduledRoutine",
            type: "POST",
            contentType: 'application/json;',
            dataType: 'json',
            async:false,
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

    $scope.CompleteRoutine = function () {

        var r = confirm("Are you sure? Changes cannot be made after the routine has been completed.");

        if (r === false) {
            return;
        }

        $scope.SaveRoutine();

        $.ajax({
            url: "http://localhost:57425/Routine/CompleteScheduledRoutine",
            type: "POST",
            contentType: 'application/json;',
            dataType: 'json',
            data: JSON.stringify({
                ScheduleID: scheduleID
            }),

            success: function (data) {

            },
            error: function (data) {

            },
            complete: function () {
                
                location.reload();
            }
        });

    }

    $scope.ReplyClick = function (cid) {
        var comment = prompt("Enter comment", "");

        if (comment != null) {
            $.ajax({
                url: "http://localhost:57425/Schedule/AddCommentToScheduledRoutine",
                type: "POST",
                contentType: 'application/json;',
                dataType: 'json',
                data: JSON.stringify({
                    ScheduleID: null,
                    UserComment: comment,
                    ParentID: cid
                }),
                complete: function () {
                    LoadComments();
                }

            });
        }

    }

    $scope.commentText = "";

    $scope.PostCommentClick = function (parentID) {

        console.log("posting comment");

        $.ajax({
            url: "http://localhost:57425/Schedule/AddCommentToScheduledRoutine",
            type: "POST",
            contentType: 'application/json;',
            dataType: 'json',
            data: JSON.stringify({
                ScheduleID: scheduleID,
                UserComment: $scope.commentText,
                ParentID: parentID
            }),
            complete: function () {
                LoadComments();
            }

        });
    }

    $scope.ToggleReplies = function (cid) {
        

        var replies = $('.js-reply' + cid);
        var text = $('.js-toggleText' + cid);

        if (replies.hasClass('hidden')) {
            replies.removeClass('hidden');
            text[0].innerHTML = 'Hide Replies';
        }
        else {
            replies.addClass('hidden');
            text[0].innerHTML = 'Show Replies';
        }

    }

});

