import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:heloderma/styles.dart' as Styles;
import 'package:heloderma/colors.dart' as HelodermaColors;

import '../icons.dart';

class MedicationReminder {
  DateTime time;
  String name;
  String dose;
  bool taken;

  MedicationReminder({
    required this.time,
    required this.name,
    required this.dose,
    required this.taken,
  });
}

class Appointment {
  DateTime time;
  String name;
  String specialty;
  String location;

  Appointment({
    required this.time,
    required this.name,
    required this.specialty,
    required this.location,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _homePageState();
}

class _homePageState extends State<HomePage> {
  String username = 'Karim';
  late DateTime now;

  List<MedicationReminder> reminders = [
    MedicationReminder(
      time: DateTime(0, 1, 1, 8, 0),
      name: 'Metformin',
      dose: '850 mg',
      taken: true,
    ),
    MedicationReminder(
      time: DateTime(0, 1, 1, 13, 0),
      name: 'Amlodipine',
      dose: '5 mg',
      taken: false,
    ),
    MedicationReminder(
      time: DateTime(0, 1, 1, 20, 0),
      name: 'Metformin',
      dose: '850 mg',
      taken: false,
    ),
  ];

  List<Appointment> appointments = [
    Appointment(
      time: DateTime(2026, 11, 12, 10, 30),
      name: 'Dr Benali',
      specialty: 'Cardiology',
      location: 'El Azhar Clinic, Algiers',
    ),
  ];

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
  }

  Widget _reminderWidget(MedicationReminder reminder) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!, width: 2)),
      ),

      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(DateFormat('jm').format(reminder.time), style: Styles.H3),
          SizedBox(width: 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reminder.name, style: Styles.H3),
                Text(reminder.dose),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                width: 1,
                color: (reminder.taken
                    ? HelodermaColors.darkPink
                    : Colors.grey[300]!),
              ),
              color: reminder.taken ? HelodermaColors.darkPink : Colors.white,
            ),
            child: SizedBox(width: 24, height: 24),
          ),
        ],
      ),
    );
  }

  Widget _appointmentWidget(Appointment appointment) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: Colors.grey[300]!),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              SizedBox(width: 12),
              Column(
                children: [
                  Text(
                    DateFormat('d').format(appointment.time),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: HelodermaColors.darkBlue,
                    ),
                  ),
                  Text(DateFormat('MMM').format(appointment.time)),
                ],
              ),
              SizedBox(width: 28),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.name + ' - ' + appointment.specialty,
                      style: Styles.H3,
                    ),
                    Text(
                      DateFormat('jm').format(appointment.time) +
                          ' - ' +
                          appointment.location,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello $username', style: Styles.H1),
                      Text(DateFormat('EEEE, MMMM dd').format(now)),
                    ],
                  ),
                ),
                Image(image: AssetImage('assets/heloderma.png'), width: 80),
              ],
            ),
            SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1, color: Colors.grey[300]!),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Next Dose : 1:00 PM',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey[600]!),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: HelodermaColors.bgPink,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: svgIcon('assets/treatments/pill-red.svg'),
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          children: [
                            Text('Amlodipine', style: Styles.H2),
                            Text(
                              '5 mg - 1 Tablet',
                              style: TextStyle(color: Colors.grey[600]!),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    FilledButton(
                      child: Text('Mark as taken'),
                      onPressed: () {},
                      style: Styles.blueButtonStyle,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Today - ${1} of ${4}',
              style: Styles.H2,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8),
            for (int i = 0; i < reminders.length; i++)
              _reminderWidget(reminders[i]),
            SizedBox(height: 12),
            Text('Appointments', style: Styles.H2, textAlign: TextAlign.start),
            for (int i = 0; i < appointments.length; i++)
              _appointmentWidget(appointments[i]),
          ],
        ),
      ),
    );
  }
}
