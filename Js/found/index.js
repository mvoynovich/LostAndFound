// set the max date on the datetime field to the current time
$("#found-timestamp-field").ready(function() {
  $("#found-timestamp-field").attr("max", (new Date()).toISOString().substring(0, 16));
});