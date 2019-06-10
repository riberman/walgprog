$(document).on('turbolinks:load', () => {
  const statusInput = $('#section_status');
  const alternativeInput = $('.section_alternative_text');
  WAlgProg.loadFontAwesomeIcons();
  WAlgProg.sectionStatusListener(statusInput, alternativeInput);
  statusInput.trigger('change');
});

WAlgProg.loadFontAwesomeIcons = () => {
  const iconSelect = $('.icon-select');
  const url = 'https://gist.githubusercontent.com/RobinMalfait/b2632576462910a4cd67/raw/'
    + '799d7d22dd418402e40f06c56cde7bdbd446927d/FontAwesome.json';
  $.get(url, (data) => {
    const parsed = JSON.parse(data).icons;
    $.each(parsed, (index, icon) => {
      iconSelect.append(`<option class="fa" value="${icon.id}">&#x${icon.unicode};  ${icon.id}</option>`);
    });
  });
};

WAlgProg.sectionStatusListener = (input, inputToToggle) => {
  $(input).on('change', (event) => {
    const status = event.target.value;

    (status === 'O')
      ? inputToToggle.removeClass('hidden')
      : inputToToggle.addClass('hidden');
  });
};
