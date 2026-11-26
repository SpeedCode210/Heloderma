import 'package:flutter/material.dart';
import 'package:heloderma/styles.dart' as Styles;
import 'package:heloderma/widgets/textfield.dart';
import 'package:heloderma/colors.dart' as HelodermaColors;

import '../icons.dart';

class NewFolderScreen extends StatefulWidget {
  const NewFolderScreen({super.key});
  @override
  State<NewFolderScreen> createState() => _NewFolderState();
}

class _NewFolderState extends State<NewFolderScreen> {
  final _conditionNameController = TextEditingController();

  final List<String> _suggestions = [
    'Asthma',
    'Blood Pressure',
    'Allergies',
    'Thyroid',
    'Diabetes',
  ];

  int _selectedIcon = 0;

  final List<String> _icons = [
    'assets/conditions/bone.svg',
    'assets/conditions/brain.svg',
    'assets/conditions/eye.svg',
    'assets/conditions/tooth.svg',
    'assets/conditions/lungs-wind.svg',
    'assets/conditions/heart-pulse.svg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                Text('New Folder', style: Styles.H1),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Form(
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        helodermaTextField(
                          controller: _conditionNameController,
                          title: 'Condition name',
                          hintText: 'e.g. Asthma',
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Suggestions',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),

                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final suggestion in _suggestions)
                              OutlinedButton(
                                onPressed: () {
                                  _conditionNameController.text = suggestion;
                                },
                                child: Text(
                                  suggestion,
                                  style: TextStyle(
                                    color: HelodermaColors.darkBlue,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Icon',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),

                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (int i = 0; i < _icons.length; i++)
                              IconButton(
                                style: IconButton.styleFrom(
                                  backgroundColor: HelodermaColors.bgPink,
                                  side: BorderSide(
                                    color: _selectedIcon == i ? HelodermaColors
                                        .darkPink : Colors.transparent, 
                                    width: 2,
                                  ),
                                ),
                                icon: svgIcon(_icons[i], size: 28),
                                onPressed: () {
                                  setState(() {
                                    _selectedIcon = i;
                                  });
                                },
                              ),
                          ],
                        ),

                        helodermaTextField(
                          title: 'Followed since',
                          hintText: '2026',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: Styles.blueButtonStyle,
              child: Text(
                'Save Document',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
