class Validation {
  bool isValid(String? string) {
    return string != null &&
        string != "" &&
        string != "null" &&
        string != 'null' &&
        string != 'Null' &&
        string.trim().isNotEmpty;
  }

  final RegExp _email = RegExp(
      r"^((([a-z]|\d|[!#\$%&'*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

  final RegExp _password =
      RegExp(r"^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$");

  final RegExp _validSpace = RegExp(r"^[A-Za-z]( ?[A-Za-z] ?)*$");

  final RegExp _validAlphanumeric = RegExp(r'^[a-zA-Z0-9]+$');

  final RegExp _validAlphanumericSpaceAngHipen = RegExp(r'^[A-Za-z0-9- ]+$');

  final RegExp _panCardRegex =
      RegExp(r'^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$');

  final RegExp _aadharCardRegex = RegExp(r'^[0-9]{12}$');

  final RegExp _voterCardRegex = RegExp(r'^[A-Z]{3}[0-9]{7}$');

  bool isValidList(List? list) {
    return list != null && list.isNotEmpty && list.isNotEmpty;
  }

  bool isEmailValid(String str) {
    return _email.hasMatch(str.toLowerCase());
  }

  bool isAlphaNumeric(String str) {
    return _validAlphanumeric.hasMatch(str.toLowerCase());
  }

  bool isValidPersonName(String str) {
    return _validSpace.hasMatch(str.toString().trim());
  }

  bool isValidPassword(String str) {
    return _password.hasMatch(str);
  }

  bool isValidPanCard(String str) {
    return _panCardRegex.hasMatch(str);
  }

  bool isValidVoterCard(String str) {
    return _voterCardRegex.hasMatch(str);
  }

  bool isValidAadhaarCard(String str) {
    return _aadharCardRegex.hasMatch(str);
  }

  bool isValidAlphaNumericAndHipen(String str) {
    return _validAlphanumericSpaceAngHipen.hasMatch(str);
  }

  bool isValidUserNameLength(String str) {
    return str.length < 5;
  }
}
