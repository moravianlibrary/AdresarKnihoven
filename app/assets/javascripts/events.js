$(document).on("focus", ".datepicker", function(e) {
    $(this).datepicker({"format": "yyyy-mm-dd", "weekStart": 1, "autoclose": true, "language": "cs"})
});