
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heloderma/colors.dart' as HelodermaColors;
import 'package:heloderma/screens/share_summary.dart';
import 'package:heloderma/styles.dart' as Styles;
import '../icons.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  static const List<Map<String, String>> _folders = [
    {
      'name': 'Hypertension',
      'subtitle': '4 visits · 9 documents',
    },
    {
      'name': 'Type 2 diabetes',
      'subtitle': '6 visits · 14 documents',
    },
  ];

  static const int _treatmentCount = 3;
  final List<bool> _folderChecked = List.filled(_folders.length, true);
  bool _treatmentsChecked = false;
  bool get _hasSelection => _folderChecked.contains(true) || _treatmentsChecked;

  void _generate() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ShareSummaryScreen(),
      ),
    );
  }

  Widget _checkbox(bool checked) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: checked ? HelodermaColors.darkBlue : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          width: 2,
          color: HelodermaColors.darkBlue,
        ),
      ),
      child: checked ? svgIcon('assets/ui/check-white.svg', size: 12) : null,
    );
  }

  Widget _checkRow({required String title, required String subtitle, required bool checked, required VoidCallback onTap,}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            _checkbox(checked),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Styles.H3.copyWith(
                    color: HelodermaColors.darkBlue,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: svgIcon(
                    'assets/ui/chevron-left.svg',
                    size: 16,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Text(
                'Summary for your doctor',
                style: Styles.H1,
              ),
              Text(
                'One PDF, readable anywhere',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/ui/summary-illustration.svg',
                          width: 150,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Include',
                        style: Styles.H3.copyWith(
                          color: HelodermaColors.darkBlue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      for (int i = 0; i < _folders.length; i++)
                        _checkRow(
                          title: _folders[i]['name']!,
                          subtitle: _folders[i]['subtitle']!,
                          checked: _folderChecked[i],
                          onTap: () {
                            setState(() {
                              _folderChecked[i] = !_folderChecked[i];
                            });
                          },
                        ),
                      _checkRow(
                        title: 'Current treatments',
                        subtitle: '$_treatmentCount medications',
                        checked: _treatmentsChecked,
                        onTap: () {
                          setState(() {
                            _treatmentsChecked =
                                !_treatmentsChecked;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Opacity(
                opacity: _hasSelection ? 1 : 0.4,
                child: ElevatedButton(
                  style: Styles.blueButtonStyle,
                  onPressed: _hasSelection ? _generate : null,
                  child: const Text(
                    'Generate PDF',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Nothing is sent until you share it.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
