$(document).on('turbolinks:load', () => {
  const iconSelect = $('.icon-select');
  $.get('https://gist.githubusercontent.com/RobinMalfait/b2632576462910a4cd67/raw/799d7d22dd418402e40f06c56cde7bdbd446927d/FontAwesome.json', (data) => {
    const parsed = JSON.parse(data).icons;
    $.each(parsed, (index, icon) => {
      iconSelect.append(`<option class="fa" value="${icon.id}">&#x${icon.unicode};  ${icon.id}</option>`);
    });
  });

  $(document).ready(() => {
    // $('#section_content').summernote();
  });
});
