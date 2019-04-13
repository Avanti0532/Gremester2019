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
    backBtn = $('#backeval').parent().children()[0];
    $('#divBack').text('');

    //Option 1
    $(backBtn).insertAfter("div#facultyOEvaluationTable_info");
    $("<br/><br/>").insertBefore("a#backeval");

    //Option 2
    // $("<div class='row'><div class='col-md-12 col-sm-12' id='divBackEval'><br/></div></div>").insertAfter("div#facultyOEvaluationTable_info");
    // $("#divBackEval").append(backBtn);

    //Option 3
    // $("<div class='row'><div class='col-md-12 col-sm-12' id='divBackEval'></div></div>").insertAfter($("div#facultyOEvaluationTable_info").parent().parent());
    // $("#divBackEval").append(backBtn);

}

$(document).ready(facultyOEvaluation);
$(document).ready(function() {
    if ($('#facultyOEvaluationTable_info').length > 0) {
        alignBackButton();
    }
});
