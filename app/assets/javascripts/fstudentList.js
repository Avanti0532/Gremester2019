
fStudentList = function() {
    $('#dtOrderExample').DataTable({

        "order": [[ 4, "desc" ]],
        "columnDefs": [
            { "orderable": false, "targets": 6 }
        ]
    });
    $('.dataTables_length').addClass('bs-select');
}

$(document).ready(fStudentList);
$(document).ready(function () {
    $('#year').change(function (e) {
        e.stopImmediatePropagation();
        var theYear = $(this).find('option:selected').text();
        var theTerm = $('#term').find('option:selected').text();
        if (theYear == "**Any**" || theTerm == "**Any**") {
            $('#and_later').prop('checked',false);
            $('#and_later').attr('disabled',true);
        }else{
            $('#and_later').attr('disabled',false);
        }
    });
    $('#term').change(function (e) {
        e.stopImmediatePropagation();
        var theTerm = $(this).find('option:selected').text();
        var theYear = $('#year').find('option:selected').text();
        if (theYear == "**Any**" || theTerm == "**Any**") {
            $('#and_later').prop('checked',false);
            $('#and_later').attr('disabled',true);
        }else{
            $('#and_later').attr('disabled',false);
        }
    });
});

