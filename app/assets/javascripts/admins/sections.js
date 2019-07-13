$(document).on('turbolinks:load', () => {
  WAlgProg.sectionsSortable();
  WAlgProg.sectionStatusListener();
});

WAlgProg.sectionStatusListener = () => {
  const page = $('#sections-new, #sections-edit, #sections-create, #sections-update');
  if (page.length < 1) return;

  const status = page.find('.section_status');
  status.on('change', () => {
    const selectedValue = page.find("input[name='section[status]']:checked").val();

    const atMd = page.find('.section_alternative_text_md');

    if (selectedValue === 'alternative_text') {
      atMd.removeClass('hidden');
    } else {
      atMd.addClass('hidden');
    }
  });

  status.trigger('change');
};

WAlgProg.sectionsSortable = () => {
  const el = '#sections-index .sortable';
  $(el).sortable({
    axis: 'y',
    update: () => {
      $.ajax({
        method: 'PATCH',
        url: $(el).data('sort-url'),
        data: $(el).sortable('serialize'),
      });
    },
  });
};
