//= require selectize/selectize.min

$(document).on('ready turbolinks:load', () => {
    WalgProg.selectize();
});

WalgProg.selectize = () => {
    const selects = $('.apply-selectize');

    if (selects.length > 0) {
        selects.selectize();
        $('.selectize-input input[placeholder]').attr('style', 'width: 100%;');
    }
}
