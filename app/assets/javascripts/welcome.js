//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-slider
//= require select2
//= require select2-full
//= require bootstrap-select.min
//= require rateyo.min
//= require jquery.infinitescroll
(function() {
  $(document).ready(function() {
    return $("#teachers .page").infinitescroll({
      navSelector: "nav.pagination",
      nextSelector: "nav.pagination a[rel=next]",
      itemSelector: "#teachers tr.teacher"
    });
  });
console.log("test");
}).call(this);
