document.addEventListener('turbolinks:load', () => {
  var input = $('.image_preview input[type=file');
  WalgProg.imagePreview(input);
});

WalgProg.imagePreview = function(el) {
  const readURL = function(input){
    if (input.files && input.files[0]) {
      const reader = new FileReader();
      reader.onload = function(e) {
        $('.file_preview').attr('src', e.target.result);
        return $('.file_preview').addClass('active');
      };

      return reader.readAsDataURL(input.files[0]);
    }
  };

  return $(el).change(function() {
    return readURL(this);
  });
};

