import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import '../../companents/app_bar.dart';
import '../../companents/product_item.dart';
import '../../controllers/get_controller.dart';

class DetailPage extends StatelessWidget {
  var title;
  var menuSlug;

  DetailPage({super.key, required this.title, required this.menuSlug});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getProduct(1, menuSlug);
    return Scaffold(
        appBar: AppBar(
            title: Text(title, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500)),
            centerTitle: false,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onBackground,
                size: _getController.width.value * 0.06,
              ),
              onPressed: () {
                Get.back();
              },
            )),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: _getController.width.value * 0.04,
                right: _getController.width.value * 0.01,
              ),
              child: Row(
                children: [
                  Expanded(child: Text(title, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500))),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: _getController.width.value * 0.05,
                      height: _getController.width.value * 0.05,
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(100),
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: SvgPicture.asset(
                        'assets/icon/sort.svg',
                        colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn),
                      )
                    )
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      TablerIcons.adjustments_horizontal,
                      size: _getController.width.value * 0.06,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              )
            ),
            //grid _getController.productModel.value.data!.result!.length
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.03),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: _getController.width.value * 0.03,
                    mainAxisExtent: _getController.height.value * 0.33,
                    mainAxisSpacing: _getController.height.value * 0.01,
                  ),
                  itemCount: _getController.productModel.value.data!.result!.length,
                  itemBuilder: (context, index) {
                    return ProductItem(
                      id: _getController.productModel.value.data!.result![index].sId!,
                      title: _getController.productModel.value.data!.result![index].name,
                      deck: _getController.productModel.value.data!.result![index].slug,
                      imageUrl: _getController.productModel.value.data!.result![index].image,
                      price: _getController.productModel.value.data!.result![index].price.toString(),
                    );
                  },
                ),
              )
            ),
          ],
        ));
  }
}
