import 'package:firebasecrudtute/design/demension.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              'Повышение продуктивности и концентрации',
              style: textStyle1
            ),
          ),
          LottieBuilder.network(
              'https://lottie.host/068d955f-9deb-482a-a932-23d51408b101/8BqWKyfdm0.json'),
        ],
      ),
    );
  }
}