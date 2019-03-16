$(document).ready(function() {
    var slider = $("#slider-range-cgpa").slider({
        range: true,
        min: 0,
        max: 5,
        values: [0.5, 4.5],
        slide: function(event, ui) {
            $( "#cgpa-score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
        }
    });
    $( "#cgpa-score" ).val($( "#slider-range-cgpa" ).slider( "values", 0 ) +
            " - " + $( "#slider-range-cgpa" ).slider( "values", 1 ) );
});
