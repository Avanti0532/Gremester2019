// $(document).ready(deleteSchool);
// //     var counter = 1;
// //     $("#addrow").on("click", function () {
// //         var newRow = $("<tr>");
// //         var cols = "";
// //         var options = "";
// //         var year = "";
// //         for (let university of gon.universities) {
// //             options += '<option value="' +university.university_name+'" />';
// //         }
// //         var current_year = new Date().getFullYear();
// //         for(let i=current_year-2;i<=current_year+10;i++){
// //
// //             year += '"<option value="'+i+'"/>';
// //         }
// //
// //         cols += '<td><input class= "form-control" list="university-name" id="univ_name" name="univ_name" placeholder="select university">' +
// //             '<datalist id="university-name">' +
// //             options +
// //             '</datalist>'+
// //             '</td>';
// //         cols += '<td><div class="form-group"> <select class="form-control" id="sell" name="sel_opt" >' +
// //             '<option disabled selected value>select status</option>' +
// //             '<option>Applied - Accepted</option>' +
// //             '<option>Applied - Rejected</option>' +
// //             '<option>Applied - Pending Decision</option>' +
// //             '</select></div></td>';
// //         cols += '<td><input type="date" class="form-control" name="datepicker" id="add_date">'+
// //             '</td>';
// //         cols += '<td><div class="form-group"> <select class="form-control" id="term" name="sel_term">' +
// //             '<option disabled selected value>select term</option>' +
// //             '<option>Fall</option>' +
// //             '<option>Spring</option>' +
// //             '<option>Winter</option>' +
// //             '<option>Summer</option>' +
// //             '</select></div></td>';
// //         cols += '<td><input class= "form-control" list="int_year" id="year" name="int_year" placeholder="select year">' +
// //             '<datalist id="int_year">' +
// //             year +
// //             '</datalist>'+
// //             '</td>';
// //
// //         cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="Delete" id="uni_delete"></td>';
// //         cols += '<td><input type="button" class="save btn btn-md btn-success " value="Save" id="add_save"><div id="add_alert" class="alert alert-danger fade" role="alert"></div></td>';
// //         newRow.append(cols);
// //         $("table.order-list").append(newRow);
// //
// //     });
// //
// //
// //     $('.edit').click(function(){
// //         edit_btn_id = this.id;
// //         $('#saveModal').attr('name', edit_btn_id);
// //         app_id_uni_id = edit_btn_id.substr(5).split('_');
// //         app_id = app_id_uni_id[0];
// //         uni_id = app_id_uni_id[1];
// //         $.ajax({
// //             url: "/applications/"+app_id,
// //             type: 'GET',
// //             contentType: "application/json",
// //             dataType: 'html',
// //             success: function(jsonData) {
// //                 data = JSON.parse(jsonData);
// //                 $('#uni_name').val(data.uni_name);
// //                 applied_date = new Date(data.applied_date);
// //                 if(applied_date.getUTCFullYear() == '1970'){
// //                     applied_date = '';
// //                 }else{
// //                     app_month = (applied_date.getUTCMonth()+1);
// //                     app_date =  applied_date.getUTCDate();
// //                     if (app_month < 10) app_month = "0" + app_month;
// //                     if (app_date < 10) app_date = "0" + app_date;
// //                     applied_date = applied_date.getUTCFullYear()+'-'+app_month+'-'+app_date;
// //                 }
// //                 admitted_date = new Date(data.admitted_date);
// //                 if(admitted_date.getUTCFullYear() == '1970'){
// //                     admitted_date = '';
// //                 }else{
// //                     adm_month = (admitted_date.getUTCMonth()+1);
// //                     adm_date =  admitted_date.getUTCDate();
// //                     if (adm_month < 10) adm_month = "0" + adm_month;
// //                     if (adm_date < 10) adm_date = "0" + adm_date;
// //                     admitted_date = admitted_date.getUTCFullYear()+'-'+adm_month+'-'+adm_date;
// //                 }
// //                 rejected_date = new Date(data.rejected_date);
// //                 if(rejected_date.getUTCFullYear() == '1970'){
// //                     rejected_date = '';
// //                 }else{
// //                     rej_month = (rejected_date.getUTCMonth()+1);
// //                     rej_date =  rejected_date.getUTCDate();
// //                     if (rej_month < 10) rej_month = "0" + rej_month;
// //                     if (rej_date < 10) rej_date = "0" + rej_date;
// //                     rejected_date = rejected_date.getUTCFullYear()+'-'+rej_month+'-'+rej_date;
// //                 }
// //                 $('#datepickerapp').val(applied_date);
// //                 $('#datepickeradm').val(admitted_date);
// //                 $('#datepickerrej').val(rejected_date);
// //                 $('div[role=alert]').text('');
// //                 $('div[role=alert]').addClass('in');
// //                 $('div[role=alert]').hide();
// //
// //             },
// //
// //             beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))}
// //         });
// //         jQuery.noConflict();
// //         $("#schoolModal").modal(
// //             {backdrop: true}
// //         );
// //
// //         return false;
// //     });
// //
// ///*/**/*/
//
//         deleteSchool: function (trashId) {
//             var app_id = trashId.substr(5).split('_');
//             var appn_id = app_id[1]
//             $.ajax({
//                 url: "/profiles/deleteschools",
//                 type: 'POST',
//                 datatype: "html",
//                 contentType: 'application/json',
//                 data: JSON.stringify({
//                     application_id: appn_id
//                 }),
//                 success: function (jsonData) {
//                     location.reload();
//                 },
//                 beforeSend: function (xhr) {
//                     xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
//                 }
//             });
//             return (false);
//         }
//      }
//
//         $('.trash').click(function () {
//             //deleteSchool(this.id);
//             $(deleteSchool(this.id));
//         });
//
//
//
// //
// //     $('#saveModal').click(function(){
// //         edit_btn_id = this.name;
// //         app_id_uni_id = edit_btn_id.substr(5).split('_');
// //         app_id = app_id_uni_id[0];
// //         uni_id = app_id_uni_id[1];
// //         applied_date = $('#datepickerapp').val();
// //         admitted_date = $('#datepickeradm').val();
// //         rejected_date = $('#datepickerrej').val();
// //         dt_app = new Date(applied_date);
// //         dt_adm = new Date(admitted_date);
// //         dt_rej = new Date(rejected_date);
// //
// //         if (applied_date == '') {
// //             $("div[role=alert]").text('Applied date cannot be empty!');
// //             $("div[role=alert]").show();
// //         }else if(admitted_date != '' && rejected_date != ''){
// //             $("div[role=alert]").text('');
// //             $("div[role=alert]").text('Both admitted date and rejected date cannot be selected!');
// //             $("div[role=alert]").show();
// //         }else if ((dt_adm < dt_app) || (dt_rej < dt_app)){
// //             if(dt_adm < dt_app){
// //                 $("div[role=alert]").text('');
// //                 $("div[role=alert]").text('Applied date cannot be later than admitted date!');
// //                 $("div[role=alert]").show();
// //             }else if(dt_rej < dt_app){
// //                 $("div[role=alert]").text('');
// //                 $("div[role=alert]").text('Applied date cannot be later than rejected date!');
// //                 $("div[role=alert]").show();
// //             }
// //
// //         }else{
// //             $.ajax({
// //                 type: "PUT",
// //                 dataType: "html",
// //                 url: '/applications/' + app_id,
// //                 contentType: 'application/json',
// //                 data: JSON.stringify({
// //                     id: app_id,
// //                     applied_date: applied_date,
// //                     admitted_date: admitted_date,
// //                     rejected_date: rejected_date
// //                 }),
// //                 success: function (jsonData) {
// //                     result = JSON.parse(jsonData);
// //                     if (result.result == 1) {
// //                         jQuery.noConflict();
// //                         $('#schoolsModal').modal('hide');
// //                         location.reload();
// //                     } else {
// //                         alert(result.result);
// //                     }
// //                 },
// //                 beforeSend: function (xhr) {
// //                     xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
// //                 }
// //             });
// //         }
// //
// //
// //     })
// //
// //
// //     $("table.order-list").on("click", ".ibtnDel", function (event) {
// //         $(this).closest("tr").remove();
// //         counter -= 1
// //     });
// //
// //     $("table.order-list").on("click", ".save", function (event) {
// //         var university = $("input[name='univ_name']").val();
// //         var new_date = $("input[name='datepicker']").val();
// //         var option = $("#sell").val();
// //         var term = $("#term").val();
// //         var year = $("input[name='int_year']").val();
// //         var current_year = new Date().getFullYear();
// //
// //         if(year < current_year){
// //             $('div#add_alert').addClass('in');
// //             $('div#add_alert').text('Interested year cannot be less than current year');
// //         }else {
// //             $.ajax({
// //                 url: "/profiles/addschools",
// //                 type: 'POST',
// //                 data: {univ_name: university, datepicker: new_date, sel_opt: option, term: term, year: year},
// //                 datatype: "html",
// //                 beforeSend: function (xhr) {
// //                     xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
// //                 }
// //             });
// //         }
// //
// //     });
// // });
//
// //var interestSchool = function() {
//   //  testVar = true
// // }
// //
// //$(document).ready(interestSchool);

deleteSchoolFunc = function() {

    $('.trash').click(function () {
        var app_id = this.id.substr(5).split('_');
        var appn_id = app_id[1]
        $.ajax({
            url: "/profiles/deleteschools",
            type: 'POST',
            datatype: "html",
            contentType: 'application/json',
            data: JSON.stringify({
                application_id: appn_id
            }),
            success: function (jsonData) {
                location.reload();
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            }
        });
        return (false);
    });
};

editSchoolFunc = function(){

    $('.edit').click(function(){
        var edit_btn_id = this.id;
        $('#saveModal').attr('name', edit_btn_id);
        var app_id_uni_id = edit_btn_id.substr(5).split('_');
        var app_id = app_id_uni_id[0];
        var uni_id = app_id_uni_id[1];
        $.ajax({
            url: "/applications/"+app_id,
            type: 'GET',
            contentType: "application/json",
            dataType: 'html',
            success: function(jsonData) {
                var data = JSON.parse(jsonData)
                $('#uni_name').val(data.uni_name);
                var applied_date = new Date(data.applied_date);
                if(applied_date.getUTCFullYear() == '1970'){
                    applied_date = '';
                }else{
                    var app_month = (applied_date.getUTCMonth()+1);
                    var app_date =  applied_date.getUTCDate();
                    if (app_month < 10) app_month = "0" + app_month;
                    if (app_date < 10) app_date = "0" + app_date;
                    applied_date = applied_date.getUTCFullYear()+'-'+app_month+'-'+app_date;
                }
                var admitted_date = new Date(data.admitted_date);
                if(admitted_date.getUTCFullYear() == '1970'){
                    admitted_date = '';
                }else{
                    var adm_month = (admitted_date.getUTCMonth()+1);
                    var adm_date =  admitted_date.getUTCDate();
                    if (adm_month < 10) adm_month = "0" + adm_month;
                    if (adm_date < 10) adm_date = "0" + adm_date;
                    admitted_date = admitted_date.getUTCFullYear()+'-'+adm_month+'-'+adm_date;
                }
                var rejected_date = new Date(data.rejected_date);
                if(rejected_date.getUTCFullYear() == '1970'){
                    rejected_date = '';
                }else{
                    var rej_month = (rejected_date.getUTCMonth()+1);
                    var rej_date =  rejected_date.getUTCDate();
                    if (rej_month < 10) rej_month = "0" + rej_month;
                    if (rej_date < 10) rej_date = "0" + rej_date;
                    rejected_date = rejected_date.getUTCFullYear()+'-'+rej_month+'-'+rej_date;
                }
                $('#datepickerapp').val(applied_date);
                $('#datepickeradm').val(admitted_date);
                $('#datepickerrej').val(rejected_date);
                $('div[role=alert]').text('');
                $('div[role=alert]').addClass('in');
                $('div[role=alert]').hide();

            },

            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))}
        });
        jQuery.noConflict();
        $("#schoolModal").modal(
            {backdrop: true}
        );

        return false;
    });
};

//(function($) {
  $(document).ready(deleteSchoolFunc);
  $(document).ready(editSchoolFunc);
//})(jQuery);

//jQuery(document).on('ready', function(){
  //  deleteSchoolFunc();
   // editSchoolFunc();
//});