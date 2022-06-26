import 'package:flutter/material.dart';
import 'package:custom_data_picker/class/custom_calendar_model.dart';
import 'package:custom_data_picker/custom_calendar_date_picker.dart';
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
            CustomCalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(DateTime.now().year - 1),
              lastDate: DateTime(DateTime.now().year + 1)
                  .subtract(const Duration(days: 1)),
              onDateChanged: (dateTime) {},
              customCalendarModel: CustomCalendarModel(
                convertMothName: _convertMothName,
                convertYear: _convertYear,
                convertDayLetter: _convertDayLetter,
                convertDaysInMonth: _convertDaysInMonth,
                getDayOffset: _getDayOffset,
                isSameDay: _isSameDay,
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
    JewishDate jewishDate = JewishDate()..setDate(dateTime);
    if (jewishDate.getJewishDayOfMonth() >= 17) {
      jewishDate.setJewishMonth(jewishDate.getJewishMonth() + 1);
    }
    return _hebrewDateFormatter.formatMonth(jewishDate);
  }

  int _convertYear(int year) {
    JewishDate jewishDate = JewishDate()..setGregorianYear(year);
    return jewishDate.getJewishYear();
  }

  String _convertDayLetter(int indexDay) {
    DateTime dateTime = DateTime.now();
    dateTime = dateTime.subtract(Duration(days: dateTime.weekday - indexDay));

    JewishDate jewishDate = JewishDate()..setDate(dateTime);

    return _hebrewDateFormatter.formatDayOfWeek(jewishDate);
  }

  int _convertDaysInMonth(DateTime dateTime) {
    JewishDate jewishDate = JewishDate()..setDate(dateTime);
    return jewishDate.getDaysInJewishMonth();
  }

  int _getDayOffset(DateTime dateTime) {
    JewishDate jewishDate = JewishDate()..setDate(dateTime);
    jewishDate.setJewishDayOfMonth(1);
    return jewishDate.getDayOfWeek() - 1;
  }
}
