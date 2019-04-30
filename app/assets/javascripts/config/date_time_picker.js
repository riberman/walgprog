$(document).on('turbolinks:load', () => {
    WalgProg.dateTimePicker();
});

WalgProg.dateTimePicker = () => {
    $('.datetimepicker-input').datetimepicker({
        locale: 'pt-br'
    });
};