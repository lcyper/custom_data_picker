import 'package:flutter/material.dart';
import 'package:custom_data_picker/class/custom_calendar_model.dart';
import 'package:custom_data_picker/custom_calendar_date_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kosher_dart/kosher_dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Data Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [
        Locale('en'),
        Locale('he'),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedDate = 'Select a date';
  final HebrewDateFormatter _hebrewDateFormatter = HebrewDateFormatter()
    ..hebrewFormat = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Picker'),
        elevation: 0,
      ),
      body: Center(
        child: ListView(
          children: [
            Text(_selectedDate),
            IconButton(
              onPressed: () async {
                DateTime? dateTime = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().year - 1),
                  lastDate: DateTime(DateTime.now().year + 1)
                      .subtract(const Duration(days: 1)),
                  locale: const Locale('he'),
                  textDirection: TextDirection.rtl,
                );
                if (dateTime == null) return;
                _selectedDate = dateTime.toString();

                // JewishDate jewishDate = JewishDate();
                // JewishCalendar jewishCalendar = JewishCalendar();
                // HebrewDateFormatter hebrewDateFormatter = HebrewDateFormatter();
                // // DateFormat("dd.MM.yyyy")
                // //     .format(jewishDate.getGregorianCalendar());

                // jewishDate.setDate(_dateTime);
                // jewishDate.getJewishDayOfMonth();
                // jewishDate.getGregorianCalendar();

                setState(() {});
              },
              icon: const Icon(Icons.calendar_today_rounded),
            ),
            // DatePickerDialog(
            //   initialDate: DateTime.now(),
            //   firstDate: DateTime(2021),
            //   lastDate: DateTime(2022), //DateTime
            // ),
            Directionality(
              // for hebrew calendar
              textDirection: TextDirection.rtl,
              child: CustomCalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 1),
                lastDate: DateTime(DateTime.now().year + 1)
                    .subtract(const Duration(days: 1)),
                onDateChanged: (dateTime) {
                  // TODO: continuar, hay q hacer q se seleccione la fecha correcta y luego convertirla
                  print('onDateChanged: $dateTime');
                },
                customCalendarModel: CustomCalendarModel(
                  mothName: _convertMothName,
                  year: _convertYear,
                  dayName: _convertDayName,
                  daysInMonth: _daysInMonth,
                  getDayOffset: _getDayOffset,
                  isSameDay: _isSameDay,
                  dayToString: _dayToString,
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){},
      //   tooltip: 'Select Date',
      //   child: const Icon(Icons.calendar),
      // ),
    );
  }

  bool _isSameDay(DateTime currentDate, DateTime dayToBuild) {
    JewishDate currentDateInJewishDate = JewishDate()..setDate(currentDate);
    JewishDate dayToBuildInCurrentJewishDate = JewishDate()
      ..setDate(dayToBuild);

    bool isTheSame = currentDateInJewishDate.getJewishYear() ==
            dayToBuildInCurrentJewishDate.getJewishYear() &&
        currentDateInJewishDate.getJewishMonth() ==
            dayToBuildInCurrentJewishDate.getJewishMonth() &&
        dayToBuild.day == currentDateInJewishDate.getJewishDayOfMonth();
    return isTheSame;
    int diference =
        currentDateInJewishDate.compareTo(dayToBuildInCurrentJewishDate);

    return diference == 0 ? true : false;

    // return
    //   currentDate.year == dayToBuild.year &&
    //   currentDate.month == dayToBuild.month &&
    //   currentDate.day == dayToBuild.day;
    return false;
  }

  String _convertMothName(DateTime dateTime) {
    // print('dateTime: $dateTime');
    //     String formatMonthYear(DateTime date) {
    //   final String year = formatYear(date);
    //   final String month = _months[date.month - DateTime.january];
    //   return '$month $year';
    // }
    final String year = _convertYear(dateTime.year);
    if (dateTime.day != 1) {
      dateTime = dateTime.subtract(Duration(days: dateTime.day - 1));
    }
    JewishDate jewishDate = JewishDate()..setDate(dateTime);

    // volver a revisar bien esto x q da error y a veces saltea meses
    if (jewishDate.getJewishDayOfMonth() >= 21) {
      // es menos de 12 meses o es año con dos adar
      if (jewishDate.getJewishMonth() < 12 ||
          (jewishDate.getJewishMonth() < 13 && jewishDate.isJewishLeapYear())) {
        jewishDate.setJewishMonth(jewishDate.getJewishMonth() + 1);
      } else {
        jewishDate.setJewishMonth(1);
      }
    }
    final String month = _hebrewDateFormatter.formatMonth(jewishDate);
    return '$month $year';
  }

  String _convertYear(int year) {
    JewishDate jewishDate = JewishDate()..setGregorianYear(year);
    _hebrewDateFormatter.useGershGershayim = true;
    return _hebrewDateFormatter.formatHebrewNumber(jewishDate.getJewishYear());
    //  ;
  }

  String _convertDayName(int indexDay) {
    const List<String> hebrewDaysOfWeek = [
      "ראשון",
      "שני",
      "שלישי",
      "רביעי",
      "חמישי",
      "שישי",
      "שבת"
    ];
    return hebrewDaysOfWeek[indexDay];
    _hebrewDateFormatter.useGershGershayim = true;
    return _hebrewDateFormatter.formatHebrewNumber(indexDay + 1);
  }

  int _daysInMonth(DateTime dateTime) {
    JewishDate jewishDate = JewishDate()..setDate(dateTime);
    return jewishDate.getDaysInJewishMonth();
  }

  int _getDayOffset(DateTime dateTime) {
    JewishDate jewishDate = JewishDate()..setDate(dateTime);
    jewishDate.setJewishDayOfMonth(1);
    return jewishDate.getDayOfWeek() - 1;
  }

  String _dayToString(int dayNumber) {
    _hebrewDateFormatter.useGershGershayim = false;
    return _hebrewDateFormatter.formatHebrewNumber(dayNumber);
  }
}
