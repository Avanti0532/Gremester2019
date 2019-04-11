facultyOEvaluation = function() {
    $('#facultyOEvaluationTable').DataTable({

        "order": [[ 0, "desc" ]],
        "columnDefs": [
            { "orderable": false, "targets": 3 }
        ]

    });
    $('.dataTables_length').addClass('bs-select');
}

$(document).ready(facultyOEvaluation);
