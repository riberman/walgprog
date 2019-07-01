//= require simpleMde/simplemde.min

$(document).on('turbolinks:load', () => {
  WAlgProg.loadMarkdownEditor();
});

WAlgProg.loadMarkdownEditor = () => {
  $('.markdown-editor').each((index, element) => {
    const id = $(element).attr('id');
    WAlgProg.simpleMDE = new SimpleMDE({ element: document.getElementById(id) });
    return WAlgProg.simpleMDE;
  });
};
