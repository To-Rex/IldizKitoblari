import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/pages/auth/register_page.dart';
import 'package:ildiz/pages/auth/reset_password.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../companents/appbar_sheets.dart';
import '../../companents/text_fild_auth.dart';
import '../../companents/text_fild_auth_phone.dart';
import '../../companents/text_fild_hints.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GetController _getController = Get.put(GetController());


  final mackFormater = MaskTextInputFormatter(
      mask: '+998 (##) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
            height: _getController.height.value,
            width: _getController.width.value,
            child: Obx(() => Stack(
              fit: StackFit.loose,
              children: [
                Positioned(
                    height: _getController.height.value * 0.2, top: 0, left: 0, right: 0,
                    child: SizedBox(child: SvgPicture.asset('assets/svgImages/shap.svg', fit: BoxFit.fitWidth, height: _getController.height.value * 0.2),)),
                Positioned(
                    height: _getController.height.value * 0.06,
                    width: _getController.width.value * 0.45,
                    top: _getController.height.value * 0.07,
                    left: _getController.width.value * 0.03,
                    child: SizedBox(child: SvgPicture.asset('assets/svgImages/keps.svg', fit: BoxFit.fitWidth, height: _getController.height.value * 0.2),)),
                Positioned(
                    width: _getController.width.value,
                    top: _getController.height.value * 0.14,
                    bottom: 0,
                    child: Container(
                        width: _getController.width.value,
                        decoration: BoxDecoration(
                          //color: Theme.of(context).colorScheme.onBackground,
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          children: [
                            AppBarSheets(
                              title: 'Kirish'.tr,
                            ),
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
                            SizedBox(height: _getController.height.value * 0.006),
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
                                    _getController.check.value =
                                    !_getController.check.value;
                                  },
                                  child: Text('Eslab qolish'.tr,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontSize: _getController.width.value * 0.04,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    _getController.fullCheck.value = false;
                                    _getController.passwordCheck.value = false;
                                    Get.to(ResetPasswordPage());
                                  },
                                  child: Text('Parolni unutdingizmi?'.tr,
                                    style: TextStyle(
                                      color: AppColors.red,
                                      fontSize: _getController.width.value * 0.04,
                                    ),
                                  ),
                                ),
                                SizedBox(width: _getController.width.value * 0.035),
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                                width: _getController.width.value * 0.95,
                                height: _getController.height.value * 0.06,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_getController.phoneController.text.isEmpty) {
                                        ApiController().showToast(context, 'Xatolik', 'Telefon raqamni kiriting!', true,2);
                                        return;
                                      }
                                      if (_getController.passwordController.text.isEmpty) {
                                        ApiController().showToast(context, 'Xatolik', 'Parolni kiriting!', true,2);
                                        return;
                                      }
                                      if (_getController.passwordController.text.length < 6) {
                                        ApiController().showToast(context, 'Xatolik', 'Parol kamida 6 ta belgidan iborat bo\'lishi kerak!', true,2);
                                        return;
                                      }
                                      ApiController().login();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                    child: Text('Kirish'.tr,
                                        style: TextStyle(
                                          fontSize: _getController.width.value * 0.04,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold
                                        )))),
                            SizedBox(height: _getController.height.value * 0.03),
                            Row(
                              children: [
                                const Spacer(),
                                Text(
                                  'Ro\'yxatdan o\'tganmisiz?'.tr,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: _getController.width.value * 0.04
                                  )
                                ),
                                SizedBox(width: _getController.height.value * 0.01),
                                InkWell(
                                  onTap: () {
                                    Get.off(RegisterPage());
                                  },
                                  child: Text(
                                    'Ro\'yxatdan o\'tish'.tr,
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: _getController.width.value * 0.04,
                                      fontWeight: FontWeight.bold,
                                    )
                                  ),
                                ),
                                const Spacer()
                              ],
                            ),
                            SizedBox(height: _getController.height.value * 0.075),
                          ],
                        )
                    )
                )
              ]
            ))
        ),
      )
    );
  }
}