
fStudentList = function() {
    $('#dtOrderExample').DataTable({

        "order": [[ 4, "desc" ]],
        "columnDefs": [
            { "orderable": false, "targets": 6 }
        ]
    });
    $('.dataTables_length').addClass('bs-select');
};

fYearSelect = function() {
    $('#year').change(function (e) {
        e.stopImmediatePropagation();
        var theYear = $(this.id).find('option:selected').text();
        var theTerm = $('#term').find('option:selected').text();
        if (theYear == "**Any**" || theTerm == "**Any**") {
            $('#and_later').prop('checked',false);
            $('#and_later').attr('disabled',true);
        } else {
            $('#and_later').attr('disabled',false);
        }
    });
};
fTermSelect = function() {
    $('#term').change(function (e) {
        e.stopImmediatePropagation();
        var theTerm = $(this.id).find('option:selected').text();
        var theYear = $('#year').find('option:selected').text();
        if (theYear == "**Any**" || theTerm == "**Any**") {
            $('#and_later').prop('checked',false);
            $('#and_later').attr('disabled',true);
        } else {
            $('#and_later').attr('disabled',false);
        }
    });
};

fPopoverView = function () {

    $('[data-toggle="tooltip"]').tooltip();
    $('.popover').popover({
        trigger: 'hover',
        container: 'body'

    });
    $("[data-toggle=popover]").popover();
};

$(document).ready(fStudentList);
$(document).ready(fYearSelect);
$(document).ready(fTermSelect);
$(document).ready(fPopoverView);



