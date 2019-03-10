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
                $("#undergrad_universities").append('<option>Select university</option>');
                for(var i=0; i< universities.length; i++){
                    $("#undergrad_universities").append('<option value="' + universities[i]["id"] + '">' + universities[i]["university_name"] + '</option>');
                }

            }
        });
    });
});


