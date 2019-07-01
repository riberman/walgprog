//= require simpleMde/simplemde.min

$(document).on('turbolinks:load', () => {
  WAlgProg.loadMarkdownEditor();
});

WAlgProg.loadMarkdownEditor = () => {
  $('.markdown-editor').each(function () {
    const id = $(this).attr('id');
    WAlgProg.simpleMDE = new SimpleMDE({ element: document.getElementById(id) });
    return WAlgProg.simpleMDE;
  });
};
