$(document).ready(function(){
  $('.colorpicker').colorpicker();

  let options = {
    locale: 'pt-br',
    sideBySide: true,
    autoclose: true
  };

  if (window.location.pathname.match(/new/) !== null ){
    options.date = moment().format('YYYY-MM-DD hh:mm');
  }

  $('.datetimepicker-input').datetimepicker(options);
});
