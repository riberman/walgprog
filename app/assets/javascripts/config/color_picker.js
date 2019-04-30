$(document).on('turbolinks:load', () => {
    WalgProg.colorPicker();
});


WalgProg.colorPicker = () => {
    $('.colorpicker').colorpicker();
};