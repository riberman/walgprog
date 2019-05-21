document.addEventListener('turbolinks:load', () => {
  WalgProg.sidebarMenuCollapse();
});

WalgProg.sidebarMenuCollapse = () => {
  $('[data-toggle="collapse"]').click(() => {
    $('html, body').animate({ scrollTop: 0 }, 'slow');
  });
};
