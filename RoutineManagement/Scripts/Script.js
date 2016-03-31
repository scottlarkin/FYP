//Author: Scott Larkin
//Date: Sep 2015

var LastUniqueNumber = 0;

function GetUniqueNumber() {
    var d = Date.now();

    this.LastUniqueNumber = d <= this.LastUniqueNumber ? ++this.LastUniqueNumber : d;

    return this.LastUniqueNumber;
}

var RoutineManagement = angular.module("RoutineManagement", []);

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

