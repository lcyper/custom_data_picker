/* ------------------------------------

  modificar archivo CalendarDatePicker
  313 title _DatePickerModeToggleButton //mes
  956 daysInMonth
  1035 daysInMonth //cantidad de dias en el mes //525 definir clase
  1004 weekday = localizations.narrowWeekdays[i] //letras del dia
  1227 year //año
  804 previousTooltipText // mes anterior
  806 nextTooltipText // mes proximo
  1035 firstDayOffset // para saber cual es el primer dia del mes
  1058 isSelectedDay // saber cual es el dia seleccionado
  1060 isToday // circulo en el dia de hoy - initial date x default
  1083 day // day number
  1065 isToday // bool
  // TODO:
  1056 widget.selectedDate // verificar el valor x default y tal vez cambiar

------------------------------------ */

class CustomCalendarModel {
  // final TextDirection textDirection;
  final Function(DateTime)? _monthName;
  final Function(int)? _dayName;
  final Function(DateTime)? _daysInMonth;
  final Function(int)? _year;
  final Function(DateTime)? _getDayOffset;
  final Function(int)? _dayToString;
  final bool Function(DateTime, DateTime)? _isSameDay;

  // final DateTime Function(DateTime)? convertDateTime = constfyul (dateTime)=>dateTime;

  const CustomCalendarModel({
    // this.textDirection = TextDirection.ltr,
    final String Function(DateTime)? mothName,
    final String Function(int)? dayName,
    final int Function(DateTime)? daysInMonth,
    final String Function(int)? year,

    /// the day of the week for the first day of a month.
    final int Function(DateTime)? getDayOffset,
    final String Function(int)? dayToString,
    // this.convertDateTime= const (dateTime){return dateTime;},
    final bool Function(DateTime, DateTime)? isSameDay,
  })  : _monthName = mothName,
        _dayName = dayName,
        _daysInMonth = daysInMonth,
        _year = year,
        _getDayOffset = getDayOffset,
        _dayToString = dayToString,
        _isSameDay = isSameDay;

  String getMothName(DateTime dateTime, String monthName) {
    if (_monthName == null) {
      return monthName; //alternative value
    }
    return _monthName!(dateTime);
  }

  String getWeekDay(int indexDay, String letterDay) {
    if (_dayName == null) {
      return letterDay;
    }
    return _dayName!(indexDay);
  }

  int getDaysInMonth(DateTime dateTime, int daysInMonth) {
    if (_daysInMonth == null) {
      return daysInMonth;
    }
    return _daysInMonth!(dateTime);
  }

  String getYear(int year) {
    if (_year == null) {
      return '$year';
    }
    return _year!(year);
  }

  int getDayOffset(DateTime dateTime, int firstDayOffset) {
    if (_getDayOffset == null) {
      return firstDayOffset;
    }
    return _getDayOffset!(dateTime);
  }

  String dayToString(int day, String formatDecimal) {
    if (_dayToString == null) {
      return formatDecimal;
    }
    return _dayToString!(day);
  }

  bool isSameDay(DateTime currentDate, DateTime dayToBuild, bool sameDay) {
    if (_isSameDay == null) {
      return sameDay;
    }
    return _isSameDay!(currentDate, dayToBuild);
  }
}
