import 'package:flutter/material.dart';
import 'package:heloderma/styles.dart' as Styles;
import 'package:heloderma/colors.dart' as HelodermaColors;
import 'package:intl/intl.dart';

import '../icons.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({super.key});

  @override
  State<FolderScreen> createState() => _FolderScreenState();
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

class DocumentInfo {
  String name;
  DateTime dateTime;

  DocumentInfo({required this.name, required this.dateTime});
}

class VisitInfo {
  DateTime dateTime;
  String doctorName;
  String specialty;
  String comment;
  bool checked;
  VisitInfo({
    required this.dateTime,
    required this.doctorName,
    required this.specialty,
    required this.comment,
    required this.checked,
  });
}

class _FolderScreenState extends State<FolderScreen> {
  int _selectedTab = 0;

  final List<String> _labels = ['Visit', 'Document', 'Treatment'];

  final List<DocumentInfo> _documents = [
    DocumentInfo(name: "Blood Test", dateTime: DateTime(2026, 11, 02)),
    DocumentInfo(name: "Thyroid Assessment", dateTime: DateTime(2026, 11, 04)),
    DocumentInfo(
      name: "Blood Pressure Prescription",
      dateTime: DateTime(2026, 11, 10),
    ),
  ];

  final List<VisitInfo> _visits = [
    VisitInfo(
      dateTime: DateTime(2026, 7, 2),
      doctorName: 'Dr Meziane',
      specialty: 'Endocrinology',
      comment: 'HbA1c 6.9%. Treatment unchanged.',
      checked: true,
    ),
    VisitInfo(
      dateTime: DateTime(2026, 1, 14),
      doctorName: 'Dr Meziane',
      specialty: 'Endocrinology',
      comment: 'Annual check-up.',
      checked: false,
    ),
    VisitInfo(
      dateTime: DateTime(2025, 9, 9),
      doctorName: 'Dr Benali',
      specialty: 'General medicine',
      comment: 'Fatigue, tests prescribed.',
      checked: false,
    ),
    VisitInfo(
      dateTime: DateTime(2025, 3, 3),
      doctorName: 'Dr Meziane',
      specialty: 'Endocrinology',
      comment: 'Quarterly follow-up.',
      checked: false,
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
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 2)),
      ),
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: svgIcon(
                iconColor == HelodermaColors.blue
                    ? 'assets/treatments/pill-blue.svg'
                    : 'assets/treatments/pill-red.svg',
              ),
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

  Widget _documentWidget(DocumentInfo info) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 2)),
      ),
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: HelodermaColors.bgPink,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: svgIcon('assets/sharing/document.svg'),
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(info.name, style: Styles.H3),
              Text(DateFormat('dd MMM, yyyy').format(info.dateTime)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _visitWidget(VisitInfo info) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 2, color: Colors.grey[200]!)),
      ),
      padding: EdgeInsetsGeometry.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                width: 1,
                color: (info.checked
                    ? HelodermaColors.darkPink
                    : Colors.grey[300]!),
              ),
              color: info.checked ? HelodermaColors.darkPink : Colors.white,
            ),
            child: SizedBox(width: 24, height: 24),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('MMM dd, yyyy').format(info.dateTime),
                  style: Styles.H3,
                ),
                Text(
                  '${info.doctorName} - ${info.specialty}',
                  style: TextStyle(color: HelodermaColors.darkBlue),
                ),
                Text(info.comment),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getMainView() {
    if (_selectedTab == 0) {
      return ListView(
        children: [
          for (int i = 0; i < _visits.length; i++) _visitWidget(_visits[i]),
        ],
      );
    }
    if (_selectedTab == 1) {
      return ListView(
        children: [
          for (int i = 0; i < _documents.length; i++)
            _documentWidget(_documents[i]),
        ],
      );
    }
    if (_selectedTab == 2) {
      return ListView(
        children: [
          for (int i = 0; i < _diabetes.length; i++)
            _treatmentWidget(
              _diabetes[i],
              HelodermaColors.bgPink,
              HelodermaColors.darkPink,
            ),
        ],
      );
    }

    return Center(child: Text('Please select a tab'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: svgIcon('assets/ui/chevron-left.svg', size: 16),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 16),
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
                SizedBox(width: 16),
                Text('Type 2 diabetes', style: Styles.H1),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100]!,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                spacing: 12,
                children: [
                  for (int i = 0; i < _labels.length; i++)
                    i == _selectedTab
                        ? Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedTab = i;
                                });
                              },
                              style: Styles.whiteButtonStyle,
                              child: Text(
                                '${_labels[i]}s',
                                style: TextStyle(
                                  color: HelodermaColors.darkBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedTab = i;
                                });
                              },
                              style: Styles.transparentButtonStyle,
                              child: Text(
                                '${_labels[i]}s',
                                style: TextStyle(color: Colors.grey[800]!),
                              ),
                            ),
                          ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Expanded(child: _getMainView()),
            ElevatedButton(
              style: Styles.blueButtonStyle,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  svgIcon('assets/ui/plus-white.svg', size: 11),
                  Text(
                    ' Add ${_labels[_selectedTab]}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
