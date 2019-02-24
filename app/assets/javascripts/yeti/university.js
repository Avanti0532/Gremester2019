$(document).ready(function () {
    console.log('In datatable Out');
    $("#universitiesTable").each(function () {
        console.log('In datatable');
        if ( $.fn.dataTable.isDataTable( '#universitiesTable' ) ) {
            table = $('#universitiesTable').DataTable();
        }
        else {
            table = $('#universitiesTable').DataTable( {
                // processing: true;
                // serverSide: true;
                // ajax: 'universities.json';

            });
        }
    });
})