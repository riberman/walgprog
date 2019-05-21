$(document).on('turbolinks:load', () => {
  WalgProg.datePicker();
});

WalgProg.datePicker = () => {
  options = {
    language: 'pt-BR',
  };
  $('.datepicker').datepicker(options);
};
