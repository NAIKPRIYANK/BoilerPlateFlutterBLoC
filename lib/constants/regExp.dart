// ignore_for_file: file_names
class RegexPatterns{
  static RegExp onlyText  =  RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$');
  static RegExp phone  =  RegExp(r'^[0-9]{10}$');
  static RegExp onlyNumber  =  RegExp(r'^[0-9]+$');
  static RegExp email  = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com$');
  static RegExp pincode =  RegExp(r'^[0-9]{6}$');
  static RegExp notEmpty =  RegExp(r'^.+$');
  static RegExp decimalNumber = RegExp(r'^[+-]?\d+(\.\d+)?$');
  static RegExp requiredNumber = RegExp(r'^\d{1,4}$');
  static RegExp appRequiredNumber = RegExp(r'^\d{1,5}$');
  static RegExp questionText = RegExp(r'^([a-zA-Z]+(?: [a-zA-Z]+)*\s?\?|[\?])?$');

}

