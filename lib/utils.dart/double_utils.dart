double parseDoubleFromText(String value){
  final replacedVal = value.replaceAll(",", ".");
  return double.tryParse(replacedVal);
}