
import 'package:flutter/material.dart';
import 'package:heloderma/colors.dart' as HelodermaColors;
import 'package:heloderma/styles.dart' as Styles;
import 'package:heloderma/widgets/textfield.dart';
import '../icons.dart';

class AddTreatmentScreen extends StatefulWidget {
  const AddTreatmentScreen({super.key});

  @override
  State<AddTreatmentScreen> createState() => _AddTreatmentState();
}

class _AddTreatmentState extends State<AddTreatmentScreen> {
  final TextEditingController _medicationController = TextEditingController(text: 'Metformin');
  final TextEditingController _doseController =TextEditingController(text: '850 mg');
  final TextEditingController _frequencyController = TextEditingController(text: 'Twice a day');
  final TextEditingController _conditionController = TextEditingController(text: 'Type 2 diabetes');

  DateTime _startDate = DateTime(2026, 11, 5);
  DateTime? _endDate;

  final List<String> _times = ['8:00 AM', '8:00 PM'];
  bool _remind = true;
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

  Future<void> _pickDate({required bool isStart}) async {
    final initialDate = isStart ? _startDate : (_endDate ?? DateTime.now());
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        if (isStart) {
          _startDate = date;
        } else {
          _endDate = date;
        }
      });
    }
  }

  Future<void> _addTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      final formattedTime = _formatTime(time);
      if (!_times.contains(formattedTime)) {
        setState(() {
          _times.add(formattedTime);
        });
      }
    }
  }

  Widget _timeChip(String label) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 14, right: 20),
      decoration: BoxDecoration(
        color: HelodermaColors.darkBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                _times.remove(label);
              });
            },
            child: svgIcon(
              'assets/ui/close-white.svg',
              size: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _addChip() {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: _addTime,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            svgIcon('assets/ui/plus-gray.svg', size: 10),
            const SizedBox(width: 6),
            Text(
              'Add',
              style: TextStyle(
                color: HelodermaColors.darkBlue,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateField({
    required String title,
    required DateTime? date,
    required VoidCallback onTap,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        TextFormField(
          key: ValueKey(date),
          initialValue: date == null ? '' : _formatDate(date),
          readOnly: true,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade500),
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

  Widget _reminderRow() {
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
              'Remind me at each time',
              style: TextStyle(
                color: HelodermaColors.darkBlue,
                fontSize: 14,
              ),
            ),
          ),
          Switch(
            value: _remind,
            onChanged: (value) {
              setState(() {
                _remind = value;
              });
            },
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
    _medicationController.dispose();
    _doseController.dispose();
    _frequencyController.dispose();
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
                  Text('Add treatment', style: Styles.H1),
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
                            title: 'Medication',
                            controller: _medicationController,
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Expanded(
                                child: helodermaTextField(
                                  title: 'Dose',
                                  controller: _doseController,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: helodermaTextField(
                                  title: 'Frequency',
                                  controller: _frequencyController,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  bottom: 8,
                                ),
                                child: Text(
                                  'Times',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                crossAxisAlignment:
                                    WrapCrossAlignment.center,
                                children: [
                                  for (final time in _times)
                                    _timeChip(time),
                                  _addChip(),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          helodermaTextField(
                            title: 'Condition',
                            controller: _conditionController,
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Expanded(
                                child: _dateField(
                                  title: 'Start',
                                  date: _startDate,
                                  onTap: () => _pickDate(isStart: true),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _dateField(
                                  title: 'End',
                                  date: _endDate,
                                  hintText: 'Ongoing',
                                  onTap: () => _pickDate(isStart: false),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _reminderRow(),
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
                  'Save treatment',
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
