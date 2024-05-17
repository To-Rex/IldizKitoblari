import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ildiz/pages/auth/login_page.dart';
import 'package:ildiz/pages/auth/register_page.dart';
import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final GetController _getController = Get.put(GetController());

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
              left: -w * 0.55,
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
              left: w * 0.78,
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
              right: w * 0.78,
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
              right: -w * 0.55,
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

          Positioned(
              bottom: _getController.height.value * 0.297,
              right: w * 0.3,
              left: w * 0.3,
              child: Center(
                child: Text('Sizni yuzlab jozibador hikoyalar kutmoqda'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: _getController.width.value * 0.07,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    )
                ),
              )
          ),
          Positioned(
            bottom: h * 0.255,
            right: w * 0.3,
            left: w * 0.3,
            child: Text('Sevimli janrlaringizni o‘rganing'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: _getController.width.value * 0.045,
                  color: AppColors.white.withOpacity(0.7),
                )
            ),
          ),
          Positioned(
            bottom: h * 0.22,
            right: w * 0.3,
            left: w * 0.3,
            child: Row(
              children: [
                const Spacer(),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(width: _getController.width.value * 0.01),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          //button
          Positioned(
              bottom: _getController.height.value * 0.125,
              height: _getController.height.value * 0.06,
              right: w * 0.15,
              left: w * 0.15,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(RegisterPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
                child: Text('Ro‘yxatdan o‘tish'.tr,
                    style: TextStyle(
                      fontSize: _getController.width.value * 0.04,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    )
                )
              )
          ),
          //row in Ro‘yxatdan o‘tganmisiz? Kirish
          Positioned(
              bottom: h * 0.055,
              right: w * 0.3,
              left: w * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ro‘yxatdan o‘tganmisiz?'.tr,
                      style: TextStyle(
                        fontSize: w * 0.17,
                        color: AppColors.white,
                      )
                  ),
                  TextButton(
                    onPressed: () {
                      //Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => RegisterPage()),);
                      Get.to(LoginPage());
                    },
                    child: Text('Kirish'.tr,
                        style: TextStyle(
                          fontSize: w * 0.17,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
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
      height: MediaQuery.of(context).size.height * 1.6,
      width: MediaQuery.of(context).size.width / 3.59,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation.value * height * 2.2  * (direction == 0 ? 1 : -1)),
            child: Container(
              width: MediaQuery.of(context).size.width / 3.9,
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.013),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.fitWidth
                  //fit: _animation.value < 0.5 ? BoxFit.scaleDown : BoxFit.scaleDown,
                )
              ),
              //child: Image.asset(imagePath, fit: BoxFit.fitWidth),
            )
          );
        }
      )
    );
  }
}
