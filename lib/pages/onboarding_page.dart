import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ildiz/pages/auth/login_page.dart';
import 'package:ildiz/pages/auth/register_page.dart';
import '../resource/colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 80), //// Animatsiya davri
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.repeat(reverse: true); // Animatsiyani davom ettirish
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var widgetList = [
    'assets/images/oo1.png',
    'assets/images/oo2.png',
    'assets/images/oo3.png',
    'assets/images/oo4.png',
  ];

  Widget _buildImage(String imagePath, int direction, double h) {
    return SizedBox(
      child: _buildAnimatedContainer(imagePath, direction, h),
    );
  }


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width / 4;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: -w * 0.2,
              top: 0,
              child: Column(
                children: [
                  _buildImage('assets/images/oo1.png', 0, -h),
                  _buildImage('assets/images/oo1.png', 0, -h),
                  _buildImage('assets/images/oo1.png', 0, -h),
                ],
              )
          ),
          Positioned(
              left: w * 0.9,
              bottom: 0,
              child: Column(
                children: [
                  _buildImage('assets/images/oo2.png', 1, -h),
                  _buildImage('assets/images/oo2.png', 1, -h),
                  _buildImage('assets/images/oo2.png', 1, -h),
                ],
              )
          ),
          Positioned(
              right: w * 0.9,
              top: 0,
              child: Column(
                children: [
                  _buildImage('assets/images/oo3.png', 0, -h),
                  _buildImage('assets/images/oo3.png', 0, -h),
                  _buildImage('assets/images/oo3.png', 0, -h),
                ],
              )
          ),
          Positioned(
              right: -w * 0.2,
              bottom: 0,
              child: Column(
                children: [
                  _buildImage('assets/images/oo4.png', 1, -h),
                  _buildImage('assets/images/oo4.png', 1, -h),
                  _buildImage('assets/images/oo4.png', 1, -h),
                ],
              )
          ),
          Positioned(
              child: Container(
                height: h,
                width: w * 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.black70.withOpacity(0.1),
                      AppColors.black70
                    ],
                  ),
                ),
              )
          ),

          //two circles in the middle
          //Text
          Positioned(
            bottom: h * 0.35,
              right: w * 0.3,
              left: w * 0.3,
              child: Center(
                child: Text('Sizni yuzlab jozibador hikoyalar kutmoqda'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: w * 0.31,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    )
                ),
              )
          ),
          Positioned(
            bottom: h * 0.31,
              right: w * 0.3,
              left: w * 0.3,
            child: Text('Sevimli janrlaringizni o\'rganing'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: w * 0.17,
                  color: AppColors.white.withOpacity(0.7),
                )
            ),
          ),
          //button
          Positioned(
            bottom: h * 0.15,
              right: w * 0.3,
              left: w * 0.3,
              child: ElevatedButton(
                onPressed: () {
                  //Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => RegisterPage()),);
                  Get.to(RegisterPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: h * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
                child: Text('Ro\'yxatdan o\'tish'.tr,
                    style: TextStyle(
                      fontSize: w * 0.17,
                      color: AppColors.white,
                    )
                )
              )
          ),
          //row in Ro‘yxatdan o‘tganmisiz? Kirish
          Positioned(
              bottom: h * 0.08,
              right: w * 0.3,
              left: w * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ro\'yxatdan o\'tganmisiz?'.tr,
                      style: TextStyle(
                        fontSize: w * 0.17,
                        color: AppColors.white,
                      )
                  ),
                  /*Text('Kirish'.tr,
                      style: TextStyle(
                        fontSize: w * 0.16,
                        color: AppColors.primaryColor,
                      )
                  ),*/
                  TextButton(
                    onPressed: () {
                      //Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => RegisterPage()),);
                      Get.to(LoginPage());
                    },
                    child: Text('Kirish'.tr,
                        style: TextStyle(
                          fontSize: w * 0.17,
                          color: AppColors.primaryColor,
                        )
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedContainer(String imagePath, int direction, double height) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 4.103,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation.value * height * 2  * (direction == 0 ? 1 : -1)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              //23% of the screen width
              width: MediaQuery.of(context).size.width * 0.23,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  //fit: BoxFit.scaleDown,
                  fit: _animation.value < 0.5 ? BoxFit.scaleDown : BoxFit.scaleDown,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
