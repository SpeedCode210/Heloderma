import 'package:flutter/material.dart';
import 'package:heloderma/colors.dart' as HelodermaColors;
import 'package:heloderma/styles.dart' as Styles;

import '../icons.dart';

class Appointment {
  DateTime date;
  String time;
  String doctor;
  String place;
  Appointment({
    required this.date,
    required this.time,
    required this.doctor,
    required this.place,
  });
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime _selected = DateTime.now();
  final List<Appointment> _appointments = [
    Appointment(
      date: DateTime(2026, 11, 24),
      time: '9:00 AM',
      doctor: 'Dr Meziane · Endocrinology',
      place: 'Private practice, Sétif',
    ),
    Appointment(
      date: DateTime(2026, 12, 12),
      time: '10:30 AM',
      doctor: 'Dr Benali · Cardiology',
      place: 'El Azhar Clinic, Algiers',
    ),
  ];

  int get _daysInMonth => DateTime(_month.year, _month.month + 1, 0).day;
  int get _emptyCells => DateTime(_month.year, _month.month, 1).weekday % 7;

  List<Appointment> get _upcoming {
    final today = DateUtils.dateOnly(DateTime.now());
    final list = _appointments.where((a) => !a.date.isBefore(today)).toList();
    list.sort((a, b) => a.date.compareTo(b.date));
    return list.take(2).toList();
  }

  bool _hasAppointment(DateTime d) =>
      _appointments.any((a) => DateUtils.isSameDay(a.date, d));

  void _changeMonth(int delta) {
    setState(() {
      _month = DateTime(_month.year, _month.month + delta);
    });
  }

  void _selectDay(DateTime date) {
    setState(() {
      _selected = date;
    });
  }

  void _addAppointment() {
    setState(() {});
  }

  Widget _dayCell(int day) {
    if (day < 1 || day > _daysInMonth) return SizedBox(height: 44);
    final date = DateTime(_month.year, _month.month, day);

    Color? bg;
    if (DateUtils.isSameDay(date, DateTime.now())) {
      bg = HelodermaColors.darkBlue;
    }
    if (_hasAppointment(date)) bg = HelodermaColors.darkPink;

    return GestureDetector(
      onTap: () => _selectDay(date),
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: DateUtils.isSameDay(date, _selected)
              ? Border.all(color: HelodermaColors.darkBlue, width: 2)
              : null,
        ),
        child: Text(
          '$day',
          style: TextStyle(
            fontSize: 16,
            color: bg == null ? HelodermaColors.darkBlue : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _weekdays() {
    final letters = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Row(
      children: [
        for (final l in letters)
          Expanded(
            child: Center(
              child: Text(l, style: TextStyle(color: Colors.grey[600])),
            ),
          ),
      ],
    );
  }

  Widget _grid() {
    final rows = ((_emptyCells + _daysInMonth) / 7).ceil();
    return Column(
      children: [
        for (int week = 0; week < rows; week++)
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Row(
              children: [
                for (int col = 0; col < 7; col++)
                  Expanded(
                    child: Center(
                      child: _dayCell(week * 7 + col - _emptyCells + 1),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _appointmentRow(Appointment a, bool filled) {
    final month = _months[a.date.month - 1].substring(0, 3);
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: filled ? HelodermaColors.darkPink : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[300]!),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$month ${a.date.day} · ${a.time}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: HelodermaColors.darkBlue,
                ),
              ),
              Text(a.doctor, style: TextStyle(color: HelodermaColors.darkBlue)),
              Text(
                a.place,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final upcoming = _upcoming;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Calendar', style: Styles.H1),
            Row(
              children: [
                Text(
                  '${_months[_month.month - 1]} ${_month.year}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Spacer(),
                IconButton(
                  icon: svgIcon('assets/ui/chevron-left.svg', size: 16),
                  onPressed: () => _changeMonth(-1),
                ),
                IconButton(
                  icon: svgIcon('assets/ui/chevron-right.svg', size: 12),
                  onPressed: () => _changeMonth(1),
                ),
              ],
            ),
            _weekdays(),
            _grid(),
            SizedBox(height: 24),
            Text(
              'Upcoming',
              style: Styles.H3.copyWith(color: HelodermaColors.darkBlue),
            ),
            SizedBox(height: 12),
            for (int i = 0; i < upcoming.length; i++)
              _appointmentRow(upcoming[i], i == 0),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _addAppointment,
                icon: svgIcon('assets/ui/plus-white.svg', size: 11),
                label: Text('Add appointment'),
                style: Styles.blueButtonStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
