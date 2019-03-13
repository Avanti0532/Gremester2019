$(document).ready(function () {
    var counter = 1;

    $("#addrow").on("click", function () {
        var newRow = $("<tr>");
        var cols = "";
        var options = "";
        for (var university of gon.universities) {
            options += '<option value="' +university.university_name+'" />';
        }

        cols += '<td><input class= "form-control" list="university-name" id="univ_name" name="univ_name" />' +
            '<datalist id="university-name">' +
            options +
            '</datalist>'+
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
        cols += '<td><input type="button" class="save btn btn-md btn-success " value="Save"></td>';
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
    $('.edit').click(function(){
        edit_btn_id = this.id;
        $('#saveModal').attr('name', edit_btn_id);
        app_id_uni_id = edit_btn_id.substr(5).split('_');
        app_id = app_id_uni_id[0];
        uni_id = app_id_uni_id[1];
        console.log('app_id_uni_id='+app_id_uni_id[0]+'_'+app_id_uni_id[1]);
        console.log('app_id='+app_id);
        console.log('uni_id='+uni_id);
        $.ajax({
            url: "/applications/"+app_id,
            type: 'GET',
            contentType: "application/json",
            // data: { id : app_id},
            dataType: 'html',
            success: function(jsonData) {
                data = JSON.parse(jsonData);
                console.log(data);
                console.log(data.id);
                $('#uni_name').val(data.uni_name);
                applied_date = new Date(data.applied_date);
                if(applied_date.getUTCFullYear() == '1970'){
                    applied_date = '';
                }else{
                    applied_date = applied_date.getUTCFullYear()+'-'+(applied_date.getUTCMonth()+1)+'-'+applied_date.getUTCDate();
                }
                admitted_date = new Date(data.admitted_date);
                if(admitted_date.getUTCFullYear() == '1970'){
                    admitted_date = '';
                }else{
                    admitted_date = admitted_date.getUTCFullYear()+'-'+(admitted_date.getUTCMonth()+1)+'-'+admitted_date.getUTCDate();
                }
                rejected_date = new Date(data.rejected_date);
                if(rejected_date.getUTCFullYear() == '1970'){
                    rejected_date = '';
                }else{
                    rejected_date = rejected_date.getUTCFullYear()+'-'+(rejected_date.getUTCMonth()+1)+'-'+rejected_date.getUTCDate();
                }
                $('#datetimepickerapp').find('input[name="datepicker"]').val(applied_date);
                $('#datetimepickeracc').find('input[name="datepicker"]').val(admitted_date);
                $('#datetimepickerrej').find('input[name="datepicker"]').val(rejected_date);

            },

            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        });
        jQuery.noConflict();
        $("#schoolModal").modal(
            {backdrop: true}
            );
         $('#datetimepickerapp').click(function() {
            $(this).datepicker().datepicker("show")
        });
        return false;
    });

    $('.trash').on('click', function(){
        console.log(this.id+' Trash clicked');

        return false;
    });

    $('#saveModal').click(function(){
        edit_btn_id = this.name;
        app_id_uni_id = edit_btn_id.substr(5).split('_');
        app_id = app_id_uni_id[0];
        uni_id = app_id_uni_id[1];
        console.log(app_id);
        applied_date = $('#datetimepickerapp').find('input[name="datepicker"]').val();
        admitted_date = $('#datetimepickeracc').find('input[name="datepicker"]').val();
        rejeced_date = $('#datetimepickerrej').find('input[name="datepicker"]').val();
        $.ajax({
            type: "PUT",
            dataType: "html",
            url: '/applications/'+app_id,
            contentType: 'application/json',
            data: JSON.stringify({ id : app_id, applied_date : applied_date, admitted_date:admitted_date, rejected_date:rejected_date}),
            success: function(jsonData) {
                result = JSON.parse(jsonData);
                if (result.result == 1) {
                    $('#schoolsModal').modal('hide');
                    location.reload();
                }else{
                    alert(result.result);
                }

            },

            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        });


    })


    var currentDate = new Date();


      $(function() {
        // jQuery.noConflict();
          //var element = document.getElementById('datetimepickerapp');
          $("#datetimepickerapp").click(function() {
            $(this).datepicker().datepicker("show")
          });
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
        });
    });
});


