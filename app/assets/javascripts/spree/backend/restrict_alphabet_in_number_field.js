function RestrictNumberField(input) {
  this.numberField = input.numberField;
}

RestrictNumberField.prototype.init = function() {
  this.numberField.keydown(function(e) {
    if ([69, 187, 188, 189, 190].includes(e.keyCode)) {
      e.preventDefault();
    }
  });
};

$(function() {
  var input = {
    numberField: $("input[data-hook='number_spinner']")
  },
    restrictNumberFieldManager = new RestrictNumberField(input);
  restrictNumberFieldManager.init();
});
