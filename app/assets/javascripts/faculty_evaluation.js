facultyEvaluation = function() {
    $('#facultyEvaluationTable').DataTable({

        "order": [[ 0, "desc" ]],
        "columnDefs": [
            { "orderable": false, "targets": 6 }
        ]

    });
    $('.dataTables_length').addClass('bs-select');
}

$(document).ready(facultyEvaluation);
