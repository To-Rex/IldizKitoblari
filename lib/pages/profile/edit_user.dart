import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ildiz/companents/filds/text_large.dart';
import 'package:ildiz/companents/filds/text_small.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:ildiz/resource/component_size.dart';
import 'package:image_picker/image_picker.dart';
import '../../companents/text_fild_auth.dart';
import '../../controllers/get_controller.dart';

class EditUser extends StatelessWidget {
  EditUser({super.key});
  final GetController _getController = Get.put(GetController());
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _getController.fullNameController.text = _getController.meModel.value.data!.result!.fullName.toString();
      ApiController().editUser(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextLarge(text: 'Shaxsiy ma‘lumotlar'),
        centerTitle: false,
        toolbarTextStyle: TextStyle(fontSize: _getController.width.value * 0.048, fontWeight: FontWeight.w600),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: ComponentSize.backIcons(context)), onPressed: () {Get.back();}),
        actions: [
          PopupMenuButton<int>(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Theme.of(context).colorScheme.surface,
            surfaceTintColor: Colors.transparent,
            icon: Icon(Icons.more_vert, color: Theme.of(context).colorScheme.onSurface, size: ComponentSize.backIcons(context)),
              itemBuilder: (context) => [
                PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.person, color: AppColors.primaryColor, size: ComponentSize.backIcons(context)),
                    SizedBox(width: _getController.width.value * 0.02),
                    const TextSmall(text: 'Shaxsiy ma‘lumotlar', color: AppColors.primaryColor),
                    SizedBox(width: _getController.width.value * 0.02)
                  ]
                )
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart, color: AppColors.primaryColor, size: ComponentSize.backIcons(context)),
                    SizedBox(width: _getController.width.value * 0.02),
                    const TextSmall(text: 'Buyurtmalar', color: AppColors.primaryColor),
                    SizedBox(width: _getController.width.value * 0.02)
                  ]
                )
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Icon(Icons.logout, color: AppColors.secondaryColor, size: ComponentSize.backIcons(context)),
                    SizedBox(width: _getController.width.value * 0.02),
                    const TextSmall(text: 'Ilovadan chiqish', color: AppColors.secondaryColor),
                    SizedBox(width: _getController.width.value * 0.02),
                  ]
                )
              )
            ],
          )
        ]
      ),
      body: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: _getController.width.value * 0.05, top: _getController.width.value * 0.04, bottom: _getController.width.value * 0.04),
                  child: Stack(
                    children: [
                      _getController.meModel.value.data!.result!.avatar == null
                          ? CircleAvatar(
                              radius: ComponentSize.starIcons(context) + ComponentSize.starIcons(context) /2,
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              child: TextLarge(text: _getController.meModel.value.data!.result!.fullName.toString().substring(0,1), color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w600))
                          : CircleAvatar(
                              radius: ComponentSize.starIcons(context) + ComponentSize.starIcons(context) / 2,
                              backgroundImage: NetworkImage(_getController.meModel.value.data!.result!.avatar.toString())
                          ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: ComponentSize.starIcons(context),
                            height: ComponentSize.starIcons(context),
                            decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(_getController.width.value * 0.06.r)),
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.surface, size: ComponentSize.backIcons(context)),
                              onPressed: () => {_pickImage(ImageSource.gallery)},
                              padding: const EdgeInsets.all(0),
                              constraints: const BoxConstraints(),
                              iconSize: _getController.width.value * 0.06
                            )
                          )
                        )
                    ]
                  )
                ),
                Padding(
                    padding: EdgeInsets.only(left: _getController.width.value * 0.05, top: _getController.width.value * 0.04, bottom: _getController.width.value * 0.04),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextLarge(text: _getController.meModel.value.data!.result!.fullName.toString(), color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600),
                          SizedBox(height: _getController.height.value * 0.004),
                          TextSmall(text: 'ID ${_getController.meModel.value.data!.result!.sId.toString()}', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))
                        ]
                    )
                )
              ],
            ),
            SizedBox(height: _getController.height.value * 0.01),
            if (_getController.meModel.value.data!.result!.phone != null && _getController.editCheck.isFalse)
              Container(
                padding: EdgeInsets.only(left: _getController.width.value * 0.05),
                child: TextLarge(text: '${'Telefon raqam'.tr}:', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)
              )
            else
              Container(
                padding: EdgeInsets.only(left: _getController.width.value * 0.05),
                child: TextLarge(text: 'f.i.sh'.tr, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)
              ),
            SizedBox(height: _getController.height.value * 0.01),
            if (_getController.meModel.value.data!.result!.phone != null && _getController.editCheck.isFalse)
            Row(
                children: [
                  SizedBox(width: _getController.width.value * 0.05),
                  _getController.meModel.value.data!.result!.phone == null && _getController.editCheck.isFalse ? TextSmall(text: 'Telefon raqam', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)) : TextSmall(text: _getController.meModel.value.data!.result!.phone.toString(), color: Theme.of(context).colorScheme.onSurface),
                ]
            )
            else
              Center(child: TextFieldsAuth(nameController: _getController.fullNameController, next: TextInputAction.next, inputType: TextInputType.name)),
            SizedBox(height: _getController.editCheck.isFalse ? _getController.height.value * 0.05 : _getController.height.value * 0.02),
            Container(
                padding: EdgeInsets.only(left: _getController.width.value * 0.05, right: _getController.width.value * 0.05),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: _getController.height.value * 0.018), backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
                    onPressed: () {
                    if (_getController.editCheck.isFalse) {
                      _getController.editCheck.value = true;
                      _getController.fullNameController.text = _getController.meModel.value.data!.result!.fullName.toString();
                    }else{
                      if (_getController.fullNameController.text == '') {
                        ApiController().showToast(context, 'Xatolik', 'f.i.sh kiriting!', true, 3);
                        return;
                      }
                      _getController.editCheck.value = false;
                      ApiController().editUser(_getController.image.value);
                    }
                  },
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_getController.editCheck.isFalse)
                            Icon(Icons.edit, color: Theme.of(context).colorScheme.onPrimary, size: ComponentSize.backIcons(context)),
                          SizedBox(width: _getController.width.value * 0.02),
                          TextSmall(text: _getController.editCheck.isFalse ? 'Tahrirlash'.tr : 'Saqlash'.tr, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w600)
                    ]
                  )
                )
            )
          ],
        ))
    );
  }
}