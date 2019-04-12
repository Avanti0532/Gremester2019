$(document).ready(function() {
    var slidercgpa = $("#slider-range-cgpa").slider({
        range: true,
        min: 0,
        max: 100,
        step: 1,
        values: [0, 100],
        slide: function(event, ui) {
            $( "#cgpa_score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
        }
    });

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

    var slidermsob = $("#slider-range-msob").slider({
        range: true,
        min: 0,
        max: 5,
        step: 1,
        values: [0, 5],
        slide: function(event, ui) {
            $( "#msob_score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
        }
    });

    var sliderphdo = $("#slider-range-phdo").slider({
        range: true,
        min: 0,
        max: 5,
        step: 1,
        values: [0, 5],
        slide: function(event, ui) {
            $( "#phdo_score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
        }
    });

    $( "#cgpa_score" ).val($( "#slider-range-cgpa" ).slider( "values", 0 ) +
        " - " + $( "#slider-range-cgpa" ).slider( "values", 1 ) );

    $( "#greq_score" ).val($( "#slider-range-greq" ).slider( "values", 0 ) +
        " - " + $( "#slider-range-greq" ).slider( "values", 1 ) );

    $( "#grev_score" ).val($( "#slider-range-grev" ).slider( "values", 0 ) +
        " - " + $( "#slider-range-grev" ).slider( "values", 1 ) );

    $( "#msob_score" ).val($( "#slider-range-msob" ).slider( "values", 0 ) +
        " - " + $( "#slider-range-msob" ).slider( "values", 1 ) );

    $( "#phdo_score" ).val($( "#slider-range-phdo" ).slider( "values", 0 ) +
        " - " + $( "#slider-range-phdo" ).slider( "values", 1 ) );

    var getUrlParameter = function getUrlParameter(sParam) {
        var sPageURL = window.location.search.substring(1),
            sURLVariables = sPageURL.split('&'),
            sParameterName,
            i;

        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('=');

            if (sParameterName[0] === sParam) {
                return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
            }
        }
    };

    if (location.pathname == '/profiles/filter'){
        var research_interests = getUrlParameter('research_interests');
        $("#research_interests").find('option[value='+research_interests+']').prop('selected', true);
        var multiple_interests = getUrlParameter('multiple_interests');
        var multiple_interests_arr = multiple_interests.split(",");
        var arr = [];
        var ri_value;
        if (multiple_interests != '') {
            for (var i = 0; i < multiple_interests_arr.length; i++) {
                ri_value = $("#research_interests").find('option[value=' + multiple_interests_arr[i] + ']').text();
                $("#researchInterestsModal").find('input[id=' + multiple_interests_arr[i] + ']').prop('checked', true);
                arr.push(ri_value);
            }
        }
        $("#multiple_interests").val(multiple_interests);
        $("#multiple_interests_labels").text(arr);
        if (research_interests == 'multiple'){
            $("#buttonDiv").attr('hidden', false);
            $("#multiple_interests_labels").attr('hidden', false);
        }else{
            $("#buttonDiv").attr('hidden', true);
            $("#multiple_interests_labels").attr('hidden', true);
        }


        var undergrad_university = getUrlParameter('undergrad_university');
        $("#undergrad_university").find('option[value='+undergrad_university+']').prop('selected', 'true');

        var cgpa_score = getUrlParameter('cgpa_score');
        cgpa_score_replaced = cgpa_score.replace("+"," ")
        $("#cgpa_score").val(cgpa_score_replaced);
        cgpa_vals = cgpa_score_replaced.split('-');
        cgpa_low = cgpa_vals[0].trim();
        cgpa_high = cgpa_vals[1].trim();

        var slidercgpa = $("#slider-range-cgpa").slider({
            range: true,
            min: 0,
            max: 100,
            step: 1,
            values: [cgpa_low, cgpa_high],
            slide: function(event, ui) {
                $( "#cgpa_score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
            }
        });

        var greq_score = getUrlParameter('greq_score');
        greq_score_replaced = greq_score.replace("+"," ")
        $("#greq_score").val(greq_score_replaced);
        greq_vals = greq_score_replaced.split('-');
        greq_low = greq_vals[0].trim();
        greq_high = greq_vals[1].trim();

        var slidergreq = $("#slider-range-greq").slider({
            range: true,
            min: 130,
            max: 170,
            step: 1,
            values: [greq_low, greq_high],
            slide: function(event, ui) {
                $( "#greq_score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
            }
        });

        var grev_score = getUrlParameter('grev_score');
        grev_score_replaced = grev_score.replace("+"," ")
        $("#grev_score").val(grev_score_replaced);
        grev_vals = grev_score_replaced.split('-');
        grev_low = grev_vals[0].trim();
        grev_high = grev_vals[1].trim();

        var slidergrev = $("#slider-range-grev").slider({
            range: true,
            min: 130,
            max: 170,
            step: 1,
            values: [grev_low, grev_high],
            slide: function(event, ui) {
                $( "#grev_score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
            }
        });

        var msob_score = getUrlParameter('msob_score');
        msob_score_replaced = msob_score.replace("+"," ")
        $("#msob_score").val(msob_score_replaced);
        msob_vals = msob_score_replaced.split('-');
        msob_low = msob_vals[0].trim();
        msob_high = msob_vals[1].trim();

        var slidermsob = $("#slider-range-msob").slider({
            range: true,
            min: 0,
            max: 5,
            step: 1,
            values: [msob_low, msob_high],
            slide: function(event, ui) {
                $( "#msob_score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
            }
        });

        var phdo_score = getUrlParameter('phdo_score');
        phdo_score_replaced = phdo_score.replace("+"," ")
        $("#phdo_score").val(phdo_score_replaced);
        phdo_vals = phdo_score_replaced.split('-');
        phdo_low = phdo_vals[0].trim();
        phdo_high = phdo_vals[1].trim();

        var sliderphdo = $("#slider-range-phdo").slider({
            range: true,
            min: 0,
            max: 5,
            step: 1,
            values: [phdo_low, phdo_high],
            slide: function(event, ui) {
                $( "#phdo_score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
            }
        });

        $( "#cgpa_score" ).val($( "#slider-range-cgpa" ).slider( "values", 0 ) +
            " - " + $( "#slider-range-cgpa" ).slider( "values", 1 ) );

        $( "#greq_score" ).val($( "#slider-range-greq" ).slider( "values", 0 ) +
            " - " + $( "#slider-range-greq" ).slider( "values", 1 ) );

        $( "#grev_score" ).val($( "#slider-range-grev" ).slider( "values", 0 ) +
            " - " + $( "#slider-range-grev" ).slider( "values", 1 ) );

        $( "#msob_score" ).val($( "#slider-range-msob" ).slider( "values", 0 ) +
            " - " + $( "#slider-range-msob" ).slider( "values", 1 ) );

        $( "#phdo_score" ).val($( "#slider-range-phdo" ).slider( "values", 0 ) +
            " - " + $( "#slider-range-phdo" ).slider( "values", 1 ) );

    }else{
        var slidercgpa = $("#slider-range-cgpa").slider({
            range: true,
            min: 0,
            max: 100,
            step: 1,
            values: [0, 100],
            slide: function(event, ui) {
                $( "#cgpa_score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
            }
        });

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

        var slidermsob = $("#slider-range-msob").slider({
            range: true,
            min: 0,
            max: 5,
            step: 1,
            values: [0, 5],
            slide: function(event, ui) {
                $( "#msob_score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
            }
        });

        var sliderphdo = $("#slider-range-phdo").slider({
            range: true,
            min: 0,
            max: 5,
            step: 1,
            values: [0, 5],
            slide: function(event, ui) {
                $( "#phdo_score" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
            }
        });

        $( "#cgpa_score" ).val($( "#slider-range-cgpa" ).slider( "values", 0 ) +
            " - " + $( "#slider-range-cgpa" ).slider( "values", 1 ) );

        $( "#greq_score" ).val($( "#slider-range-greq" ).slider( "values", 0 ) +
            " - " + $( "#slider-range-greq" ).slider( "values", 1 ) );

        $( "#grev_score" ).val($( "#slider-range-grev" ).slider( "values", 0 ) +
            " - " + $( "#slider-range-grev" ).slider( "values", 1 ) );

        $( "#msob_score" ).val($( "#slider-range-msob" ).slider( "values", 0 ) +
            " - " + $( "#slider-range-msob" ).slider( "values", 1 ) );

        $( "#phdo_score" ).val($( "#slider-range-phdo" ).slider( "values", 0 ) +
            " - " + $( "#slider-range-phdo" ).slider( "values", 1 ) );


    }


    $('#research_interests').change(function (e) {
        e.stopImmediatePropagation();
        var theValue = $(this).find('option:selected').text();
        if (theValue == "**Multiple**") {
            jQuery.noConflict();
            $("#researchInterestsModal").modal(
                 {
                     backdrop: false,
                     keyboard: false,
                     show: true
                 }
            );
            $("#researchInterestsModal").addClass('in');
            $("#researchInterestsModal").find($("div[role=alert]")).text("");
            if($("#researchInterestsModal").find($("div[role=alert]")).hasClass('in')){
                $("#researchInterestsModal").find($("div[role=alert]")).removeClass('in');
            }
            $("#buttonDiv").attr('hidden', false);
            $("#multiple_interests").attr("hidden", false);
            $("#multiple_interests_labels").attr("hidden", false);
        }else{
            $("#multiple_interests_labels").attr("hidden", true);
            $("#multiple_interests").attr("hidden", true);
            $("#buttonDiv").attr('hidden', true);
        }
    });
    $("#cancelModal").click(function(){
        $("#multiple_interests_labels").attr("hidden", true);
        $("#multiple_interests").attr("hidden", true);
        $("#buttonDiv").attr('hidden', true);
        $("#researchInterestsModal").removeClass('in');
        $("#research_interests").find('option[id="any-select"]').prop('selected',true);
    });
    $("#x_btn").click(function(){
        $("#research_interests").find('option[id="any-select"]').prop('selected',true);
        $("#multiple_interests_labels").attr("hidden", true);
        $("#multiple_interests").attr("hidden", true);
        $("#buttonDiv").attr('hidden', true);
        $("#researchInterestsModal").removeClass('in');
    });
    $("#changeInterests").click(function(){
        $("#researchInterestsModal").modal(
            {backdrop: false,
                keyboard: false,
                show: true}
        );
    });
    $('#interests').on('click', '#changeInterests', function(){
        $("#researchInterestsModal").show();
    });

    $('#doneModal').click(function (e) {
        e.stopImmediatePropagation();
        var array_interests_ids = [];
        var array_interests_labels = [];
        var no_checked = $("#researchInterestsModal input:checkbox:checked").length;
        if (no_checked == 0){
            $("div[role=alert]").text("Please select at least one research interest!");
            $("div[role=alert]").addClass('in');
        }else{
            $("input:checkbox:checked").each(function(){
                array_interests_ids.push($(this).val());
                array_interests_labels.push($(this).parent().find("label").text());
            });
            $("div[role=alert]").removeClass('in');
            $("#researchInterestsModal").hide();
            $("#multiple_interests_labels").text(array_interests_labels);
            $("#multiple_interests").val(array_interests_ids);
        }

    });


});



