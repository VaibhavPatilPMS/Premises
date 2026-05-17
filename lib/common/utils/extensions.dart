import 'package:intl/intl.dart';

extension ToBeginningOfSentence on String {
  String toBeginningOfSentence() {
    return toBeginningOfSentenceCase(this)!;
  }
}

extension BoolParsing on String {
  bool parseBool() {
    if (toLowerCase() == 'true') {
      return true;
    } else if (toLowerCase() == 'false') {
      return false;
    }
    throw '"$this" can not be parsed to boolean.';
  }
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension ListExtensions<T> on List<T> {
  Iterable<T> whereWithIndex(bool Function(T element, int index) test) {
    final List<T> result = [];
    for (var i = 0; i < length; i++) {
      if (test(this[i], i)) {
        result.add(this[i]);
      }
    }
    return result;
  }
}

extension IterableExtension<T> on List<T> {
  Iterable<T> distinctBy(Object getCompareValue(T e)) {
    var idSet = <Object>{};
    var distinct = <T>[];
    for (var d in this) {
      if (idSet.add(getCompareValue(d))) {
        distinct.add(d);
      }
    }

    return distinct;
  }
}

// extension DateTimeFromTimeOfDay on DateTime {
//   DateTime appliedFromTimeOfDay(TimeOfDay timeOfDay) {
//     return DateTime(year, month, day, timeOfDay.hour, timeOfDay.minute,0);
//   }
// }
