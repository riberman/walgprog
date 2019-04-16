$(function () {

    $("#institution_state").on( "change", function() {
        var state_id = $("#institution_state").val();
        $.ajax({
            method: "GET",
            url: "/admins/cities/search/" + state_id,
            data: {state_id: state_id},
            success: function(data){
                console.log(data);

            }

        });
    });

});