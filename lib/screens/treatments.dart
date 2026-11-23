import 'package:flutter/material.dart';
import 'package:heloderma/colors.dart' as HelodermaColors;
import 'package:heloderma/styles.dart' as Styles;

class TreatmentsPage extends StatefulWidget {
  const TreatmentsPage({super.key});

  @override
  State<TreatmentsPage> createState() => _TreatmentsPageState();
}

class TreatmentInfo {
  String name;
  String details;
  List<String> days;

  TreatmentInfo({
    required this.name,
    required this.details,
    required this.days,
  });
}

class _TreatmentsPageState extends State<TreatmentsPage> {
  final List<TreatmentInfo> _hypertension = [
    TreatmentInfo(
      name: 'Amlodipine',
      details: '5 mg · once a day · 1:00 PM',
      days: ['taken', 'taken', 'taken', 'missed', 'taken', 'taken', 'pending'],
    ),
  ];

  final List<TreatmentInfo> _diabetes = [
    TreatmentInfo(
      name: 'Metformin',
      details: '850 mg · twice a day · 8 AM, 8 PM',
      days: ['taken', 'taken', 'taken', 'taken', 'taken', 'missed', 'pending'],
    ),
    TreatmentInfo(
      name: 'Atorvastatin',
      details: '20 mg · once a day · 10:00 PM',
      days: ['taken', 'taken', 'missed', 'taken', 'taken', 'taken', 'pending'],
    ),
  ];
  final List<String> _daysWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  String _nextStatus(String status) {
    if (status == 'taken') return 'missed';
    if (status == 'pending') return 'taken';
    return 'pending';
  }

  Widget _sectionTitle(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _dayCircle(String letter, String status, void Function() onTap) {
    Color bgColor = Colors.transparent;
    Color borderColor = Colors.grey[300]!;
    Color textColor = Colors.grey[400]!;

    if (status == 'taken') {
      bgColor = HelodermaColors.blue;
      borderColor = HelodermaColors.blue;
      textColor = Colors.white;
    } else if (status == 'missed') {
      borderColor = HelodermaColors.darkPink;
      textColor = HelodermaColors.darkPink;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: borderColor),
        ),
        child: Text(letter, style: TextStyle(color: textColor, fontSize: 12)),
      ),
    );
  }

  Widget _treatmentWidget(TreatmentInfo t, Color bg, Color iconColor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Icon(Icons.medication, color: iconColor),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.name, style: Styles.H2),
                Text(t.details, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 10),
                Row(
                  spacing: 10,
                  children: [
                    for (int i = 0; i < 7; i++)
                      _dayCircle(_daysWeek[i], t.days[i], () {
                        setState(() {
                          t.days[i] = _nextStatus(t.days[i]);
                        });
                      }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Treatments', style: Styles.H1),
          Text('Reminders by condition'),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _sectionTitle('Hypertension', HelodermaColors.darkPink),
                  for (var t in _hypertension)
                    _treatmentWidget(t,HelodermaColors.bgPink,HelodermaColors.darkPink,),
                  SizedBox(height: 16),
                  _sectionTitle('Type 2 diabetes', HelodermaColors.blue),
                  for (var t in _diabetes) ...[
                    Divider(color: Colors.grey[300]),
                    _treatmentWidget(t, HelodermaColors.bgBlue, HelodermaColors.blue),
                  ],
                ],
              ),
            ),
          ),

          SizedBox(height: 16),
          FilledButton(
            child: Text('+ Add Treatment'),
            onPressed: () {},
            style: Styles.blueButtonStyle,
          ),
        ],
      ),
    );
  }
}
