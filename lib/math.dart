/*void main() {
  List<String> num = [
    "12374883",
    "167243656",
    "671829365.98",
    "67102365.9967",
    "18",
    "9",
    "1.5",
    "1.4"
  ];
  for (var x in num) {
    var result = divideByTwo(x);
    print("$x / 2 = $result");
    var y = double.parse(x) / 2;
    assert(y == double.parse(result));
    print("$y $result");
  }
  var listOfCouples = [
    ["23586667", "5454"],
    ["346745960", "5238051764638"],
    ["932857", "52222"],
    ["435780", "756793"],
    ["4", "5"],
    ["0", "7"],
    ["8", "5"],
    ["12", "54"],
  ];
  for (var couple in listOfCouples) {
    var result = addIntegers(couple[0], couple[1]);
    print("sum $couple = $result");
    var y1 = int.parse(couple[0]);
    var y2 = int.parse(couple[1]);
    assert((y1 + y2) == int.parse(result));
    print("${y1 + y2} $result");
  }
  var listOfCouples2 = [
    ["23586667", "5454"],
    ["346745960.74634", "5238051764638"],
    ["932857.658374434", "52222.74586"],
    ["435780.273846", "756793.678"],
    ["4.3757", "5.424"],
    ["0.784756", "7.217483974"],
    ["8.84", "5.1"],
    ["12.73", "54.0000001"],
  ];
  for (var couple in listOfCouples2) {
    var result = addNumbers(couple[0], couple[1]);
    print("sum $couple = $result");
    var y1 = double.parse(couple[0]);
    var y2 = double.parse(couple[1]);
    assert((y1 + y2) == double.parse(result));
    print("${y1 + y2} $result");
  }
  var listOfCouples3 = [
    ["23586667", "9999999"],
    ["346745960", "1051764638"],
    ["932857", "932857"],
    ["932857", "932858"],
    ["932857.00001", "932857"],
    ["4.3757", "4.3757"],
    ["4.3757", "4.3751"],
    ["4.375769", "4.3757"],
    ["8.848935", "8.847"],
    ["12", "12.0000001"],
    ["12.34000000", "12.34000"],
  ];
  for (var couple in listOfCouples3) {
    var result = myCompareTo(couple[0], couple[1]);
    print("Comparision $couple = $result");
    var y1 = double.parse(couple[0]);
    var y2 = double.parse(couple[1]);
    print("${y1.compareTo(y2)} $result");
  }
}*/
String increaseNumber(String num) {
  int dotIndex = num.indexOf('.');
  if (dotIndex == -1) {
    return "$num.1";
  } else {
    return "${num}1";
  }
}

String divideByTwo(String num) {
  int dotIndex = num.indexOf('.');
  int length = dotIndex != -1 ? dotIndex : num.length;
  String result = "";
  int remainder = 0;

  for (int i = 0; i < length; i++) {
    int digit = num.codeUnitAt(i) - 48;
    int tempValue = remainder * 10 + digit;
    result += (tempValue ~/ 2).toString();
    remainder = tempValue % 2;
  }

  if (dotIndex != -1) {
    result += ".";

    for (int j = dotIndex + 1; j < num.length; j++) {
      int digit = num.codeUnitAt(j) - 48;
      int tempValue = remainder * 10 + digit;
      result += (tempValue ~/ 2).toString();
      remainder = tempValue % 2;
    }
  }
  if (remainder == 1) {
    if (dotIndex == -1) {
      result += ".5";
    } else {
      result += "5";
    }
  }
  String wholePart = (dotIndex == -1) ? result : result.substring(0, dotIndex);

  if (wholePart.length > 1 && wholePart[0] == "0") {
    return result.substring(1);
  } else {
    return result;
  }
}

int max(int a, int b) {
  if (a > b) return a;
  return b;
}

int min(int a, int b) {
  if (a > b) return b;
  return a;
}

String addIntegers(String num1, String num2) {
  int length1 = num1.length;
  int length2 = num2.length;

  int carry = 0;
  String result = "";
  for (int i = length1 - 1, j = length2 - 1; i >= 0 || j >= 0; i--, j--) {
    int digit1 = i >= 0 ? num1.codeUnitAt(i) - 48 : 0;
    int digit2 = j >= 0 ? num2.codeUnitAt(j) - 48 : 0;

    int tempSum = digit1 + digit2 + carry;
    carry = tempSum ~/ 10;
    result = "${tempSum % 10}$result";
  }
  if (carry == 1) result = "1$result";
  return result;
}

String addNumbers(String num1, String num2) {
  int dotIndex1 = num1.indexOf('.');
  int dotIndex2 = num2.indexOf('.');
  String wholePart1 = (dotIndex1 == -1) ? num1 : num1.substring(0, dotIndex1);
  String wholePart2 = (dotIndex2 == -1) ? num2 : num2.substring(0, dotIndex2);
  String decimalPart1 = (dotIndex1 == -1) ? "" : num1.substring(dotIndex1 + 1);
  String decimalPart2 = (dotIndex2 == -1) ? "" : num2.substring(dotIndex2 + 1);
  //print("$num1 $wholePart1 $decimalPart1 $num2 $wholePart2 $decimalPart2");
  String wholePart = addIntegers(wholePart1, wholePart2);
  if (decimalPart1 == "" && decimalPart2 == "") {
    return wholePart;
  }
  var lenght1 = decimalPart1.length;
  var lenght2 = decimalPart2.length;
  var lenght = max(lenght1, lenght2);
  if (lenght1 < lenght) {
    decimalPart1 = decimalPart1 + "0" * (lenght - lenght1);
  }
  if (lenght2 < lenght) {
    decimalPart2 = decimalPart2 + "0" * (lenght - lenght2);
  }
  var decimalPart = addIntegers(decimalPart1, decimalPart2);
  if (decimalPart.length > lenght) {
    wholePart = addIntegers(wholePart, "1");
    decimalPart = decimalPart.substring(1);
  }
  return "$wholePart.$decimalPart";
}

int compareIntegerAwithB(String a, String b) {
  //1 A is bigger than B
  //0 equal
  //-1 B is bigger than A
  if (a.length > b.length) return 1;
  if (b.length > a.length) return -1;
  for (int i = 0; i < a.length; i++) {
    var digitA = a.codeUnitAt(i) - 48;
    var digitB = b.codeUnitAt(i) - 48;
    if (digitA > digitB) {
      return 1;
    }
    if (digitB > digitA) {
      return -1;
    }
  }
  return 0;
}

String avarage(String num1, String num2) {
  return divideByTwo(addNumbers(num1, num2));
}

int myCompareTo(String a, String b) {
  int dotIndex1 = a.indexOf('.');
  int dotIndex2 = b.indexOf('.');
  String wholePart1 = (dotIndex1 == -1) ? a : a.substring(0, dotIndex1);
  String wholePart2 = (dotIndex2 == -1) ? b : b.substring(0, dotIndex2);
  String decimalPart1 = (dotIndex1 == -1) ? "" : a.substring(dotIndex1 + 1);
  String decimalPart2 = (dotIndex2 == -1) ? "" : b.substring(dotIndex2 + 1);
  int firstComparation = compareIntegerAwithB(wholePart1, wholePart2);
  if (firstComparation == 1) return 1;
  if (firstComparation == -1) return -1;
  if (decimalPart2 == "" && decimalPart1 == "") {
    return 0;
  }
  var lenght1 = decimalPart1.length;
  var lenght2 = decimalPart2.length;
  var lenght = max(lenght1, lenght2);
  if (lenght1 < lenght) {
    decimalPart1 = decimalPart1 + "0" * (lenght - lenght1);
  }
  if (lenght2 < lenght) {
    decimalPart2 = decimalPart2 + "0" * (lenght - lenght2);
  }
  int secondComparation = compareIntegerAwithB(decimalPart1, decimalPart2);
  return secondComparation;
}
