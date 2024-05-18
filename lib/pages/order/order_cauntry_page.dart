import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import '../../companents/orders/indicator_order.dart';
import '../../controllers/get_controller.dart';
import '../../models/orders/region_model.dart';
import '../../resource/colors.dart';

class OrderCountryPage extends StatelessWidget {
  OrderCountryPage({super.key});

  final GetController _getController = Get.put(GetController());


  @override
  Widget build(BuildContext context) {
    ApiController().getCountry();

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
        child: Obx(() => Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06), onPressed: () {Get.back();},),
              title: Text('Buyurtma'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
              centerTitle: false,
            ),
            const IndicatorOrder(index: 0),
            Container(
                width: Get.width,
                height: Get.height * 0.8,
                margin: EdgeInsets.only(top: 10.sp),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
                    boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 0))]
                ),
                padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: Get.width * 0.03),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Yetkazib berish manzili'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                      SizedBox(height: Get.height * 0.02),
                      Text('${'Davlat'.tr}: ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                      SizedBox(height: Get.height * 0.01),
                      if (_getController.getCountryModel.value.data != null && _getController.dropDownOrders[0] != null)
                        Container(
                            width: Get.width,
                            height: Get.height * 0.06,
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3))),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: DropdownButton<String>(
                                isExpanded: true,
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(10.r),
                                dropdownColor: Theme.of(context).colorScheme.background,
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 16.sp, fontWeight: FontWeight.w500),
                                value: _getController.getCountryModel.value.data?.result?[_getController.dropDownOrders[0]].name?.uz.toString(),
                                onChanged: (newValue) {
                                  _getController.getRegionModel.value = RegionModel();
                                  _getController.dropDownOrders[0] = _getController.getCountryModel.value.data?.result?.indexWhere((element) => element.name?.uz.toString() == newValue) ?? 0;
                                  ApiController().getRegion(_getController.getCountryModel.value.data?.result?[_getController.dropDownOrders[0]].sId.toString());
                                  //print(_getController.getRegionModel.value.data?.result?.length);
                                },
                                items: _getController.getCountryModel.value.data?.result?.map<String>((country) {return country.name!.uz.toString();}).toList().map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList()
                            )
                        ),
                      SizedBox(height: Get.height * 0.02),
                      if (_getController.getRegionModel.value.data != null && _getController.dropDownOrders[0] != null && _getController.dropDownOrders[1] != null && _getController.getRegionModel.value.data?.result != null && _getController.getRegionModel.value.data?.result?.isNotEmpty == true)
                        Text('${'Tuman / shahar'.tr}: ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                      if (_getController.getRegionModel.value.data != null && _getController.dropDownOrders[0] != null && _getController.dropDownOrders[1] != null && _getController.getRegionModel.value.data?.result != null && _getController.getRegionModel.value.data?.result?.isNotEmpty == true)
                        SizedBox(height: Get.height * 0.01),
                      if (_getController.getRegionModel.value.data != null && _getController.dropDownOrders[0] != null && _getController.dropDownOrders[1] != null && _getController.getRegionModel.value.data?.result != null && _getController.getRegionModel.value.data?.result?.isNotEmpty == true)
                        Container(
                            width: Get.width,
                            height: Get.height * 0.06,
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3))),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: DropdownButton<String>(
                                isExpanded: true,
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(10.r),
                                dropdownColor: Theme.of(context).colorScheme.background,
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 16.sp, fontWeight: FontWeight.w500),
                                value: _getController.getRegionModel.value.data?.result![_getController.dropDownOrders[1]].name?.uz.toString(),
                                onChanged: (newValue) {
                                  _getController.dropDownOrders[1] = _getController.getRegionModel.value.data?.result?.indexWhere((element) => element.name?.uz.toString() == newValue) ?? 0;
                                },
                                items: _getController.getRegionModel.value.data?.result?.map<String>((country) {return country.name!.uz.toString();}).toList().map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()
                            )
                      ),
                      if (_getController.getRegionModel.value.data != null && _getController.dropDownOrders[0] != null && _getController.dropDownOrders[1] != null && _getController.getRegionModel.value.data?.result != null && _getController.getRegionModel.value.data?.result?.isNotEmpty == true)
                        SizedBox(height: Get.height * 0.01),
                      Text('${'Manzil'.tr}: ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                      SizedBox(height: Get.height * 0.01),
                      Container(
                        width: Get.width * 0.95,
                        height: Get.height * 0.15,
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3))),
                        padding: EdgeInsets.only(left: 10.sp, right: 10.sp,  bottom: 10.sp),
                        child: TextField(
                          maxLines: 30,
                          maxLength: 800,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Kiriting'.tr,
                            hintStyle: TextStyle(
                              fontSize: 16.sp,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ]
                )
            )
          ],
        )
        )
      ),
        bottomNavigationBar: BottomAppBar(
          height: _getController.height.value * 0.09,
          surfaceTintColor: Theme.of(context).colorScheme.background,
          elevation: 20,
          shadowColor: Theme.of(context).colorScheme.onBackground,
          color: Theme.of(context).colorScheme.background,
          child: SizedBox(
              width: Get.width,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.primaryColor2), shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)))),
                onPressed: (){},
                child: Text('Davom etish'.tr, style: TextStyle(
                    fontSize: 16.sp,
                    color: Theme.of(context).colorScheme.background,
                    fontWeight: FontWeight.w500)
                ),
              )
          )
        )
    );
  }
}