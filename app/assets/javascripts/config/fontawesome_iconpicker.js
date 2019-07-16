// https://github.com/farbelous/fontawesome-iconpicker
//= require fontawesome-iconpicker/fontawesome-iconpicker.min

$(document).on('turbolinks:load', () => {
  $('.icon-picker').iconpicker({
    placement: 'bottom',
    container: '#main-content',
    animation: false,
    hideOnSelect: true,
    templates: {
      search: '<input type="search" class="form-control iconpicker-search" placeholder="Pesquisar..." />',
    },
  });

  $('.icon-picker').on('iconpickerSelected', (event) => {
    input = $(event.currentTarget);
    span = input.parent().find('span.input-group-text');
    span.html(`<i class="${event.iconpickerValue}"><i>`);
  });
});
