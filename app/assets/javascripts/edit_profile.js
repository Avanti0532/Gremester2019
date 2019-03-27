$(document).ready(function () {

    $('#country_college_edit_profile').change(function() {
        var country;
        country = $('#country_college_edit_profile :selected').text();
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
            if ($("#add_new_undergrad").length <= 0) {
                $("#undergraduate_edit").append('<button type="button" id="add_new_undergrad">Add your school</button>');
            }
            $('#add_new_undergrad').click(function() {
                $('#undergrad_country').empty();
                $('#undergrad_rank_type').empty();
                $.ajax({
                    url: "/countries",
                    type: 'GET',
                    contentType: "application/json",
                    dataType: 'html',
                    success: function(jsonData) {
                        data = JSON.parse(jsonData);
                        countries = data.countries;
                        for(var i=0; i< countries.length; i++){
                            $("#undergrad_country").append('<option value="' + countries[i][1] + '">' + countries[i][0] + '</option>');
                        }
                        selected_country = $("#country_college_edit_profile").val();
                        $("#undergrad_country").val([]);
                        $("#undergrad_country").val(selected_country);
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
                        $("#undergrad_rank_type").append('<option selected disabled>Select Ranking Type</option>');
                        for(var i=0; i< ranks.length; i++){
                            $("#undergrad_rank_type").append('<option value="' + ranks[i][1] + '">' + ranks[i][0] + '</option>');
                        }
                        $("#undergrad_rank_type").append('<option>Ranking type not listed</option>');
                    },

                    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                });
                $('div[role=alert]').text('');
                $('div[role=alert]').addClass('in');
                $('div[role=alert]').hide();


                $("#addUndergradModal").modal(
                    {backdrop: true}
                );

            });
        }
    });
    $('#undergrad_rank_type').change(function() {
        var ranking = $('#undergrad_rank_type :selected').text();
        if (ranking === 'Ranking type not listed') {
            if ($("#new_rank_type").length <= 0) {
                $("#undergrad_ranking").append(
                    $('<input>', {
                        type: 'text',
                        placeholder: 'New rank type',
                        id: 'new_rank_type',
                        class: 'form-control',
                        val: ''
                    }));
            }
        }
    });


    $('#saveUndergradInfo').click(function(){
        var school_name = $('#undergrad_school_name').val();
        var country = $('#undergrad_country').val();
        var acceptance_rate =  $('#undergrad_acceptance_rate_text').val();
        var location =  $('#undergrad_location_text').val();
        var description =  $('#undergrad_description_text').val();
        var ranking =  $('#undergrad_ranking_text').val();
        var rank_type =  $('#undergrad_rank_type').val();
        var website = $('#undergrad_website_text').val();
        var new_rank_type = $('#new_rank_type').val();
        var valid = true;
        if (school_name == null || school_name.length === 0) {
            $("div[role=alert]").text('');
            $("div[role=alert]").text('Please fill in university name');
            $("div[role=alert]").show();
            valid = false;
        } else if (ranking !== null && ranking.length > 0) {
            if (rank_type == null || rank_type.length === 0) {
                $("div[role=alert]").text('');
                $("div[role=alert]").text('Please select rank type');
                $("div[role=alert]").show();
                valid = false;
            } else if (rank_type === 'Ranking type not listed' && (new_rank_type === null || new_rank_type.length === 0)) {
                $("div[role=alert]").text('');
                $("div[role=alert]").text('Please specify new rank type');
                $("div[role=alert]").show();
                valid = false;
            } else {
                var ranking_num = parseInt(ranking, 10);
                if (isNaN(ranking_num) || ranking_num < 0) {
                    $("div[role=alert]").text('');
                    $("div[role=alert]").text('Ranking must be a number greater than 0');
                    $("div[role=alert]").show();
                    valid = false;
                }
            }
        } else if (acceptance_rate !== null && acceptance_rate.length > 0) {
            var acceptance_rate_num = parseInt(acceptance_rate, 10);
            if (isNaN(acceptance_rate_num) || acceptance_rate_num < 0 || acceptance_rate_num > 100) {
                $("div[role=alert]").text('');
                $("div[role=alert]").text('Acceptance rate must be a number greater than 0 and less than 100');
                $("div[role=alert]").show();
                valid = false;
            }
        } else if (rank_type !== null && rank_type.length > 0) {
            if (ranking == null || ranking.length === 0) {
                $("div[role=alert]").text('');
                $("div[role=alert]").text('Please specify ranking');
                $("div[role=alert]").show();
                valid = false;
            }
        }
        if (valid) {
            $.ajax({
                url: "/undergrad_universities",
                type: 'POST',
                data: {
                    university_name: school_name,
                    country: country,
                    acceptance_rate: acceptance_rate,
                    location: location,
                    university_desc: description,
                    ranking: ranking,
                    rank_type: rank_type,
                    university_link: website,
                    new_rank_type: new_rank_type
                },
                dataType: 'json',
                success: function (data) {
                    if (data.errors != null) {
                        $("div[role=alert]").text('');
                        $("div[role=alert]").text(data.errors);
                        $("div[role=alert]").show();
                    } else {
                        setTimeout(function () {
                            window.location.reload();
                         });
                    }
                },

                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
                },
            });
        }
    });
});