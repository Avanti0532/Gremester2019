facultyOEvaluation = function() {
    $('#facultyOEvaluationTable').DataTable({

        "order": [[ 0, "desc" ]],
        "columnDefs": [
            { "orderable": false, "targets": 3 }
        ]

    });
    $('.dataTables_length').addClass('bs-select');
}


alignBackButton = function(){
    if ($('#facultyOEvaluationTable_info').length > 0) {
        backBtn = $('#backeval').parent().children()[0];
        $('#divBack').text('');

        $(backBtn).insertAfter("div#facultyOEvaluationTable_info");
        $("<br/><br/>").insertBefore("a#backeval");
    }
}

$(document).ready(facultyOEvaluation);
$(document).ready(alignBackButton);
