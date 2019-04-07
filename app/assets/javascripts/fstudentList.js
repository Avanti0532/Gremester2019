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