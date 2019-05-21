document.addEventListener('turbolinks:load', () => {
  const input = $('.image_preview input[type=file]');
  WalgProg.imagePreview(input);
});

WalgProg.imagePreview = (el) => {
  const readURL = (input) => {
    if (input.files && input.files[0]) {
      const reader = new FileReader();
      reader.onload = (e) => {
        $('.file_preview').attr('src', e.target.result);
        return $('.file_preview').addClass('active');
      };

      return reader.readAsDataURL(input.files[0]);
    }
  };

  return $(el).change(() => readURL(this));
};
