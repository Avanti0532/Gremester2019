facultyEvaluation = function() {
    $('#facultyEvaluationTable').DataTable({

        "order": [[ 4, "desc" ]],
        "columnDefs": [
            { "orderable": false, "targets": 5 }
        ]
    });
    $('.dataTables_length').addClass('bs-select');
}

$(document).ready(facultyEvaluation);
