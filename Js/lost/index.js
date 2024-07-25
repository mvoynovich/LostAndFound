// set the max date on the datetime field to the current time
$("#lost-timestamp-field").ready(function() {
  $("#lost-timestamp-field").attr("max", (new Date()).toISOString().substring(0, 16));
});