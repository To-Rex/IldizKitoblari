import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/pages/auth/login_page.dart';
import 'package:ildiz/resource/colors.dart';
import '../../companents/appbar_sheets.dart';
import '../../companents/text_fild_auth.dart';
import '../../companents/text_fild_hints.dart';
import '../../controllers/get_controller.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final GetController _getController = Get.put(GetController());
  //name controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
        height: _getController.height.value,
        width: _getController.width.value,
          child:  Obx(() => Stack(
      children: [
        Positioned(
            height: _getController.height.value * 0.15,
            top: 0,
            left: 0,
            right: 0,
            child:  SizedBox(
              child: SvgPicture.asset('assets/svgImages/shap.svg',
                  fit: BoxFit.fitWidth,
                  height: _getController.height.value * 0.15),
            )
        ),
        Positioned(
            height: _getController.height.value * 0.1,
            width: _getController.width.value * 0.45,
            top: _getController.height.value * 0.038,
            left: _getController.width.value * 0.03,
            child:  SizedBox(
              child: SvgPicture.asset(
                  'assets/svgImages/keps.svg',
                  fit: BoxFit.fitWidth,
                  height: _getController.height.value * 0.2),
            )
        ),

        Positioned(
            width: _getController.width.value,
            top: _getController.height.value * 0.13,
            bottom: 0,
            child:  Container(
                width: _getController.width.value,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    AppBarSheets(
                      title: 'Ro\'yxatdan o\'tish'.tr,
                    ),
                    TextFildHints(
                      hintText: 'f.i.sh'.tr,
                    ),
                    TextFildsAuth(
                      nameController: _nameController,
                      next: TextInputAction.next,
                      inputType: TextInputType.name,
                    ),
                    SizedBox(height: _getController.height.value * 0.02),
                    TextFildHints(
                      hintText: '${'Telefon raqam'.tr}:',
                    ),
                    TextFildsAuth(
                      nameController: _phoneController,
                      next: TextInputAction.next,
                      inputType: TextInputType.phone,
                    ),
                    SizedBox(height: _getController.height.value * 0.02),
                    TextFildHints(
                      hintText: '${'Parolni kiriting'.tr}:',
                    ),
                    TextFildsAuth(
                      nameController: _passwordController,
                      next: TextInputAction.next,
                      inputType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: _getController.height.value * 0.02),
                    TextFildHints(
                      hintText: '${'Parolni takrorlang'.tr}:',
                    ),
                    TextFildsAuth(
                      nameController: _repeatPasswordController,
                      next: TextInputAction.done,
                      inputType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: _getController.height.value * 0.005),
                    Row(
                      children: [
                        SizedBox(width: _getController.width.value * 0.035),
                        SizedBox(
                          width: _getController.width.value * 0.06,
                          child: Checkbox(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_getController.width.value * 0.015)),
                            activeColor: AppColors.primaryColor,
                            value: _getController.check.value,
                            onChanged: (bool? value) {
                              _getController.check.value = value!;
                            },
                          ),
                        ),
                        SizedBox(width: _getController.width.value * 0.01),
                        Text(
                            'Ommaviy oferta'.tr,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: _getController.width.value * 0.04,
                            )
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                                '${'shartlariga roziman'.tr}!',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: _getController.width.value * 0.04,
                                )
                            )
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                        width: _getController.width.value * 0.91,
                        height: _getController.height.value * 0.061,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )
                            ),
                            child: Text('Ro\'yxatdan o\'tish'.tr,
                                style: TextStyle(
                                  fontSize: _getController.width.value * 0.04,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                )
                            )
                        )
                    ),
                    SizedBox(height: _getController.height.value * 0.02),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          'Ro\'yxatdan o\'tganmisiz?'.tr,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: _getController.width.value * 0.04,
                          ),
                        ),
                        SizedBox(
                          width: _getController.height.value * 0.01,
                        ),
                        InkWell(
                          onTap: () {
                            Get.off(LoginPage());
                          },
                          child: Text(
                            'Kirish'.tr,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: _getController.width.value * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(height: _getController.height.value * 0.09),
                  ],
                )
            )
        ),
      ],
    ),
        ),
      )
      )
    );
  }
}
