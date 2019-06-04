// From: https://github.com/farbelous/bootstrap-colorpicker/releases
//       https://farbelous.io/bootstrap-colorpicker/
//= require colorpicker/bootstrap-colorpicker.min

$(document).on('turbolinks:load', () => {
  WAlgProg.colorPicker();
});


WAlgProg.colorPicker = () => {
  $('.apply-colorpicker').colorpicker({
    fallbackColor: '#000',
    fallbackFormat: 'hex',
    popover: {
      animation: true,
      placement: 'bottom',
      fallbackPlacement: 'flip',
      container: '#main-content',
    },
  });
};
