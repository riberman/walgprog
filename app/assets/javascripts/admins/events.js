$(document).on('turbolinks:load', function(){
  WalgProg.colorPicker();
  WalgProg.dateTimePicker();
});


WalgProg.colorPicker = function(){
  $('.colorpicker').colorpicker();

  let options = {
    locale: 'pt-br',
    sideBySide: true,
    autoclose: true
  };

};

WalgProg.dateTimePicker = function() {

    $('.datetimepicker-input').datetimepicker();

}
