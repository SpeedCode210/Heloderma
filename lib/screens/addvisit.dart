import 'package:flutter/material.dart';
import 'package:heloderma/styles.dart' as Styles;
import 'package:heloderma/widgets/textfield.dart';
import 'package:dotted_border/dotted_border.dart';

import '../icons.dart';

class AddVisitScreen extends StatefulWidget {
  const AddVisitScreen({super.key});
  @override
  State<AddVisitScreen> createState() => _AddVisitState();
}

Widget _newFileButton({required VoidCallback onTap}) {
  const double radius = 12;
  const double tabWidth = 128;
  const double tabHeight = 16;

  const bodyBorderRadius = BorderRadius.all(Radius.circular(radius));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DottedBorder(
        options: CustomPathDottedBorderOptions(
          customPath: (size) {
            return Path()
              ..moveTo(radius, 0)
              ..lineTo(size.width - radius, 0)
              ..arcToPoint(
                Offset(size.width, radius),
                radius: Radius.circular(radius),
              )
              ..lineTo(size.width, size.height - radius)
              ..arcToPoint(
                Offset(size.width - radius, size.height),
                radius: Radius.circular(radius),
              )
              ..lineTo(radius, size.height)
              ..arcToPoint(
                Offset(0, size.height - radius),
                radius: Radius.circular(radius),
              )
              ..lineTo(0, radius)
              ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
              ..close();
          },
          color: Colors.grey[300]!,
          strokeWidth: 1,
          dashPattern: const [4, 4],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: bodyBorderRadius,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                svgIcon('assets/ui/plus-gray.svg', size: 12),
                const SizedBox(width: 8),
                Text(
                  'Scan or choose a file',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

class _AddVisitState extends State<AddVisitScreen> {
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
                Text('Add Visit', style: Styles.H1),
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
                        helodermaTextField(title: 'Doctor'),
                        Row(
                          spacing: 16,
                          children: [
                            Expanded(
                              child: helodermaTextField(title: 'Specialty'),
                            ),
                            Expanded(child: helodermaTextField(title: 'Date')),
                          ],
                        ),
                        helodermaTextField(title: 'Condition'),
                        helodermaTextField(
                          title: 'Notes',
                          hintText:
                              'Results, advice, changes to treatment...  ',
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Attach a document',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        _newFileButton(onTap: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: Styles.blueButtonStyle,
              child: Text('Save visit', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
