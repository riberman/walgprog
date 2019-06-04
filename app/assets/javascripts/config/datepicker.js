$(document).on('turbolinks:load', () => {
  WAlgProg.datePicker();
});

WAlgProg.datePicker = () => {
  options = {
    language: 'pt-BR',
  };
  $('.datepicker').datepicker(options);
};
