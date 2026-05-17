import 'package:intl/intl.dart';
import 'package:premises/common/resources/app_strings.dart';

class DateTimeUtil {
  String formatddMMyyyyhhmma = 'dd-MM-yyyy hh:mm a';
  String formatyyyyMMddHHmm = 'yyyy-MM-dd HH:mm';
  //final String _formatddMMMYYYYHHmm = 'dd-MMM-yyyy HH:mm';
  String formatyyyyMMMdd = 'yyyy-MM-dd';
  String formatddMMMyyyy = 'dd MMM yyyy';
  String formatddMMMyyyyhhmma = 'dd MMM yyyy hh:mm a';
  String formatMMMYY = 'MMM yy';
  String formatDDMMYYYY = 'dd/MM/yyyy';
  String formatDDMMYYYYhhmma = 'dd/MM/yyyy hh:mm a';
  String formathhmma = 'hh:mm a';
  String formatMonth = 'MMM';

  /// Function to return date time object form given string date

  // /// 03-11-2022 04:54 PM
  // String getDateMonthTimeWithAMPM(String? date) {
  //   if (date == null || date.length <= 0 || date == '' || date == 'null') {
  //    return AppStrings().dash;
  //   }
  //   // Convert String to date from incoming format "2020-06-12 00:00:00.0"
  //   DateTime tempDate = DateTime.parse(date).toLocal();
  //   // Convert date to string in given format
  //   String returnDate = DateFormat(formatddMMyyyyhhmma).format(tempDate);
  //   return returnDate;
  // }
  //
  // //2022-11-03 14:03
  // String getYearMonthDateTime(String? date) {
  //   if (date == null || date.length <= 0 || date == '' || date == 'null') {
  //    return AppStrings().dash;
  //   }
  //   // Convert String to date from incoming format "2020-06-12 00:00:00.0"
  //   DateTime tempDate = DateTime.parse(date).toLocal();
  //   // Convert date to string in given format
  //   String returnDate = DateFormat(formatyyyyMMMdd).format(tempDate);
  //   return returnDate;
  // }
  //
  // // 01/11/2022
  String getDateMonthAndYear(String? date) {
    if (date == null ||
        date.isEmpty ||
        date == '' ||
        date == 'null' ||
        date == '-') {
      return AppStrings().dash;
    }
    // Convert String to date from incoming format "2020-06-12 00:00:00.0"
    DateTime tempDate = DateTime.parse(date).toLocal();
    // Convert date to string in given format
    String returnDate = DateFormat(formatDDMMYYYY).format(tempDate);
    return returnDate;
  }

  // // 01/11/2022 for  Mobile dashboard
  String getDateMonthAndYearWithDashFormat(String? date) {
    if (date == null ||
        date.isEmpty ||
        date == '' ||
        date == 'null' ||
        date == '-') {
      return AppStrings().dash;
    }
    // Convert String to date from incoming format "2020-06-12 00:00:00.0"
    DateTime tempDate = DateTime.parse(date).toLocal();
    // Convert date to string in given format
    String returnDate = DateFormat(formatddMMMyyyy).format(tempDate);
    return returnDate;
  }

  //
  // // 03/11/2022 02:03 PM
  // String getDateWithMonthNameAndYear(String? date) {
  //   if (date == null || date.length <= 0 || date == '' || date == 'null') {
  //    return AppStrings().dash;
  //   }
  //   // Convert String to date from incoming format "2020-06-12 00:00:00.0"
  //   DateTime tempDate = DateTime.parse(date).toLocal();
  //   // Convert date to string in given format
  //   String returnDate = DateFormat(formatDDMMYYYYhhmma).format(tempDate);
  //   return returnDate;
  // }

  // 03 Nov 2022
  String getDateWithMonthNameYear(String? date) {
    //CustomLogger.logPrint('parsed date ${date}');
    if (date == null ||
        date.isEmpty ||
        date == '' ||
        date == 'null' ||
        date == '-') {
      return AppStrings().dash;
    }
    // Convert String to date from incoming format "2020-06-12 00:00:00.0"
    DateTime? tempDate = DateTime.tryParse(date)?.toLocal();
    // Convert date to string in given format
    if (tempDate != null) {
      String returnDate = DateFormat(formatddMMMyyyy).format(tempDate);
      return returnDate;
    } else {
      return AppStrings().dash;
    }
  }

  // 03 Nov 2022 02:03 PM
  String getDateWithMonthYearAndTimeWithAMPM(String? date) {
    if (date == null ||
        date.isEmpty ||
        date == '' ||
        date == 'null' ||
        date == '-') {
      return AppStrings().dash;
    }
    // Convert String to date from incoming format "2020-06-12 00:00:00.0"
    DateTime? tempDate = DateTime.tryParse(date)?.toLocal();
    // Convert date to string in given format
    if (tempDate != null) {
      String returnDate = DateFormat(formatddMMMyyyyhhmma).format(tempDate);
      return returnDate;
    } else {
      return AppStrings().dash;
    }
  }

  String getOnlyMonth(String? date) {
    if (date == null ||
        date.isEmpty ||
        date == '' ||
        date == 'null' ||
        date == '-') {
      return AppStrings().dash;
    }
    // Convert String to date from incoming format "2020-06-12 00:00:00.0"
    DateTime? tempDate = DateTime.tryParse(date)?.toLocal();
    // Convert date to string in given format
    if (tempDate != null) {
      String returnMonth = DateFormat(formatMonth).format(tempDate);
      return returnMonth;
    } else {
      return AppStrings().dash;
    }
  }

  String getOnlyTimeWithAMPM(String? date) {
    if (date == null ||
        date.isEmpty ||
        date == '' ||
        date == 'null' ||
        date == '-') {
      return AppStrings().dash;
    }
    // Convert String to date from incoming format "2020-06-12 00:00:00.0"
    DateTime? tempDate = DateTime.tryParse(date)?.toLocal();
    // Convert date to string in given format
    if (tempDate != null) {
      String returnDate = DateFormat(formathhmma).format(tempDate);
      return returnDate;
    } else {
      return AppStrings().dash;
    }
  }

  bool isDifferenceLessThanFourteenYears(DateTime? date) {
    if (date == null) {
      return false;
    }
    final now = DateTime.now();
    final difference = now.difference(date);
    final years = difference.inDays ~/ 365;
    return years < 14;
  }
}
