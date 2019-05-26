document.addEventListener('turbolinks:load', () => {
  WAlgProg.sidebarMenuCollapse();
});

WAlgProg.sidebarMenuCollapse = () => {
  $('[data-toggle="collapse"]').click(() => {
    $('html, body').animate({ scrollTop: 0 }, 'slow');
  });
};
