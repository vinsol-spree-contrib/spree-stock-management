function CsvInputButton(input) {
  this.fileInput = input.fileInput;
  this.submitButton = input.submitButton;
  this.form = input.form;
}

CsvInputButton.prototype.init = function() {
  var _this = this;
  this.submitButton.on('click', function() {
    event.preventDefault();
    _this.fileInput.click();
    _this.submitForm();
  });
};

CsvInputButton.prototype.submitForm = function() {
  var _this = this;
  this.fileInput.on('change', function() {
    _this.form.submit();
  });
};

$(function() {
  var inputs = {
    fileInput: $('input#file'),
    submitButton: $('input[data-disable-with="Import Stock CSV"]'),
    form: $("form[data-hook='csv_form']")
  },
    csvButtonsManager = new CsvInputButton(inputs);
  csvButtonsManager.init();
});
