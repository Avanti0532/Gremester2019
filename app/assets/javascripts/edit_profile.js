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
                        console.log(countries);
                        $("#undergrad_country").append('<option selected disabled>Select Country</option>');
                        for(var i=0; i< countries.length; i++){
                            $("#undergrad_country").append('<option value="' + countries[i][1] + '">' + countries[i][0] + '</option>');
                        }
                    },

                    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                });

                $.ajax({
                    url: "/rank_types",
                    type: 'GET',
                    contentType: "application/json",
                    dataType: 'html',
                    success: function(jsonData) {
                        data = JSON.parse(jsonData);
                        ranks = data.rank_types;
                        console.log(ranks);
                        $("#undergrad_rank_type").append('<option selected disabled>Select Ranking Type</option>');
                        for(var i=0; i< ranks.length; i++){
                            $("#undergrad_rank_type").append('<option value="' + ranks[i][1] + '">' + ranks[i][0] + '</option>');
                        }
                        $("#undergrad_rank_type").append('<option>Ranking type not specified</option>');

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

    $('#saveUndergradInfo').click(function(){
        var school_name = $('#undergrad_school_name').val();
        var country = $('#undergrad_country').val();
        console.log('rere');
        console.log(country);
        var acceptance_rate =  $('#undergrad_acceptance rate').val();
        var location =  $('#undergrad_location_text').val();
        var description =  $('#undergrad_description_text').val();
        var ranking =  $('#undergrad_ranking_text').val();
        var rank_type =  $('#undergrad_rank_type').val();
        var website = $('#undergrad_website_text').val();
        $.ajax({
            url: "/undergrad_universities",
            type: 'POST',
            data: {university_name: school_name, country: country, acceptance_rate: acceptance_rate, location: location, university_desc: description, ranking: ranking, rank_type: rank_type, university_link: website },
            dataType: 'html',
            success: function(data) {
                console.log(data);
                $("#addUndergradModal").modal('hide');

            },

            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        });
    });
    
});


