/* ------------------------------------

  modificar archivo CalendarDatePicker
  313 title _DatePickerModeToggleButton //mes
  1007 daysInMonth //cantidad de dias en el mes //525 definir clase
  1004 weekday = localizations.narrowWeekdays[i] //letras del dia
  1227 year //año
  796 previousTooltipText
  798 nextTooltipText
  1035 firstDayOffset // para saber cual es el primer dia del mes
  1065 isToday // bool
  1056 widget.selectedDate // verificar el valor x default y tal vez cambiar

------------------------------------ */
class CustomCalendarModel {
  final String Function(DateTime)? _convertMothName;
  final String Function(int)? _convertDayLetter;
  final int Function(DateTime)? _convertDaysInMonth;
  final int Function(int)? _convertYear;
  final int Function(DateTime)? _getDayOffset;
  final bool Function(DateTime, DateTime)? _isSameDay;

  const CustomCalendarModel({
    final String Function(DateTime)? convertMothName,
    final String Function(int)? convertDayLetter,
    final int Function(DateTime)? convertDaysInMonth,
    final int Function(int)? convertYear,
    final int Function(DateTime)? getDayOffset,
    final bool Function(DateTime, DateTime)? isSameDay,
  })  : _convertMothName = convertMothName,
        _convertDayLetter = convertDayLetter,
        _convertDaysInMonth = convertDaysInMonth,
        _convertYear = convertYear,
        _getDayOffset = getDayOffset,
        _isSameDay = isSameDay;

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

  bool isSameDay(DateTime currentDate, DateTime dayToBuild, bool sameDay) {
    if (_isSameDay == null) {
      return sameDay;
    }
    return _isSameDay!(currentDate,dayToBuild);
  }
}
