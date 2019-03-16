$(document).ready(function () {

    $('#college_edit_profile').change(function() {
        var country;
        country = $('#college_edit_profile :selected').text();
        $.ajax({
            url: "/profiles/getUndergradUniversityByCountry",
            type: 'GET',
            data: {country: country},
            datatype:"json",
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
            success: function(data) {
                $('#undergrad_universities').empty();
                universities = data['undergrad_universities'];
                $("#undergrad_universities").append('<option selected disabled>Select university</option>');
                for(var i=0; i< universities.length; i++){
                    $("#undergrad_universities").append('<option value="' + universities[i]["id"] + '">' + universities[i]["university_name"] + '</option>');
                }
                $("#undergrad_universities").append('<option value="School not listed">School not listed</option>');

            }
        });
    });

    $('#undergrad_universities').change(function() {
        var university;
        university = $('#undergrad_universities :selected').text();
        if (university === 'School not listed') {
            $("#undergraduate_edit").append('<button type="button" id="add_new_undergrad">Add your school</button>');
            $('#add_new_undergrad').click(function() {
                $.ajax({
                    url: "/countries",
                    type: 'GET',
                    contentType: "application/json",
                    dataType: 'html',
                    success: function(jsonData) {
                        data = JSON.parse(jsonData);
                        countries = data.countries;
                        for(var i=0; i< countries.length; i++){
                            $("#undergrad_country").append('<option value="' + countries[i] + '">' + countries[i] + '</option>');
                        }

                    },

                    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                });

                $("#addUndergradModal").modal(
                    {backdrop: true}
                );
               // return false;
            });

        }

    });

    $('#saveModal').click(function(){
        var university = $("#undergrad_school_name").val();
        var country = $("#undergrad_country").val();
        var accp_rate = $("#undergrad_acceptance_rate").val();
        var website = $("#undergrad_website_text").val();
        var location = $("#undergrad_website_location").val();
        var description = $("#undergrad_website_description").val();
        var full_url = document.URL;
        var url_array = full_url.split('/')
        var app_id = url_array[url_array.length-2];
        $.ajax({
            type: "POST",
            dataType: "html",
            url: '/profiles/'+app_id,
            contentType: 'application/json',
            data: JSON.stringify({
                id: app_id,
                univ_name: university,
                country: country,
                acceptance_rate: accp_rate,
                website: website,
                location: location,
                description: description
            }),
            success: function (jsonData) {
                result = JSON.parse(jsonData);
                if (result.result == 1) {
                    $('#addUndergradModal').modal('hide');
                    location.reload();
                } else {
                    alert(result.result);
                }
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            }
        });

    });

});


