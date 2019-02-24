$(document).ready(function () {
    $("#universitiesTable").each(function () {
        if ( $.fn.dataTable.isDataTable( '#universitiesTable' ) ) {
            table = $('#universitiesTable').DataTable();
        }
        else {
            table = $('#universitiesTable').DataTable(
        );
        }
    });
})