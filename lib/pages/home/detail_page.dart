import 'package:flutter/material.dart';
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
              padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.04, vertical: _getController.width.value * 0.02),
              child: Row(
                children: [
                  Text(title, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: _getController.width.value * 0.1,
                      height: _getController.width.value * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.filter_alt,
                          size: _getController.width.value * 0.06,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: _getController.width.value * 0.1,
                      height: _getController.width.value * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.settings,
                          size: _getController.width.value * 0.06,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
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
