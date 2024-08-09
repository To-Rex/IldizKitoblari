import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/companents/filds/text_small.dart';
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

  final mackFormater = MaskTextInputFormatter(mask: '+998 (##) ###-##-##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

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
                Positioned(height: _getController.height.value * 0.15, top: 0, left: 0, right: 0, child:  SizedBox(child: SvgPicture.asset('assets/svgImages/shap.svg', fit: BoxFit.fitWidth, height: Theme.of(context).iconTheme.fill))),
                Positioned(height: _getController.height.value * 0.1, width: _getController.width.value * 0.45, top: _getController.height.value * 0.038, left: _getController.width.value * 0.03, child:  SizedBox(child: SvgPicture.asset('assets/svgImages/keps.svg', fit: BoxFit.fitWidth, height: Theme.of(context).iconTheme.fill))),
                Positioned(
                    width: _getController.width.value,
                    top: _getController.height.value * 0.136,
                    bottom: 0,
                    child: Container(
                        width: _getController.width.value,
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
                        child: Column(
                          children: [
                            AppBarSheets(title: 'Kirish'),
                            TextFieldHints(hintText: '${'Telefon raqam'.tr}:'),
                            TextFieldPhoneAuth(nameController: _getController.phoneController, next: TextInputAction.next),
                            SizedBox(height: _getController.height.value * 0.02),
                            TextFieldHints(hintText: '${'Parolni kiriting'.tr}:'),
                            TextFieldsAuth(nameController: _getController.passwordController, next: TextInputAction.next, inputType: TextInputType.visiblePassword),
                            SizedBox(height: _getController.height.value * 0.01),
                            Row(
                              children: [
                                SizedBox(width: _getController.width.value * 0.035),
                                Checkbox(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                                    activeColor: AppColors.primaryColor,
                                    value: _getController.check.value,
                                    side: const BorderSide(color: AppColors.grey,style: BorderStyle.solid),
                                    onChanged: (bool? value) {_getController.check.value = value!;}
                                ),
                                InkWell(onTap: () {_getController.check.value = !_getController.check.value;}, child: TextSmall(text: 'Eslab qolish', color: Theme.of(context).colorScheme.onSurface)),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    _getController.fullCheck.value = false;
                                    _getController.passwordCheck.value = false;
                                    Get.to(ResetPasswordPage());
                                  },
                                  child: const TextSmall(text: 'Parolni unutdingizmi?', color: AppColors.red)
                                ),
                                SizedBox(width: _getController.width.value * 0.035)
                              ]
                            ),
                            const Spacer(),
                            SizedBox(
                                width: _getController.width.value * 0.95,
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
                                    style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: _getController.height.value * 0.018), backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                    child: TextSmall(text: 'Kirish'.tr, color: AppColors.white, fontWeight: FontWeight.bold)
                                )
                            ),
                            SizedBox(height: _getController.height.value * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextSmall(text: 'Ro‘yxatdan o‘tganmisiz?', color: Theme.of(context).colorScheme.onSurface),
                                SizedBox(width: _getController.height.value * 0.01),
                                InkWell(onTap: () {Get.off(RegisterPage());}, child: const TextSmall(text: 'Ro‘yxatdan o‘tish', color: AppColors.primaryColor, fontWeight: FontWeight.bold))
                              ]
                            ),
                            SizedBox(height: _getController.height.value * 0.08)
                          ]
                        )
                    )
                )
              ]
            ))
        )
      )
    );
  }
}