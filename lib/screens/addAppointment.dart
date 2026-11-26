
import 'package:flutter/material.dart';
import 'package:heloderma/colors.dart' as HelodermaColors;
import 'package:heloderma/styles.dart' as Styles;
import 'package:heloderma/widgets/textfield.dart';

import '../icons.dart';

class AddAppointmentScreen extends StatefulWidget {
  const AddAppointmentScreen({super.key});

  @override
  State<AddAppointmentScreen> createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointmentScreen> {
  final TextEditingController _doctorController = TextEditingController(text: 'Dr Benali');
  final TextEditingController _placeController = TextEditingController(text: 'El Azhar Clinic, Algiers');
  final TextEditingController _conditionController =TextEditingController(text: 'Hypertension');
  DateTime _selectedDate = DateTime(2026, 11, 12);
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 30);

  bool _remind24Hours = true;
  bool _remind1Hour = true;

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  Widget _dateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Text(
            'Date',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        TextFormField(
          key: ValueKey(_selectedDate),
          initialValue: _formatDate(_selectedDate),
          readOnly: true,
          onTap: _pickDate,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }

  Widget _timeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Text(
            'Time',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        TextFormField(
          key: ValueKey(_selectedTime),
          initialValue: _formatTime(_selectedTime),
          readOnly: true,
          onTap: _pickTime,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }

  Widget _reminderRow({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: HelodermaColors.darkBlue,
                fontSize: 14,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            thumbColor: const WidgetStatePropertyAll(Colors.white),
            trackColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
                  ? HelodermaColors.blue
                  : Colors.grey.shade300,
            ),
            trackOutlineColor:
                const WidgetStatePropertyAll(Colors.transparent),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _doctorController.dispose();
    _placeController.dispose();
    _conditionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: svgIcon(
                      'assets/ui/chevron-left.svg',
                      size: 16,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 16),
                  Text('Add appointment', style: Styles.H1),
                ],
              ),

              Expanded(
                child: ListView(
                  children: [
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          helodermaTextField(
                            title: 'Doctor',
                            controller: _doctorController,
                          ),
                          const SizedBox(height: 16),

                          helodermaTextField(
                            title: 'Place',
                            controller: _placeController,
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Expanded(child: _dateField()),
                              const SizedBox(width: 10),
                              Expanded(child: _timeField()),
                            ],
                          ),
                          const SizedBox(height: 16),

                          helodermaTextField(
                            title: 'Condition',
                            controller: _conditionController,
                          ),
                          const SizedBox(height: 8),

                          _reminderRow(
                            label: 'Remind me 24 hours before',
                            value: _remind24Hours,
                            onChanged: (value) {
                              setState(() {
                                _remind24Hours = value;
                              });
                            },
                          ),

                          _reminderRow(
                            label: 'Remind me 1 hour before',
                            value: _remind1Hour,
                            onChanged: (value) {
                              setState(() {
                                _remind1Hour = value;
                              });
                            },
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
                child: const Text(
                  'Save appointment',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
