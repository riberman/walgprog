$(document).on('ready turbolinks:load', function () {

    console.log("Carregou Página");
    $('#institution_city').attr('disabled', 'true');
    $('#institution_state_id').on( "click", function() {
        console.log("Selecionau Estado");
        var state_id = $(this).val();
        $('#institution_city').removeAttr('disabled');
        $.ajax({
            method: "GET",
            url: "/admins/states/" + state_id + "/cities",
            success: function(data) {
                $('#institution_city_id').html("");
                $.each(data['cities'], function (index, city) {
                    $('#institution_city_id').append($('<option>', {
                        value: city['id'],
                        text: city['name']
                    }));
                });
            }
        });
    });
});