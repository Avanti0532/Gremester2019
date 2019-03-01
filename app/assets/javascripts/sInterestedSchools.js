$(document).ready(function () {
    var counter = 0;

    $("#addrow").on("click", function () {
        var newRow = $("<tr>");
        var cols = "";

        cols += '<td><input class= "form-control" list="university-name" id="univ_name" name="univ_name" />' +
            '<datalist id="university-name">' +
            '<% University.all.each do |university| %>' +
            '<option value="<%= university.university_name %>"></option>' +
            '<% end %>' +
            '</datalist></td>';
        cols += '<td><div class="form-group"> <select class="form-control" id="sel1">' +
            '<option disabled selected value> -- select an option -- </option>' +
            '<option>Applied - Accepted</option>' +
            '<option>Applied - Rejected</option>' +
            '<option>Applied - Pending Decision</option>' +
            '<option>Interested</option> </select> </div></td>';
        cols += '<td><div class="input-group">' +
            '<input type="text" class="form-control" id="datetimepicker" name="datetimepicker">'+
            '<label class="input-group-addon btn" for="datepicker">'+
            '<span class="glyphicon glyphicon-calendar" id="opendatetimepicker">' +
            '</span>' +
            '</label>' +
            '</div></td>';
        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="Delete"></td>';
        newRow.append(cols);
        $("table.order-list").append(newRow);
        counter++;
    });

    $('#opendatetimepicker').click(function(event){
        $('#datetimepicker').datepicker();
    });

    $("table.order-list").on("click", ".ibtnDel", function (event) {
        $(this).closest("tr").remove();
        counter -= 1
    });


});


