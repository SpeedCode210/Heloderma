import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:heloderma/styles.dart' as Styles;
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _homePageState();
}

class _homePageState extends State<HomePage> {
  String username = 'Karim';
  late DateTime now;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
	        crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello $username', style: Styles.H1),
                  Text(DateFormat('EEEE, MMMM dd').format(now)),
                ],
              ),
            ),
            Image(image: AssetImage('assets/heloderma.png'), width: 80),
          ],
        ),
      ],
    );
  }
}
