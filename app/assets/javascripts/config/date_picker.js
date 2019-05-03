$(document).on('turbolinks:load', () => {
    WalgProg.datePicker({
        language: 'pt-BR',
    });
});

WalgProg.datePicker = (options = {}) => {
    $('.datepicker').datepicker(options);
};