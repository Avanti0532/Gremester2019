
$(document).ready(function () {
    var counter = 1;

    $("#addrow").on("click", function () {
        var newRow = $("<tr>");
        var cols = "";

        cols += '<td><input class= "form-control" id="univ_name" name="univ_name" />' +
            '</td>';
        cols += '<td><div class="form-group"> <select class="form-control" id="sell" name="sel_opt">' +
            '<option disabled selected value> -- select an option -- </option>' +
            '<option>Applied - Accepted</option>' +
            '<option>Applied - Rejected</option>' +
            '<option>Applied - Pending Decision</option>' +
            '</select></div></td>';
        cols += '<td><div class="input-group date" id="datetimepicker' + counter +'">' +
            '<input type="text" class="form-control" name="datepicker" value="">'+
            '<label class="input-group-addon btn" for="datepicker">'+
            '<span class="glyphicon glyphicon-calendar">' +
            '</span>' +
            '</label>' +
            '</div></td>';
        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="Delete"></td>';
        cols += '<td><input type="button" class="save btn btn-md btn-Success " value="Save"></td>';
        newRow.append(cols);
        $("table.order-list").append(newRow);

        $(function() {
            let pickerID = 'datetimepicker'+ counter;
            var element = document.getElementById(pickerID);
            $(element).click(function() {
                $(this).datepicker().datepicker("show")
            });
        });
        counter++;
    });

    $(function() {
        $("#datetimepicker0").click(function() {
            $(this).datepicker().datepicker("show")
        });
    });

    $("table.order-list").on("click", ".ibtnDel", function (event) {
        $(this).closest("tr").remove();
        counter -= 1
    });

    $("table.order-list").on("click", ".save", function (event) {
          var university = $("input[name='univ_name']").val();
          var new_date = $("input[name='datepicker']").val();
          var option = $("#sell").val();

        $.ajax({
            url: "/profiles/addschools",
            type: 'POST',
            data: {univ_name: university,datepicker: new_date,sel_opt: option},
            datatype:"html",
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
             success: function(data) {
                  location.reload();
             },

        });
    });

});


