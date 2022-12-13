import 'package:am_ecommerce_app/models/introduction.dart';
import 'package:am_ecommerce_app/utility/app_properties.dart';
import 'package:am_ecommerce_app/utility/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  int currentPageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    storeIntroductionScreenData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future storeIntroductionScreenData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('introductionScreenData', true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
          ),
        ),
        child: Stack(
          children: [
            PageView.builder(
                controller: _pageController,
                onPageChanged: (value) => setState(() {
                      currentPageIndex = value;
                    }),
                itemCount: introductionContents.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Image.asset(
                          introductionContents[index].imagePath,
                          width: SizeConfig.screenWidth * .35,
                          height: SizeConfig.screenHeight * .35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          introductionContents[index].title,
                          style: titleStyle,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Text(
                          introductionContents[index].description,
                          style: descriptionStyle,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  );
                }),
            Positioned(
              bottom: 15,
              child: SizedBox(
                width: SizeConfig.screenWidth,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        introductionContents.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            width: 13,
                            height: 13,
                            padding: const EdgeInsets.all(1.5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentPageIndex == index
                                    ? primary
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Opacity(
                          opacity: currentPageIndex ==
                                  introductionContents.length - 1
                              ? 0.0
                              : 1.0,
                          child: MyOutlineButton(
                            name: 'Skip',
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                          ),
                        ),
                        currentPageIndex == introductionContents.length - 1
                            ? MyOutlineButton(
                                name: 'Finish',
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/home');
                                },
                              )
                            : MyOutlineButton(
                                name: 'Next',
                                onPressed: () {
                                  _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut);
                                },
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyOutlineButton extends StatelessWidget {
  String name;
  VoidCallback onPressed;
  MyOutlineButton({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(name),
      onTap: onPressed,
    );
  }
}
