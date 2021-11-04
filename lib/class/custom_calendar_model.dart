/* ------------------------------------

  modificar archivo CalendarDatePicker
  313 title _DatePickerModeToggleButton //mes
  1007 daysInMonth //cantidad de dias en el mes //525 definir clase
  1004 weekday = localizations.narrowWeekdays[i] //letras del dia
  1227 year //año
  796 previousTooltipText
  798 nextTooltipText
  1035 firstDayOffset // para saber cual es el primer dia del mes

------------------------------------ */
class CustomCalendarModel {
  final Function(DateTime)? _convertMothName;
  final Function(int)? _convertDayLetter;
  final Function(DateTime)? _convertDaysInMonth;
  final Function(int)? _convertYear;
  final Function(DateTime)? _getDayOffset;

  const CustomCalendarModel({
    final String Function(DateTime)? convertMothName,
    final String Function(int)? convertDayLetter,
    final int Function(DateTime)? convertDaysInMonth,
    final int Function(int)? convertYear,
    final int Function(DateTime)? getDayOffset,
  })  : _convertMothName = convertMothName,
        _convertDayLetter = convertDayLetter,
        _convertDaysInMonth = convertDaysInMonth,
        _convertYear = convertYear,
        _getDayOffset = getDayOffset;

  String getMothName(DateTime dateTime, String monthName) {
    if (_convertMothName == null) {
      return monthName; //alternative value
    }
    return _convertMothName!(dateTime);
  }

  String getWeekDay(int indexDay, String letterDay) {
    if (_convertDayLetter == null) {
      return letterDay;
    }
    return _convertDayLetter!(indexDay);
  }

  int getDaysInMonth(DateTime dateTime, int daysInMonth) {
    if (_convertDaysInMonth == null) {
      return daysInMonth;
    }
    return _convertDaysInMonth!(dateTime);
  }

  int getYear(int year) {
    if (_convertYear == null) {
      return year;
    }
    return _convertYear!(year);
  }

  int getDayOffset(DateTime dateTime, int firstDayOffset) {
    if (_getDayOffset == null) {
      return firstDayOffset;
    }
    return _getDayOffset!(dateTime);
  }
}
