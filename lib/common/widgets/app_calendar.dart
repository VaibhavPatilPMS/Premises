import 'package:flutter/material.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:premises/common/widgets/tab_indicator_styler/src/indicators/material_indicator.dart';

class AppCalendar {
  dynamic appCalendar(
      {required int type,
      required BuildContext context,
      DateTime? startDate,
      DateTime? startInitialDate,
      DateTime? endInitialDate,
      bool? isAfterValidTimeRequired,
      bool? isBeforeValidTimeRequired,
      int? validHours,
      String? errorMessages,
      DateTime? endDate}) {
    switch (type) {
      case CalendarType.DATE_PICKER:
        return showDateTime(
            context,
            OmniDateTimePickerType.date,
            startDate,
            startInitialDate,
            endDate,
            isAfterValidTimeRequired ?? false,
            isBeforeValidTimeRequired ?? false);

      case CalendarType.DATE_TIME_PICKER:
        return showDateTime(
            context,
            OmniDateTimePickerType.dateAndTime,
            startDate,
            startInitialDate,
            endDate,
            isAfterValidTimeRequired ?? false,
            isBeforeValidTimeRequired ?? false);

      case CalendarType.DATE_TIME_PICKER_EVENT_COMPLETE:
        return showDateTimeEventComplete(
            context,
            OmniDateTimePickerType.dateAndTime,
            startDate,
            startInitialDate,
            endDate,
            isAfterValidTimeRequired ?? false);

      case CalendarType.DATE_RANGE_PICKER:
        return showDateTimeRange(
            context,
            OmniDateTimePickerType.date,
            startDate,
            endDate,
            isAfterValidTimeRequired ?? false,
            validHours ?? 24,
            errorMessages);

      case CalendarType.DATE_TIME_RANGE_PICKER:
        return showDateTimeRange(
            context,
            OmniDateTimePickerType.dateAndTime,
            startDate,
            endDate,
            isAfterValidTimeRequired ?? false,
            validHours ?? 24,
            errorMessages);

      case CalendarType.BIRTH_DATE_PICKER:
        return showBirthDateTime(
          context,
          OmniDateTimePickerType.date,
          startDate,
          endDate,
          startInitialDate,
        );
      case CalendarType.MOBILE_DASHBOARD_DATE_RANGE_PICKER:
        return showMobile_Dashboard_DateTimeRange(
            context,
            OmniDateTimePickerType.date,
            startDate,
            endDate,
            isAfterValidTimeRequired ?? false,
            validHours ?? 24,
            errorMessages);
      case CalendarType.DATE_TIME_PICKER_TASK_MODULE:
        return showDateTimeTaskModule(
            context,
            OmniDateTimePickerType.dateAndTime,
            startDate,
            endDate,
            isAfterValidTimeRequired ?? false);
      case CalendarType.DATE_TIME_PICKER_EVENT_MODULE:
        return showDateTimeRangeForEventDate(
            context,
            OmniDateTimePickerType.dateAndTime,
            startDate,
            endDate,
            isAfterValidTimeRequired ?? false,
            validHours ?? 24,
            startInitialDate,
            endInitialDate,
            errorMessages);
    }
    return showOmniDateTimePicker(context: context);
  }

  dynamic showBirthDateTime(
    BuildContext context,
    OmniDateTimePickerType omniDateTimePickerType,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? startInitialDate,
  ) async {
    DateTime? dateTimeList = await showOmniDateTimePicker(
        type: omniDateTimePickerType,
        context: context,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: AppColors.color_primary,
          ),
          unselectedWidgetColor: AppColors.text_grey,
          tabBarTheme: TabBarThemeData(
            indicatorColor: AppColors.color_primary,
            labelColor: AppColors.color_secondary,
            dividerColor: Colors.transparent,
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontFamily: FontFamily.fontFamily,
                //letterSpacing: AppSizes().letterSpacing,
                fontSize: TextSize().small),
            unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                fontFamily: FontFamily.fontFamily,
                //letterSpacing: AppSizes().letterSpacing,
                fontSize: TextSize().small),
            indicator: MaterialIndicator(
              height: AppSizes().tabBarHeight,
              topLeftRadius: AppSizes().tabBarRadius,
              topRightRadius: AppSizes().tabBarRadius,
              bottomLeftRadius: AppSizes().tabBarRadius,
              bottomRightRadius: AppSizes().tabBarRadius,
              horizontalPadding: MarginPadding().xlarge,
              color: AppColors.color_primary,
              tabPosition: TabPosition.bottom,
            ),
          ),
          fontFamily: FontFamily.fontFamily,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.text_grey, // button text color
            ),
          ),
          bottomAppBarTheme: const BottomAppBarThemeData(
            color: Colors.white,
          ),
        ),
        borderRadius:
            BorderRadius.all(Radius.circular(AppSizes().dropDownCornerRadius)),
        initialDate: startInitialDate ??
            DateTime.now().subtract(const Duration(days: 22995)),
        firstDate:
            startDate ?? DateTime.now().subtract(const Duration(days: 22995)),
        lastDate: endDate ?? DateTime.now().add(const Duration(days: 3652)));

    if (dateTimeList != null) {
      if (_calculateAge(dateTimeList) >= 18 &&
          _calculateAge(dateTimeList) < 60) {
        return dateTimeList;
      } else {
        "Age should be in between 18 and 60."
            .showAsToast(context: context, type: ToastType.TOAST_ERROR);
      }
    } else {
      return dateTimeList;
    }
  }

  dynamic showDateTime(
      BuildContext context,
      OmniDateTimePickerType omniDateTimePickerType,
      DateTime? startDate,
      DateTime? startInitialData,
      DateTime? endDate,
      bool? validateTimeAfter,
      bool? validateTimeBefore) async {
    DateTime? dateTimeList = await showOmniDateTimePicker(
        type: omniDateTimePickerType,
        context: context,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: AppColors.color_primary,
          ),
          unselectedWidgetColor: AppColors.text_grey,
          tabBarTheme: TabBarThemeData(
            indicatorColor: AppColors.color_primary,
            labelColor: AppColors.color_secondary,
            dividerColor: Colors.transparent,
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontFamily: FontFamily.fontFamily,
                //letterSpacing: AppSizes().letterSpacing,
                fontSize: TextSize().small),
            unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                fontFamily: FontFamily.fontFamily,
                //letterSpacing: AppSizes().letterSpacing,
                fontSize: TextSize().small),
            indicator: MaterialIndicator(
              height: AppSizes().tabBarHeight,
              topLeftRadius: AppSizes().tabBarRadius,
              topRightRadius: AppSizes().tabBarRadius,
              bottomLeftRadius: AppSizes().tabBarRadius,
              bottomRightRadius: AppSizes().tabBarRadius,
              horizontalPadding: MarginPadding().xlarge,
              color: AppColors.color_primary,
              tabPosition: TabPosition.bottom,
            ),
          ),
          fontFamily: FontFamily.fontFamily,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.text_grey, // button text color
            ),
          ),
          bottomAppBarTheme: const BottomAppBarThemeData(
            color: Colors.white,
          ),
        ),
        initialDate: startInitialData ?? DateTime.now(),
        borderRadius:
            BorderRadius.all(Radius.circular(AppSizes().dropDownCornerRadius)),
        firstDate:
            startDate ?? DateTime.now().subtract(const Duration(days: 22995)),
        lastDate: endDate ?? DateTime.now().add(const Duration(days: 3652)));

    if (dateTimeList != null && validateTimeAfter!) {
      if (dateTimeList.isAfter(DateTime.now()) ||
          dateTimeList.isAtSameMomentAs(DateTime.now())) {
        return dateTimeList;
      } else {
        "The selected time must be in the future"
            .showAsToast(context: context, type: ToastType.TOAST_ERROR);
      }
    } else if (dateTimeList != null && validateTimeBefore!) {
      if (dateTimeList.compareTo(DateTime.now()) < 0) {
        return dateTimeList;
      } else {
        "The selected date and time cannot be of future"
            .showAsToast(context: context, type: ToastType.TOAST_ERROR);
      }
    } else {
      return dateTimeList;
    }
  }

  dynamic showDateTimeEventComplete(
      BuildContext context,
      OmniDateTimePickerType omniDateTimePickerType,
      DateTime? startDate,
      DateTime? startInitialData,
      DateTime? endDate,
      bool? validateTime) async {
    DateTime? dateTimeList = await showOmniDateTimePicker(
        type: omniDateTimePickerType,
        context: context,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: AppColors.color_primary,
          ),
          unselectedWidgetColor: AppColors.text_grey,
          tabBarTheme: TabBarThemeData(
            indicatorColor: AppColors.color_primary,
            labelColor: AppColors.color_secondary,
            dividerColor: Colors.transparent,
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontFamily: FontFamily.fontFamily,
                //letterSpacing: AppSizes().letterSpacing,
                fontSize: TextSize().small),
            unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                fontFamily: FontFamily.fontFamily,
                //letterSpacing: AppSizes().letterSpacing,
                fontSize: TextSize().small),
            indicator: MaterialIndicator(
              height: AppSizes().tabBarHeight,
              topLeftRadius: AppSizes().tabBarRadius,
              topRightRadius: AppSizes().tabBarRadius,
              bottomLeftRadius: AppSizes().tabBarRadius,
              bottomRightRadius: AppSizes().tabBarRadius,
              horizontalPadding: MarginPadding().xlarge,
              color: AppColors.color_primary,
              tabPosition: TabPosition.bottom,
            ),
          ),
          fontFamily: FontFamily.fontFamily,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.text_grey, // button text color
            ),
          ),
          bottomAppBarTheme: const BottomAppBarThemeData(
            color: Colors.white,
          ),
        ),
        initialDate: startInitialData ?? DateTime.now(),
        borderRadius:
            BorderRadius.all(Radius.circular(AppSizes().dropDownCornerRadius)),
        firstDate:
            startDate ?? DateTime.now().subtract(const Duration(days: 22995)),
        lastDate: endDate ?? DateTime.now().add(const Duration(days: 3652)));

    if (dateTimeList != null && validateTime!) {
      if (dateTimeList.isAfter(startDate!)) {
        return dateTimeList;
      } else {
        "The selected time must be in the future"
            .showAsToast(context: context, type: ToastType.TOAST_ERROR);
      }
    } else {
      return dateTimeList;
    }
  }

  dynamic showDateTimeRange(
    BuildContext context,
    OmniDateTimePickerType omniDateTimePickerType,
    DateTime? startDate,
    DateTime? endDate,
    bool? isValidTimeRequired,
    int? hoursToValidate,
    String? errorMessage,
  ) async {
    dynamic dateTimeList = await showOmniDateTimeRangePicker(
      context: context,
      type: omniDateTimePickerType,
      is24HourMode: false,
      isShowSeconds: false,
      theme: ThemeData(
        //primaryColor: AppColors.color_primary,
        colorScheme: const ColorScheme.light(
          primary: AppColors.color_primary,
        ),
        unselectedWidgetColor: AppColors.text_grey,
        tabBarTheme: TabBarThemeData(
          indicatorColor: AppColors.color_primary,
          labelColor: AppColors.color_secondary,
          dividerColor: Colors.transparent,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontFamily: FontFamily.fontFamily,
              //letterSpacing: AppSizes().letterSpacing,
              fontSize: TextSize().small),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
              fontFamily: FontFamily.fontFamily,
              //letterSpacing: AppSizes().letterSpacing,
              fontSize: TextSize().small),
          indicator: MaterialIndicator(
            height: AppSizes().tabBarHeight,
            topLeftRadius: AppSizes().tabBarRadius,
            topRightRadius: AppSizes().tabBarRadius,
            bottomLeftRadius: AppSizes().tabBarRadius,
            bottomRightRadius: AppSizes().tabBarRadius,
            horizontalPadding: MarginPadding().xlarge,
            color: AppColors.color_primary,
            tabPosition: TabPosition.bottom,
          ),
        ),
        fontFamily: FontFamily.fontFamily,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.text_grey, // button text color
          ),
        ),
        bottomAppBarTheme: const BottomAppBarThemeData(
          color: Colors.white,
        ),
      ),
      startInitialDate: startDate ?? DateTime.now(),
      startFirstDate: DateTime.now(),
      //startLastDate: DateTime.now(),
      endInitialDate: endDate ?? DateTime.now().add(const Duration(hours: 23)),
      endFirstDate: DateTime.now(),
      //endLastDate: DateTime.now().add(const Duration(hours: 24)),
      borderRadius:
          BorderRadius.all(Radius.circular(AppSizes().dropDownCornerRadius)),
    );
    return endDateValidator(dateTimeList, context, isValidTimeRequired,
        hoursToValidate, errorMessage);
  }

  endDateValidator(List<DateTime?>? dateTimeList, BuildContext context,
      bool? isValidTimeRequired, int? hoursToValidate, String? errorMessage) {
    if (dateTimeList != null) {
      if (!isValidTimeRequired!) {
        if (dateTimeList[1]!.isBefore(dateTimeList[0]!)) {
          AppStrings()
              .error_end_date_validation
              .showAsToast(context: context, type: ToastType.TOAST_ERROR);
        } else {
          return dateTimeList;
        }
      } else {
        if (dateTimeList[1]!.day == dateTimeList[0]!.day &&
            dateTimeList[1]!.month == dateTimeList[0]!.month &&
            dateTimeList[1]!.year == dateTimeList[0]!.year &&
            dateTimeList[1]!.hour == dateTimeList[0]!.hour &&
            dateTimeList[1]!.minute == dateTimeList[0]!.minute &&
            dateTimeList[1]!.second == dateTimeList[0]!.second) {
          AppStrings()
              .date_same_error
              .showAsToast(context: context, type: ToastType.TOAST_ERROR);
        } else if (dateTimeList[1]!.isBefore(dateTimeList[0]!)) {
          AppStrings()
              .error_end_date_validation
              .showAsToast(context: context, type: ToastType.TOAST_ERROR);
        } else {
          if (dateTimeList[1]!.difference(dateTimeList[0]!).inMinutes <=
              (hoursToValidate != null ? (hoursToValidate * 60) : 1440)) {
            return dateTimeList;
          } else {
            if (errorMessage != null) {
              errorMessage.showAsToast(
                  context: context, type: ToastType.TOAST_ERROR);
            } else {
              hoursToValidate == null
                  ? AppStrings().date_time_limit.showAsToast(
                      context: context, type: ToastType.TOAST_ERROR)
                  : 'You can select \'End Date/Time\' within $hoursToValidate hrs from \'Start Date/Time\''
                      .showAsToast(
                          context: context, type: ToastType.TOAST_ERROR);
            }
          }
        }
      }
    }
  }

  dynamic showMobile_Dashboard_DateTimeRange(
    BuildContext context,
    OmniDateTimePickerType omniDateTimePickerType,
    DateTime? startDate,
    DateTime? endDate,
    bool? isValidTimeRequired,
    int? hoursToValidate,
    String? errorMessage,
  ) async {
    dynamic dateTimeList = await showOmniDateTimeRangePicker(
      context: context,
      type: omniDateTimePickerType,
      is24HourMode: false,
      isShowSeconds: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColors.color_primary,
        ),
        unselectedWidgetColor: AppColors.text_grey,
        tabBarTheme: TabBarThemeData(
          indicatorColor: AppColors.color_primary,
          labelColor: AppColors.color_secondary,
          dividerColor: Colors.transparent,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontFamily: FontFamily.fontFamily,
              fontSize: TextSize().small),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
              fontFamily: FontFamily.fontFamily,
              fontSize: TextSize().small),
          indicator: MaterialIndicator(
            height: AppSizes().tabBarHeight,
            topLeftRadius: AppSizes().tabBarRadius,
            topRightRadius: AppSizes().tabBarRadius,
            bottomLeftRadius: AppSizes().tabBarRadius,
            bottomRightRadius: AppSizes().tabBarRadius,
            horizontalPadding: MarginPadding().xlarge,
            color: AppColors.color_primary,
            tabPosition: TabPosition.bottom,
          ),
        ),
        fontFamily: FontFamily.fontFamily,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.text_grey, // button text color
          ),
        ),
        bottomAppBarTheme: const BottomAppBarThemeData(
          color: Colors.white,
        ),
      ),
      startInitialDate: startDate ?? DateTime.now(),
      startFirstDate: DateTime.now().subtract(const Duration(days: 22995)),
      //calender show from year 1960 .(user can select date from 1960)

      startLastDate: DateTime.now(),
      //(user can select date till Todays Year )

      endInitialDate: endDate ?? DateTime.now(),
      endFirstDate: DateTime(1960),
      //calender show till year
      endLastDate: DateTime.now(),
      //(user can select date till Todays Year)

      borderRadius:
          BorderRadius.all(Radius.circular(AppSizes().dropDownCornerRadius)),
    );
    return endDateValidator(dateTimeList, context, isValidTimeRequired,
        hoursToValidate, errorMessage);
  }

  dynamic showDateTimeTaskModule(
      BuildContext context,
      OmniDateTimePickerType omniDateTimePickerType,
      DateTime? startDate,
      DateTime? endDate,
      bool? validateTime) async {
    DateTime? dateTimeList = await showOmniDateTimePicker(
        type: omniDateTimePickerType,
        context: context,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: AppColors.color_primary,
          ),
          unselectedWidgetColor: AppColors.text_grey,
          tabBarTheme: TabBarThemeData(
            indicatorColor: AppColors.color_primary,
            labelColor: AppColors.color_secondary,
            dividerColor: Colors.transparent,
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontFamily: FontFamily.fontFamily,
                //letterSpacing: AppSizes().letterSpacing,
                fontSize: TextSize().small),
            unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                fontFamily: FontFamily.fontFamily,
                //letterSpacing: AppSizes().letterSpacing,
                fontSize: TextSize().small),
            indicator: MaterialIndicator(
              height: AppSizes().tabBarHeight,
              topLeftRadius: AppSizes().tabBarRadius,
              topRightRadius: AppSizes().tabBarRadius,
              bottomLeftRadius: AppSizes().tabBarRadius,
              bottomRightRadius: AppSizes().tabBarRadius,
              horizontalPadding: MarginPadding().xlarge,
              color: AppColors.color_primary,
              tabPosition: TabPosition.bottom,
            ),
          ),
          fontFamily: FontFamily.fontFamily,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.text_grey, // button text color
            ),
          ),
          bottomAppBarTheme: const BottomAppBarThemeData(
            color: Colors.white,
          ),
        ),
        borderRadius:
            BorderRadius.all(Radius.circular(AppSizes().dropDownCornerRadius)),
        firstDate:
            startDate ?? DateTime.now().subtract(const Duration(days: 22995)),
        lastDate: endDate ?? DateTime.now().add(const Duration(days: 3652))
        // initialDate: startDate!.add(const Duration(hours: 1))
        );

    if (dateTimeList != null && validateTime!) {
      if (dateTimeList.isAfter(DateTime.now()) ||
          dateTimeList.isAtSameMomentAs(DateTime.now())) {
        return dateTimeList;
      } else {
        "Turn Around Time should be greater than current Time"
            .showAsToast(context: context, type: ToastType.TOAST_ERROR);
      }
    } else {
      return dateTimeList;
    }
  }

  _calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    //CustomLogger.logPrint('age ${age}');
    return age;
  }

  dynamic showDateTimeRangeForEventDate(
    BuildContext context,
    OmniDateTimePickerType omniDateTimePickerType,
    DateTime? startDate,
    DateTime? endDate,
    bool? isValidTimeRequired,
    int? hoursToValidate,
    DateTime? startInitialDateAndTime,
    DateTime? endInitialDateAndTime,
    String? errorMessage,
  ) async {
    dynamic dateTimeList = await showOmniDateTimeRangePicker(
      context: context,
      type: omniDateTimePickerType,
      is24HourMode: false,
      isShowSeconds: false,
      theme: ThemeData(
        //primaryColor: AppColors.color_primary,
        colorScheme: const ColorScheme.light(
          primary: AppColors.color_primary,
        ),
        unselectedWidgetColor: AppColors.text_grey,
        tabBarTheme: TabBarThemeData(
          indicatorColor: AppColors.color_primary,
          labelColor: AppColors.color_secondary,
          dividerColor: Colors.transparent,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontFamily: FontFamily.fontFamily,
              //letterSpacing: AppSizes().letterSpacing,
              fontSize: TextSize().small),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
              fontFamily: FontFamily.fontFamily,
              //letterSpacing: AppSizes().letterSpacing,
              fontSize: TextSize().small),
          indicator: MaterialIndicator(
            height: AppSizes().tabBarHeight,
            topLeftRadius: AppSizes().tabBarRadius,
            topRightRadius: AppSizes().tabBarRadius,
            bottomLeftRadius: AppSizes().tabBarRadius,
            bottomRightRadius: AppSizes().tabBarRadius,
            horizontalPadding: MarginPadding().xlarge,
            color: AppColors.color_primary,
            tabPosition: TabPosition.bottom,
          ),
        ),
        fontFamily: FontFamily.fontFamily,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.text_grey, // button text color
          ),
        ),
        bottomAppBarTheme: const BottomAppBarThemeData(
          color: Colors.white,
        ),
      ),
      startInitialDate: startInitialDateAndTime ?? DateTime.now(),
      startFirstDate: startDate ?? DateTime.now(),
      startLastDate: startDate ?? DateTime.now(),
      endInitialDate: endInitialDateAndTime ??
          DateTime.now().add(const Duration(hours: 23)),
      endFirstDate: endDate,
      endLastDate: endDate,
      borderRadius:
          BorderRadius.all(Radius.circular(AppSizes().dropDownCornerRadius)),
    );
    return endDateValidator(dateTimeList, context, isValidTimeRequired,
        hoursToValidate, errorMessage);
  }
}
