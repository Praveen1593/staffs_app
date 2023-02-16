
double percentageCalWithSymbol(String strValue) {
  List<String> c = strValue.split("");
  c.removeLast();
  double convert = double.parse(c.join());
  return (convert / 100);
}

double percentageCal(String strValue) {
  String percentageVal = strValue.replaceAll("%", "");
  double convertPercentage = int.parse(percentageVal) * 0.01;
  /*print("Percentage Value $strValue");
  print("Percentage Replace Value $percentageVal");
  print("Percentage Convert Value $convertPercentage");*/
  return convertPercentage;
}
