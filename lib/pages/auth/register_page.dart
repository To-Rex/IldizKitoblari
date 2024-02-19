import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/pages/auth/login_page.dart';
import 'package:ildiz/pages/auth/verify_page.dart';
import 'package:ildiz/resource/colors.dart';
import '../../companents/appbar_sheets.dart';
import '../../companents/text_fild_auth.dart';
import '../../companents/text_fild_auth_phone.dart';
import '../../companents/text_fild_hints.dart';
import '../../controllers/get_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final GetController _getController = Get.put(GetController());

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
            top: 0, left: 0, right: 0,
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
                      nameController: _getController.fullNameController,
                      next: TextInputAction.next,
                      inputType: TextInputType.name,
                    ),
                    SizedBox(height: _getController.height.value * 0.02),
                    TextFildHints(
                      hintText: '${'Telefon raqam'.tr}:',
                    ),
                    TextFieldPhoneAuth(
                      nameController: _getController.phoneController,
                      next: TextInputAction.next,
                    ),
                    SizedBox(height: _getController.height.value * 0.02),
                    TextFildHints(
                      hintText: '${'Parolni kiriting'.tr}:',
                    ),
                    TextFildsAuth(
                      nameController: _getController.passwordController,
                      next: TextInputAction.next,
                      inputType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: _getController.height.value * 0.02),
                    TextFildHints(
                      hintText: '${'Parolni takrorlang'.tr}:',
                    ),
                    TextFildsAuth(
                      nameController: _getController.repeatPasswordController,
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
                        InkWell(
                            onTap: () {
                              _getController.check.value = !_getController.check.value;
                            },
                            child: Text(
                                'Ommaviy oferta'.tr,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: _getController.width.value * 0.035,
                                )
                            )
                        ),
                        Text(
                            ' ${'shartlariga roziman'.tr}!',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: _getController.width.value * 0.035,
                            )
                        )
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                        width: _getController.width.value * 0.91,
                        height: _getController.height.value * 0.061,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_getController.fullNameController.text.isEmpty) {
                                ApiController().showToast(context, 'Xatolik', 'f.i.sh kiriting!', true,2);
                                return;
                              }
                              if (_getController.phoneController.text.isEmpty) {
                                ApiController().showToast(context, 'Xatolik', 'Telefon raqamni kiriting!', true,2);
                                return;
                              }
                              if (_getController.passwordController.text.isEmpty) {
                                ApiController().showToast(context, 'Xatolik', 'Parolni kiriting!', true,2);
                                return;
                              }
                              if (_getController.repeatPasswordController.text.isEmpty) {
                                ApiController().showToast(context, 'Xatolik', 'Parolni takrorlang!', true,2);
                                return;
                              }
                              if (_getController.passwordController.text != _getController.repeatPasswordController.text) {
                                ApiController().showToast(context, 'Xatolik', 'Parollar mos kelmadi!', true,2);
                                return;
                              }
                              if (_getController.passwordController.text.length < 6) {
                                ApiController().showToast(context, 'Xatolik', 'Parol kamida 6 ta belgidan iborat bo\'lishi kerak!', true,2);
                                return;
                              }
                              if (!_getController.check.value) {
                                ApiController().showToast(context, 'Xatolik', 'Ommaviy oferta shartlariga rozilik bildirishingiz kerak!', true,2);
                                return;
                              }
                              print(_getController.phoneController.text.length);
                              if (_getController.phoneController.text.length < 19) {
                                ApiController().showToast(context, 'Xatolik', 'Telefon raqamni kiriting!', true,2);
                                return;
                              }
                              ApiController().check(1);

                              //ApiController().check(_phoneController.text);
                            },
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
                    SizedBox(height: _getController.height.value * 0.03),
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
                    SizedBox(height: _getController.height.value * 0.08),
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
