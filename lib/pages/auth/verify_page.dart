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

class VerifyPage extends StatelessWidget {
  VerifyPage({Key? key}) : super(key: key);

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
                      hintText: '${'Telefon raqam'.tr}:',
                    ),
                    TextFieldPhoneAuth(
                      nameController: _phoneController,
                      next: TextInputAction.next,
                    ),
                    SizedBox(height: _getController.height.value * 0.02),
                    //SMS kod
                    TextFildHints(
                      hintText: 'SMS kod'.tr,
                    ),
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
                            controller: _nameController,
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
                              '01:59'.tr,
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
                    SizedBox(height: _getController.height.value * 0.02),
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
                            ApiController().otp(_phoneController.text, '1');
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
                    SizedBox(
                        width: _getController.width.value * 0.91,
                        height: _getController.height.value * 0.061,
                        child: ElevatedButton(
                            onPressed: () {
                              ApiController().check(_phoneController.text);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )
                            ),
                            child: Text('Tasdiqlash'.tr,
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
