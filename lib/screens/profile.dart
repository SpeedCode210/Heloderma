import 'package:flutter/material.dart';
import 'package:heloderma/styles.dart' as Styles;
import 'package:heloderma/colors.dart' as HelodermaColors;

import '../icons.dart';

import 'package:heloderma/screens/summary_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class ProfileInfo {
  String name;
  int age;
  String gender;
  int heightCm;
  int weightKg;
  String bloodType;
  String allergies;
  String emergencyContact;

  ProfileInfo({
    required this.name,
    required this.age,
    required this.gender,
    required this.heightCm,
    required this.weightKg,
    required this.bloodType,
    required this.allergies,
    required this.emergencyContact,
  });
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileInfo _profile = ProfileInfo(
    name: 'Karim',
    age: 34,
    gender: 'Male',
    heightCm: 178,
    weightKg: 76,
    bloodType: 'O+',
    allergies: 'Penicillin',
    emergencyContact: '+213 555 12 34 56',
  );

  Widget _identity() {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: HelodermaColors.bgPink,
          child: Text(
            _profile.name[0].toUpperCase(),
            style: const TextStyle(
              color: HelodermaColors.darkPink,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _profile.name,
              style: Styles.H2.copyWith(color: HelodermaColors.darkBlue),
            ),
            const SizedBox(height: 2),
            Text(
              '${_profile.age} years · ${_profile.gender}',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(
            value,
            style: const TextStyle(
              color: HelodermaColors.darkBlue,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTable() {
    final rows = <List<String>>[
      ['Height', '${_profile.heightCm} cm'],
      ['Weight', '${_profile.weightKg} kg'],
      ['Blood type', _profile.bloodType],
      ['Allergies', _profile.allergies],
      ['Emergency contact', _profile.emergencyContact],
    ];
    return Column(
      children: [
        for (final r in rows) _infoRow(r[0], r[1]),
        Divider(height: 1, thickness: 1, color: Colors.grey[300]),
      ],
    );
  }

  Widget _optionTile({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final radius = BorderRadius.circular(16);
    return Material(
      color: Colors.white,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: Colors.grey[300]!, width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: HelodermaColors.bgPink,
                  shape: BoxShape.circle,
                ),
                child: svgIcon(icon),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: HelodermaColors.darkBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
              svgIcon('assets/ui/chevron-right.svg', size: 12),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _identity(),
              const SizedBox(height: 24),
              _infoTable(),
              const SizedBox(height: 32),
              Text(
                'Options',
                style: Styles.H3.copyWith(
                  color: HelodermaColors.darkBlue,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              _optionTile(
                icon: 'assets/sharing/document.svg',
                title: 'Summary',
                subtitle: 'PDF to share with your doctor',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SummaryScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
