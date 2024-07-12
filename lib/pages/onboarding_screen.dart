import 'package:firebasecrudtute/design/demension.dart';
import 'package:firebasecrudtute/pages/home_page.dart';
import 'package:firebasecrudtute/pages/intro_screens/intro_page_1.dart';
import 'package:firebasecrudtute/pages/intro_screens/intro_page_2.dart';
import 'package:firebasecrudtute/pages/intro_screens/intro_page_3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            controller: _controller,
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          //dot indicator
          Container(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //Skip

                GestureDetector(
                  child: Text('Skip',style: textStyle1,),
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  // effect: SlideEffect(
                  //   activeDotColor: Colors.white,
                  //   dotHeight: 10,
                  //   dotWidth: 20,
                  //   dotColor: Colors.black,
                  // ),
                  effect: const ScrollingDotsEffect(
                    activeStrokeWidth: 2.6,
                    activeDotScale: .4,
                    radius: 8,
                    spacing: 6,
                    dotWidth: 24.0,
                    dotHeight: 16.0,
                    dotColor: Colors.blueGrey,
                    activeDotColor: Colors.amber,
                  ),
                ),

                //Next or done
                onLastPage
                    ? GestureDetector(
                        child: Text('Done',style: textStyle1,),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const HomePage();
                              },
                            ),
                          );
                        },
                      )
                    : GestureDetector(
                        child:  Text('Next',style: textStyle1,),
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(microseconds: 500),
                              curve: Curves.easeIn);
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
