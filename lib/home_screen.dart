import 'package:flutter/material.dart';
import 'package:make_me_rich/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: const [
          Icon(
            Icons.ssid_chart_sharp,
            size: 192,
            color: Colors.green,
            shadows: [
              Shadow(blurRadius: 1, color: Colors.black, offset: Offset(2, 3))
            ],
          ),
          Text(
              'Please watch some ads and spend a couple minutes using this application so I can become a '
              'millionaire much quicker. Thank you ;)\n\nTo track your progress please log in at the Home screen.',
              style: Styles.p),
        ],
      ),
    );
  }
}
