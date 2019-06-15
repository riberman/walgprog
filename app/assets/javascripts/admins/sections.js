$(document).on('turbolinks:load', () => {
  const statusInput = $('#section_status');
  const alternativeInput = $('.section_alternative_text');
  WAlgProg.sectionsSortable();
  WAlgProg.saveSectionsOrder();
  WAlgProg.loadFontAwesomeIcons();
  WAlgProg.sectionStatusListener(statusInput, alternativeInput);
  statusInput.trigger('change');
});

WAlgProg.loadFontAwesomeIcons = () => {
  const sectionIcon = $('#section-icon').val();
  const iconSelect = $('.icon-select');
  const url = 'https://gist.githubusercontent.com/RobinMalfait/b2632576462910a4cd67/raw/'
    + '799d7d22dd418402e40f06c56cde7bdbd446927d/FontAwesome.json';
  $.get(url, (data) => {
    const parsed = JSON.parse(data).icons;
    $.each(parsed, (index, icon) => {
      const option = document.createElement('option');
      option.className = 'fa';
      option.value = icon.id;
      option.selected = sectionIcon === icon.id;
      option.innerHTML = `&#x${icon.unicode};  ${icon.id}`;
      iconSelect.append(option);
    });
  });
};

WAlgProg.sectionStatusListener = (input, inputToToggle) => {
  $(input).on('change', (event) => {
    const status = event.target.value;
    (status === 'other') ? inputToToggle.removeClass('hidden') : inputToToggle.addClass('hidden');
  });
};

WAlgProg.sectionsSortable = () => {
  $('tbody').sortable({
    group: 'no-drop',
    handle: '.section-to-order',
    onDragStart($item, container, _super) {
      if (!container.options.drop) $item.clone().insertAfter($item);
      _super($item, container);
    },
    update() {
      const sections = $('tbody .index-td');
      const maxSectionIndex = sections.length;
      $.each(sections, (index, section) => {
        $(section).html(maxSectionIndex - (index));
      });
    },
  });
};

WAlgProg.saveSectionsOrder = () => {
  const sections = [];
  $('#save-sections-order').click(() => {
    const sectionsTr = $('tbody tr');
    $.each(sectionsTr, (index, section) => {
      sections.push({
        id: +$(section).find('.id-td').html(),
        index: +$(section).find('.index-td').html(),
      });
    });

    const eventId = $('#event_id').val();

    $.ajax({
      method: 'POST',
      url: `/admins/events/${eventId}/sections/index`,
      data: {
        authenticity_token: $('[name="csrf-token"]')[0].content,
        list: sections,
      },
      error: () => {},
      success: (response) => {
        alert(response.message);
      },
    });
  });
};
