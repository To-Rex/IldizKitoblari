import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../companents/text_fild_auth.dart';
import '../../companents/text_fild_hints.dart';
import '../../controllers/get_controller.dart';

class EditUser extends StatelessWidget {
  EditUser({super.key});
  final GetController _getController = Get.put(GetController());
  final ImagePicker _picker = ImagePicker();
  var croppedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      //_getController.changeImage(pickedFile.path);
      ApiController().editUser(pickedFile.path);
      //_cropImage(pickedFile.path);

    }
  }

  Future<void> _cropImage(String imagePath) async {
    croppedImage = await ImageCropper.platform.cropImage(
      sourcePath: imagePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
    );
    _getController.changeImage(croppedImage.path);
  }
  /*List<PopupMenuItem<int>> menuItems = [
    PopupMenuItem(
      value: 1,
      child: Row(
        children: [
          Icon(Icons.person, color: Theme.of(Get.context!).colorScheme.onBackground, size: _getController.width.value * 0.06),
          SizedBox(width: _getController.width.value * 0.02),
          Text('Shaxsiy ma\'lumotlar'.tr),
          SizedBox(width: _getController.width.value * 0.02),
        ]
      )
    ),
    PopupMenuItem(
      value: 2,
      child: Text('Menu Item 2'),
    ),
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shaxsiy ma\'lumotlar'.tr),
        centerTitle: false,
        toolbarTextStyle: TextStyle(fontSize: _getController.width.value * 0.048, fontWeight: FontWeight.w600),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06), onPressed: () {Get.back();}),
        actions: [
          PopupMenuButton<int>(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Theme.of(context).colorScheme.background,
            surfaceTintColor: Colors.transparent,
            icon: Icon(Icons.more_vert, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
              itemBuilder: (context) => [
                PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.person, color: AppColors.primaryColor, size: _getController.width.value * 0.06),
                    SizedBox(width: _getController.width.value * 0.02),
                    Text('Shaxsiy ma\'lumotlar'.tr, style: TextStyle(color: AppColors.primaryColor, fontSize: _getController.width.value * 0.04)),
                    SizedBox(width: _getController.width.value * 0.02),
                  ]
                )
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart, color: AppColors.primaryColor, size: _getController.width.value * 0.06),
                    SizedBox(width: _getController.width.value * 0.02),
                    Text('Buyurtmalar'.tr, style: TextStyle(color: AppColors.primaryColor, fontSize: _getController.width.value * 0.04)),
                    SizedBox(width: _getController.width.value * 0.02),
                  ]
                )
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Icon(Icons.logout, color: AppColors.secondaryColor, size: _getController.width.value * 0.06),
                    SizedBox(width: _getController.width.value * 0.02),
                    Text('Chiqish'.tr, style: TextStyle(color: AppColors.secondaryColor, fontSize: _getController.width.value * 0.04)),
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
                /*Container(
                    padding: EdgeInsets.only(left: _getController.width.value * 0.05, top: _getController.width.value * 0.04, bottom: _getController.width.value * 0.04),
                    child: _getController.meModel.value.data!.result!.avatar == null
                        ? CircleAvatar(
                        radius: _getController.width.value * 0.12,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(_getController.meModel.value.data!.result!.fullName.toString().substring(0,1), style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: _getController.width.value * 0.06))
                    )
                        : CircleAvatar(
                        radius: _getController.width.value * 0.12,
                        backgroundImage: NetworkImage(_getController.meModel.value.data!.result!.avatar.toString())
                    )
                ),*/
                //stack edit photo iconbutton
                Container(
                  padding: EdgeInsets.only(left: _getController.width.value * 0.05, top: _getController.width.value * 0.04, bottom: _getController.width.value * 0.04),
                  child: Stack(
                    children: [
                      _getController.meModel.value.data!.result!.avatar == null
                          ? CircleAvatar(
                          radius: _getController.width.value * 0.12,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Text(_getController.meModel.value.data!.result!.fullName.toString().substring(0,1), style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: _getController.width.value * 0.06))
                          )
                          : CircleAvatar(
                          radius: _getController.width.value * 0.12,
                          backgroundImage: NetworkImage(_getController.meModel.value.data!.result!.avatar.toString())
                          ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: _getController.width.value * 0.08,
                            height: _getController.width.value * 0.08,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(_getController.width.value * 0.06)
                            ),
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.background, size: _getController.width.value * 0.06),
                              //onPressed: () => _pickImage(ImageSource.gallery),
                              onPressed: () => {_pickImage(ImageSource.gallery)},
                              padding: EdgeInsets.all(0),
                              constraints: BoxConstraints(),
                              iconSize: _getController.width.value * 0.06,
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
                          Text(_getController.meModel.value.data!.result!.fullName.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.045, fontWeight: FontWeight.w600)),
                          SizedBox(height: _getController.height.value * 0.004),
                          Text('ID ${_getController.meModel.value.data!.result!.sId.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: _getController.width.value * 0.04))
                        ]
                    )
                )
              ],
            ),
            SizedBox(height: _getController.height.value * 0.01),
            if (_getController.meModel.value.data!.result!.phone != null && _getController.editCheck == false)
              Container(
                padding: EdgeInsets.only(left: _getController.width.value * 0.05),
                child: Text('${'Telefon raqam'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.045, fontWeight: FontWeight.w600)),
              )
            else
              Container(
                padding: EdgeInsets.only(left: _getController.width.value * 0.05),
                child: Text('f.i.sh'.tr,
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.045, fontWeight: FontWeight.w600)),
              ),
            SizedBox(height: _getController.height.value * 0.01),
            if (_getController.meModel.value.data!.result!.phone != null && _getController.editCheck == false)
            Row(
                children: [
                  SizedBox(width: _getController.width.value * 0.05),
                  _getController.meModel.value.data!.result!.phone == null && _getController.editCheck == false ? Text('Telefon raqam'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: _getController.width.value * 0.04)) : Text(_getController.meModel.value.data!.result!.phone.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.04)),
                ]
            )
            else
              Center(
                child: TextFildsAuth(
                  nameController: _getController.fullNameController,
                  next: TextInputAction.next,
                  inputType: TextInputType.name
                )
              ),
            //SizedBox(height: _getController.height.value * 0.05),
            SizedBox(height: _getController.editCheck == false ? _getController.height.value * 0.05 : _getController.height.value * 0.02),
            Container(
                padding: EdgeInsets.only(left: _getController.width.value * 0.05, right: _getController.width.value * 0.05),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      minimumSize: Size(_getController.width.value * 0.9, _getController.height.value * 0.06)
                  ),
                  onPressed: () {
                    if (_getController.editCheck == false) {
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
                      if (_getController.editCheck == false)
                        Icon(Icons.edit, color: Theme.of(context).colorScheme.onPrimary, size: _getController.width.value * 0.05),
                      SizedBox(width: _getController.width.value * 0.02),
                      Text(_getController.editCheck == false ? 'Tahrirlash'.tr : 'Saqlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: _getController.width.value * 0.045, fontWeight: FontWeight.w600)),
                    ],
                  ),
                )
            )
          ],
        ))
    );
  }
}