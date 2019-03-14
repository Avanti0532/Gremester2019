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
            });

        }

    });


});


