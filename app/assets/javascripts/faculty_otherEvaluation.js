facultyOEvaluation = function() {
    $('#facultyOEvaluationTable').DataTable({

        "order": [[ 0, "desc" ]],
        "columnDefs": [
            { "orderable": false, "targets": 3 }
        ]

    });
    $('.dataTables_length').addClass('bs-select');
}

function alignBackButton(){
    $("<br/><br/><a class='btn btn-primary' id='backeval' href='faculty_evaluations'>Back</a>").insertAfter("div#facultyOEvaluationTable_info");
    // $("<div class='row'><div class='col-md-12 col-sm-12'><br/><a class='btn btn-primary' id='backeval' href='faculty_evaluations'>Back</a></div></div>").insertAfter("div#facultyOEvaluationTable_info");
    //$("<div class='row'><div class='col-md-12 col-sm-12'><a class='btn btn-primary' id='backeval' href='faculty_evaluations'>Back</a></div></div>").insertAfter($("div#facultyOEvaluationTable_info").parent().parent());
}

$(document).ready(facultyOEvaluation);
$(document).ready(function() {
    if ($('#facultyOEvaluationTable_info').length > 0) {
        alignBackButton();
    }
});
