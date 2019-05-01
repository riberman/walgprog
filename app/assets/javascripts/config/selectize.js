$(document).on('turbolinks:load', () => {
    WalgProg.selectize();
});

WalgProg.selectize = () => {
    const selects = $('select');

    if (selects.length > 0) {
        selects.selectize();
        $('select[data="selectize"]').selectize();
        $('.selectize-input input[placeholder]').attr('style', 'width: 100%;');
    }
};