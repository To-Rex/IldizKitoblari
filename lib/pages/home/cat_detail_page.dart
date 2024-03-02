import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/pages/home/quotes_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/product_item.dart';
import '../../controllers/get_controller.dart';
import 'detail_page.dart';

class CatDetailPage extends StatelessWidget {
  var title;
  var menuSlug;

  CatDetailPage({super.key, required this.title, required this.menuSlug});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    ApiController().getProduct(1, menuSlug, false);
    return Scaffold(
        appBar: AppBar(
            title: Text(title, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500)),
            centerTitle: false,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
              onPressed: () {
                Get.back();
              },
            )),
        body: Obx(() => Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.01),
                  child: Row(
                    children: [
                      Expanded(child: Text(title, style: TextStyle(fontSize: _getController.width.value * 0.05,fontWeight: FontWeight.w500))),
                      InkWell(
                          onTap: () {},
                          child: Container(
                              width: _getController.width.value * 0.05,
                              height: _getController.width.value * 0.05,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: SvgPicture.asset('assets/icon/sort.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)))),
                      IconButton(
                        onPressed: () {
                          _getController.addPage();
                          ApiController().getProduct(
                              _getController.page.value,
                              menuSlug, true);
                        },
                        icon: Icon(
                          TablerIcons.adjustments_horizontal,
                          size: _getController.width.value * 0.06,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  )),
              if (_getController.productModelLength.value == 0)
                Expanded(child:
                Center(child: Text('Ma`lumotlar yo`q!', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w600))),
                ),
              if (_getController.productModelLength.value != 0)
              Expanded(
                  child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: const ClassicHeader(),
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus? mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = const SizedBox();
                      } else if (mode == LoadStatus.loading) {
                        body = const CircularProgressIndicator(
                            color: Colors.blue, backgroundColor: Colors.white, strokeWidth: 2);
                      } else if (mode == LoadStatus.failed) {
                        body = const Text("Ex nimadir xato ketdi", style: TextStyle(fontSize: 14, color: Colors.red));
                      } else if (mode == LoadStatus.canLoading) {
                        body = const SizedBox();
                      } else {
                        body = const Text("Ma`lumotlar yangilandi", style: TextStyle(fontSize: 14, color: Colors.black));
                      }
                      return SizedBox(
                        height: _getController.height.value * 0.1,
                        child: Center(child: body),
                      );
                    },
                  ),
                  onLoading: () async {
                    ApiController().getProduct(_getController.page.value + 1, menuSlug,true).then((value) =>
                        _refreshController.loadComplete()
                    );
                  },
                  onRefresh: () async {
                    _getController.page.value = 1;
                    ApiController().getProduct(1, menuSlug, false).then((value) =>
                        _refreshController.refreshCompleted()
                    );
                  },
                  physics: const BouncingScrollPhysics(),
                  controller: _refreshController,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.07,
                      mainAxisExtent: _getController.height.value * 0.33,
                      mainAxisSpacing: _getController.height.value * 0.015,
                      crossAxisSpacing: _getController.width.value * 0.03,
                    ),
                    padding: EdgeInsets.only(left: _getController.width.value * 0.025, right: _getController.width.value * 0.025, bottom: _getController.height.value * 0.02),
                    itemCount: _getController.productModelLength.value,
                    itemBuilder: (context, index) {
                      return ProductItem(
                        id: _getController.productModel.value.data!.result![index].sId!,
                        title: _getController.productModel.value.data!.result![index].name!,
                        deck: _getController.productModel.value.data!.result![index].slug!,
                        price: _getController.productModel.value.data!.result![index].price!.toString(),
                        imageUrl: _getController.productModel.value.data!.result![index].image!,
                        function: () {
                         // Get.to(() => QuotesPage());
                          Get.to(() => DetailPage());
                        }
                      );
                    }
                  )
              ))

            ],
          ),
        )
    );
  }
}
