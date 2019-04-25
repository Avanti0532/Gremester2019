$(document).ready(function () {
        var newRow = $("<tr>");
        var cols = "";
        var options = "";
        for (let university of gon.universities) {
            options += '<option value="' +university.university_name+'" />';
        }
        cols += '<td><input class= "form-control" list="university-name" id="univ_name" name="univ_name" placeholder="select university">' +
            '<datalist id="university-name">' +
            options +
            '</datalist>' +
            '</td>';

        cols += '<td><input type="button" class="save btn btn-md btn-success " value="Calculate" id="add_save"><div id="add_alert" class="alert alert-danger fade" role="alert"></div></td>';
        newRow.append(cols);
        $("table.order-list").append(newRow);


    $("table.order-list").on("click", ".save", function (event) {
        var university = $("input[name='univ_name']").val();

        $.ajax({
            url: "/profiles/getAdmissionChance",
            type: 'POST',
            datatype: "html",
            contentType: 'application/json',
            data: JSON.stringify({
            univ_name: university
            }),
            success: function (jsonData) {
                location.reload();
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            }
        });
    });

});

