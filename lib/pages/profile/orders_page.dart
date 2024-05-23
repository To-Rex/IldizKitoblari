import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:intl/intl.dart';
import '../../companents/user/scleton_orders.dart';
import '../../controllers/get_controller.dart';
import 'orders_detail_page.dart';

class OrdersPage extends StatelessWidget{
  OrdersPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getOrderList();
    return Scaffold(
        body: SingleChildScrollView(
          child: Obx(()=> Column(
              children: [
                AppBar(
                    title: Text('Buyurtmalar'.tr, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500)),
                    centerTitle: false,
                    surfaceTintColor: Colors.transparent,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
                        onPressed: () {
                          Get.back();
                        }
                    )
                ),
                SizedBox(height: _getController.height.value * 0.02),
                Padding(
                    padding: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.01),
                    child: Row(
                        children: [
                          Expanded(child: Text('Buyurtmalar'.tr, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500))),
                          InkWell(onTap: () {
                            _getController.clearOrderListModel();
                            _getController.onLoad();
                          }, child: Container(width: _getController.width.value * 0.05, height: _getController.width.value * 0.05, decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.background,), child: SvgPicture.asset('assets/icon/sort.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)))),
                          SizedBox(width: _getController.width.value * 0.03),
                        ]
                    )
                ),
                 SizedBox(height: _getController.height.value * 0.02),
                 _getController.orderListModel.value.data == null || _getController.orderListModel.value.data!.result!.isEmpty
                    ? _getController.onLoading.isFalse
                     ? SizedBox(width: Get.width, height: Get.height * 0.8, child: Center(child: Text('Ma‘lumotlar yo‘q!'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500))))
                     : SizedBox(width: Get.width, height: Get.height * 0.7, child: const Center(child: SkeletonOrders()))
                    : ListView.separated(
                     physics: const NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                     padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                     itemCount: _getController.orderListModel.value.data!.result!.length,
                     separatorBuilder: (context, index) => SizedBox(height: Get.height * 0.01),
                     itemBuilder: (context, index) {
                       return InkWell(
                         onTap: () {
                           Get.to(() => OrdersDetailPage(),
                               transition: Transition.rightToLeft,
                               //arguments: _getController.orderListModel.value.data!.result![index].sId,
                               arguments: [_getController.orderListModel.value.data!.result![index].sId,_getController.orderListModel.value.data!.result![index].createdAt]
                           );
                         },
                         child: Container(
                             width: Get.width * 0.8,
                             padding: EdgeInsets.all(10.sp),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Theme.of(context).colorScheme.background,
                                 boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 0))]
                             ),
                             child: Column(
                                 children: [
                                   SizedBox(height: Get.height * 0.01),
                                   Row(
                                     children: [
                                       Text('№${_getController.orderListModel.value.data!.result![index].uid}', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500)),
                                       const Spacer(),
                                       Text(
                                         DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(_getController.orderListModel.value.data!.result![index].createdAt!).toLocal().toString().substring(0, 10).replaceAll('-', '.'),
                                         style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500),
                                       ),
                                     ],
                                   ),
                                   Divider(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1)),
                                   Row(
                                       children: [
                                         Text('${int.parse(_getController.orderListModel.value.data!.result![index].price.toString()) + int.parse(_getController.orderListModel.value.data!.result![index].deliveryPrice.toString())}${' so’m'.tr}', style: TextStyle(fontSize: _getController.width.value * 0.05, color: AppColors.primaryColor2, fontWeight: FontWeight.w500)),
                                         Container(
                                             width: 6.sp,
                                             height: 6.sp,
                                             margin: EdgeInsets.symmetric(horizontal: 5.sp),
                                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))
                                         ),
                                       ]
                                   ),
                                   SizedBox(height: Get.height * 0.01)
                                 ]
                             )
                         )
                       );
                     }
                 )
              ]
          ))
        )
    );
  }
}