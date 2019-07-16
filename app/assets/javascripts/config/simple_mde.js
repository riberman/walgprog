//= require simpleMde/simplemde.min
WAlgProg.simpleMDEInstances = {};

$(document).on('turbolinks:load', () => {
  WAlgProg.loadMarkdownEditor();
});

WAlgProg.loadMarkdownEditor = () => {
  $('.markdown-editor').each((index, element) => {
    const id = $(element).attr('id');
    WAlgProg.simpleMDEInstances[id] = new SimpleMDE({ element: document.getElementById(id) });
    return WAlgProg.simpleMDEInstances[id];
  });
};
