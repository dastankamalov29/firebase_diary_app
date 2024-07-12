import 'package:firebasecrudtute/design/demension.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
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
              'Снижение стресса и улучшение ментального здоровья',
              style: textStyle1
            ),
          ),
          LottieBuilder.network(
              'https://lottie.host/c2bdacff-d36c-46c9-9bfd-6ba984b8c7b8/W2a7Bkks71.json'),
        ],
      ),
    );
  }
}