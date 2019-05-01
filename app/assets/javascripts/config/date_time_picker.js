$(document).on('turbolinks:load', () => {
    WalgProg.dateTimePicker({
        locale: 'pt-BR',
        autoclose: true,
        icons: {
            time: "fe fe-clock",
            date: "fa fa-calendar",
            up: "fa fa-arrow-up",
            down: "fa fa-arrow-down"
        },
    });
});

WalgProg.dateTimePicker = (options = {}) => {
    $('.datetimepicker-input').datetimepicker(options);
};