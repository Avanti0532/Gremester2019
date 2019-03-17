$(document).ready(function() {

    $('#research-interests-multiselect').change(function () {
        var theValue = $(this).find('option:selected').text();
        if (theValue == "**Multiple**") {
            residenceAlert();
        }
    });
    var slidercgpa = $("#slider-range-cgpa").slider({
        range: true,
        min: 0,
        max: 5,
        step: 0.1,
        values: [0, 5],
        slide: function(event, ui) {
            $( "#cgpa_score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
        }
    });
    $( "#cgpa_score" ).val($( "#slider-range-cgpa" ).slider( "values", 0 ) +
            " - " + $( "#slider-range-cgpa" ).slider( "values", 1 ) );

    var slidergreq = $("#slider-range-greq").slider({
        range: true,
        min: 130,
        max: 170,
        step: 1,
        values: [130, 170],
        slide: function(event, ui) {
            $( "#greq_score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
        }
    });
    $( "#greq_score" ).val($( "#slider-range-greq" ).slider( "values", 0 ) +
        " - " + $( "#slider-range-greq" ).slider( "values", 1 ) );

    var slidergrev = $("#slider-range-grev").slider({
        range: true,
        min: 130,
        max: 170,
        step: 1,
        values: [130, 170],
        slide: function(event, ui) {
            $( "#grev_score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
        }
    });
    $( "#grev_score" ).val($( "#slider-range-grev" ).slider( "values", 0 ) +
        " - " + $( "#slider-range-grev" ).slider( "values", 1 ) );

    var slidermsob = $("#slider-range-msob").slider({
        range: true,
        min: 0,
        max: 5,
        step: 1,
        values: [0, 5],
        slide: function(event, ui) {
            $( "#msob-score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
        }
    });
    $( "#msob-score" ).val($( "#slider-range-msob" ).slider( "values", 0 ) +
        " - " + $( "#slider-range-msob" ).slider( "values", 1 ) );

    var sliderphdo = $("#slider-range-phdo").slider({
        range: true,
        min: 0,
        max: 5,
        step: 1,
        values: [0, 5],
        slide: function(event, ui) {
            $( "#phdo-score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
        }
    });
    $( "#phdo-score" ).val($( "#slider-range-phdo" ).slider( "values", 0 ) +
        " - " + $( "#slider-range-phdo" ).slider( "values", 1 ) );
});



