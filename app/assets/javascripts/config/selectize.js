//= require selectize/selectize.min

$(document).on('ready turbolinks:load', () => {
    WalgProg.selectize();
});

WalgProg.selectize = () => {
    $('.selectize').selectize();
}