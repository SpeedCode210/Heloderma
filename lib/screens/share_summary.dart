import 'package:flutter/material.dart';
import 'package:heloderma/colors.dart' as HelodermaColors;
import 'package:heloderma/styles.dart' as Styles;

import '../icons.dart';

class ShareSummaryScreen extends StatelessWidget {
  const ShareSummaryScreen({super.key});

  static const String _fileName = 'heloderma-summary.pdf';

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Coming soon')),
    );
  }

  Widget _fileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: HelodermaColors.bgPink,
              shape: BoxShape.circle,
            ),
            child: svgIcon('assets/sharing/document.svg'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _fileName,
                  style: Styles.H3.copyWith(color: HelodermaColors.darkBlue),
                ),
                Text(
                  '2 pages · 184 KB',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _option({required String icon, required String title,required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[300]!, width: 1)),
        ),
        child: Row(
          children: [
            svgIcon(icon),
            const SizedBox(width: 16),
            Text(
              title,
              style: Styles.H3.copyWith(color: HelodermaColors.darkBlue),
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
              Row(
                children: [
                  IconButton(
                    icon: svgIcon('assets/ui/chevron-left.svg', size: 16),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 16),
                  Text('Share summary', style: Styles.H1),
                ],
              ),
              const SizedBox(height: 16),
              _fileCard(),
              const SizedBox(height: 8),
              _option(
                icon: 'assets/sharing/mail.svg',
                title: 'Email to my doctor',
                onTap: () => _showComingSoon(context),
              ),
              _option(
                icon: 'assets/sharing/whatsapp.svg',
                title: 'Send on WhatsApp',
                onTap: () => _showComingSoon(context),
              ),
              _option(
                icon: 'assets/sharing/phone.svg',
                title: 'Save on this phone',
                onTap: () => _showComingSoon(context),
              ),
              _option(
                icon: 'assets/sharing/share.svg',
                title: 'Other',
                onTap: () => _showComingSoon(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
