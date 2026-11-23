import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:heloderma/styles.dart' as Styles;
import 'package:heloderma/colors.dart' as HelodermaColors;
import 'package:dotted_border/dotted_border.dart';
import 'package:heloderma/screens/folder_screen.dart';

class FoldersPage extends StatefulWidget {
  const FoldersPage({super.key});

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class FolderInfo {
  String name;
  DateTime startTime;
  int visits;
  int documents;
  int treatments;
  String iconName;

  FolderInfo({
    required this.name,
    required this.startTime,
    required this.visits,
    required this.documents,
    required this.treatments,
    required this.iconName,
  });
}

class _FoldersPageState extends State<FoldersPage> {
  final List<FolderInfo> _folders = [
    FolderInfo(
      name: 'Hypertension',
      startTime: DateTime(2019),
      visits: 4,
      documents: 9,
      treatments: 1,
      iconName: 'heart',
    ),
    FolderInfo(
      name: 'Type 2 diabetes',
      startTime: DateTime(2021),
      visits: 6,
      documents: 14,
      treatments: 2,
      iconName: 'droplet',
    ),
  ];

  Widget _folderWidget(FolderInfo info, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                border: Border(
                  top: BorderSide(width: 1, color: Colors.grey[300]!),
                  right: BorderSide(width: 1, color: Colors.grey[300]!),
                  left: BorderSide(width: 1, color: Colors.grey[300]!),
                ),
              ),
              child: SizedBox(height: 16, width: 128),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FolderScreen()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              border: Border.all(width: 1, color: Colors.grey[300]!),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: HelodermaColors.bgPink,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.medication_liquid_sharp,
                            color: HelodermaColors.darkPink,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(info.name, style: Styles.H2),
                          Text(
                            'Followed since ${DateFormat("yyyy").format(info.startTime)}',
                            style: TextStyle(color: Colors.grey[600]!),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  DottedBorder(
                    options: CustomPathDottedBorderOptions(
                      customPath: (size) {
                        return Path()
                          ..moveTo(0, 0)
                          ..lineTo(size.width, 0);
                      },
                      color: Colors.grey[300]!,
                      strokeWidth: 1,
                      dashPattern: const [6, 3],
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        spacing: 16,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '12',
                                style: Styles.H2,
                                textAlign: TextAlign.start,
                              ),
                              Text('visits'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '12',
                                style: Styles.H2,
                                textAlign: TextAlign.start,
                              ),
                              Text('documents'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '12',
                                style: Styles.H2,
                                textAlign: TextAlign.start,
                              ),
                              Text('treatments'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 12),
      ],
    );
  }

  Widget _newFolderButton({required VoidCallback onTap}) {
    const double radius = 12;
    const double tabWidth = 128;
    const double tabHeight = 16;

    const bodyBorderRadius = BorderRadius.only(
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DottedBorder(
          options: CustomPathDottedBorderOptions(
            customPath: (size) {
              return Path()
                ..moveTo(0, size.height)
                ..lineTo(0, radius)
                ..quadraticBezierTo(0, 0, radius, 0)
                ..lineTo(size.width - radius, 0)
                ..quadraticBezierTo(size.width, 0, size.width, radius)
                ..lineTo(size.width, size.height);
            },
            color: Colors.grey[300]!,
            strokeWidth: 1,
            dashPattern: const [4, 4],
          ),
          child: const SizedBox(height: tabHeight, width: tabWidth),
        ),

        DottedBorder(
          options: CustomPathDottedBorderOptions(
            customPath: (size) {
              return Path()
                ..moveTo(0, 0)
                ..lineTo(size.width - radius, 0)
                ..quadraticBezierTo(size.width, 0, size.width, radius)
                ..lineTo(size.width, size.height - radius)
                ..quadraticBezierTo(
                  size.width,
                  size.height,
                  size.width - radius,
                  size.height,
                )
                ..lineTo(radius, size.height)
                ..quadraticBezierTo(0, size.height, 0, size.height - radius)
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
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.grey[600], size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'New folder',
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Folders', style: Styles.H1, textAlign: TextAlign.start),
            Text('One folder per condition', textAlign: TextAlign.start),
            SizedBox(height: 24),
            for (var folder in _folders) _folderWidget(folder, context),

            _newFolderButton(onTap: () {}),
          ],
        ),
      ),
    );
  }
}
