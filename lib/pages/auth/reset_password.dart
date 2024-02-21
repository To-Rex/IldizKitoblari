import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/pages/auth/login_page.dart';
import 'package:ildiz/resource/colors.dart';
import '../../companents/appbar_sheets.dart';
import '../../companents/text_fild_auth.dart';
import '../../companents/text_fild_auth_phone.dart';
import '../../companents/text_fild_hints.dart';
import '../../controllers/get_controller.dart';

class ResetPasswordPage extends StatelessWidget {

  ResetPasswordPage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.codeController.clear();
    return Scaffold(
        body: SingleChildScrollView(
            child: SizedBox(
                height: _getController.height.value,
                width: _getController.width.value,
                child:  Obx(() => Stack(
                  alignment: Alignment.center,
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
                                  title: 'Parolni tiklash'.tr,
                                ),
                                TextFildHints(
                                  hintText: '${'Telefon raqam'.tr}:',
                                ),
                                TextFieldPhoneAuth(
                                  nameController: _getController.phoneController,
                                  next: TextInputAction.next,
                                  enabled: true,
                                ),
                                SizedBox(height: _getController.height.value * 0.02),
                                //SMS kod
                                if (_getController.fullCheck.value == false && _getController.passwordCheck.value == true)
                                TextFildHints(
                                  hintText: 'SMS kod'.tr,
                                ),
                                if (_getController.fullCheck.value == false && _getController.passwordCheck.value == true)
                                  Row(
                                  children: [
                                    const Spacer(),
                                    Container(
                                      width: _getController.width.value * 0.655,
                                      height: _getController.height.value * 0.056,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                                        ),
                                      ),
                                      child: Obx(() => TextField(
                                        controller: _getController.codeController,
                                        keyboardType: TextInputType.number,
                                        //next or done
                                        textInputAction: TextInputAction.done,
                                        obscureText: false,
                                        focusNode: FocusNode(),
                                        style: TextStyle(
                                          fontSize: _getController.width.value * 0.04,
                                          color: Theme.of(context).colorScheme.onSurface,
                                        ),
                                        decoration: InputDecoration(
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                          hintText: 'Kiriting'.tr,
                                          filled: true,
                                          isDense: true,
                                          fillColor: Theme.of(context).colorScheme.surface,
                                          hintStyle: TextStyle(
                                            fontSize: _getController.width.value * 0.04,
                                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none, // No border
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                      )),
                                    ),
                                    SizedBox(
                                      width: _getController.width.value * 0.03,
                                    ),
                                    Container(
                                      width: _getController.width.value * 0.235,
                                      height: _getController.height.value * 0.056,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${_getController.countdownDuration.value.inMinutes.toString().padLeft(2, '0')}:${(_getController.countdownDuration.value.inSeconds % 60).toString().padLeft(2, '0')}',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onSurface,
                                            fontSize: _getController.width.value * 0.04,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                if (_getController.fullCheck.value == true && _getController.passwordCheck.value == false)
                                TextFildHints(
                                  hintText: '${'Parolni kiriting'.tr}:',
                                ),
                                if (_getController.fullCheck.value == true && _getController.passwordCheck.value == false)
                                TextFildsAuth(
                                  nameController: _getController.passwordController,
                                  next: TextInputAction.next,
                                  inputType: TextInputType.visiblePassword,
                                ),
                                SizedBox(height: _getController.height.value * 0.02),
                                if (_getController.fullCheck.value == true && _getController.passwordCheck.value == false)
                                TextFildHints(
                                  hintText: '${'Parolni takrorlang'.tr}:',
                                ),
                                if (_getController.fullCheck.value == true && _getController.passwordCheck.value == false)
                                TextFildsAuth(
                                  nameController: _getController.repeatPasswordController,
                                  next: TextInputAction.done,
                                  inputType: TextInputType.visiblePassword,
                                ),
                                SizedBox(height: _getController.height.value * 0.02),
                                if (_getController.countdownDuration.value.inSeconds == 0)
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: _getController.width.value * 0.05,
                                      ),
                                      Text(
                                        '${'SMS xabar kelmadimi?'.tr}: ',
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontSize: _getController.width.value * 0.04,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _getController.resetTimer();
                                          ApiController().otp(_getController.phoneController.text, 1, true);
                                        },
                                        child: Text(
                                          'Qayta yuborish'.tr,
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: _getController.width.value * 0.04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                const Spacer(),
                                //const Expanded(child: SizedBox()),
                                SizedBox(
                                    width: _getController.width.value * 0.91,
                                    height: _getController.height.value * 0.061,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          //agar telefon raqam kiritilmagan bo'lsa
                                          if (_getController.phoneController.text.isEmpty) {
                                            ApiController().showToast(context, 'Xatolik', 'Telefon raqamni kiriting!', true,2);
                                            return;
                                          }
                                          //agar sms kod kiritilmagan bo'lsa
                                          if (_getController.codeController.text.isEmpty && _getController.fullCheck.value == false && _getController.passwordCheck.value == true) {
                                            ApiController().showToast(context, 'Xatolik', 'SMS kodni kiriting!', true,2);
                                            return;
                                          }
                                          //agar parol kiritilmagan bo'lsa
                                          if (_getController.passwordController.text.isEmpty && _getController.fullCheck.value == true && _getController.passwordCheck.value == false) {
                                            ApiController().showToast(context, 'Xatolik', 'Parolni kiriting!', true,2);
                                            return;
                                          }
                                          //agar parol takrorlanmagan bo'lsa
                                          if (_getController.repeatPasswordController.text.isEmpty && _getController.fullCheck.value == true && _getController.passwordCheck.value == false) {
                                            ApiController().showToast(context, 'Xatolik', 'Parolni takrorlang!', true,2);
                                            return;
                                          }
                                          //agar parol kamida 6 ta belgidan kam bo'lsa
                                          if (_getController.passwordController.text != _getController.repeatPasswordController.text && _getController.fullCheck.value == true && _getController.passwordCheck.value == false) {
                                            ApiController().showToast(context, 'Xatolik', 'Parollar mos kelmadi!', true,2);
                                            return;
                                          }
                                          print('fullCheck: ${_getController.fullCheck.value}, passwordCheck: ${_getController.passwordCheck.value}');

                                          //check phone number
                                          if (_getController.fullCheck.value == false && _getController.passwordCheck.value == false) {
                                            ApiController().check(1, true);
                                            return;
                                          }

                                          //check sms code
                                          if (_getController.fullCheck.value == false && _getController.passwordCheck.value == true) {
                                            //check sms code
                                            return;
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            )
                                        ),
                                        child: Text(
                                            //'Tasdiqlash'.tr,
                                            _getController.fullCheck.value == false && _getController.passwordCheck.value == false ? 'SMS kodni yuborish'.tr : _getController.fullCheck.value == false && _getController.passwordCheck.value == true ? 'Tasdiqlash'.tr : 'Kirish'.tr,
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
                ))
        )
    );
  }
}
