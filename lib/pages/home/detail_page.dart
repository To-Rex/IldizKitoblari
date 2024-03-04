import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/detail_element.dart';
import '../../companents/product_item.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPage extends StatelessWidget {

  String slug;

  DetailPage({super.key, required this.slug});
  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  //{
  //     "message": "Ok!",
  //     "status": true,
  //     "data": {
  //         "_id": "658ef7fef37883518b90d0ef",
  //         "name": {
  //             "uz": "Aldanganlar",
  //             "oz": "Алданганлар",
  //             "ru": "Алданганлар"
  //         },
  //         "price": 16000,
  //         "sale": 0,
  //         "views": 404,
  //         "searched": 88,
  //         "menu": {
  //             "_id": "6454cf99dbf73cf41706afd9",
  //             "slug": "ruhiy-tarbiya",
  //             "options": [
  //                 {
  //                     "option_id": "643a5ed8590e7e6f7fb931c6",
  //                     "on_filter": true,
  //                     "is_main": false,
  //                     "_id": "6459ed5ec7d3e0c5c01e429e"
  //                 },
  //                 {
  //                     "option_id": "643a5e56590e7e6f7fb931c2",
  //                     "on_filter": true,
  //                     "is_main": false,
  //                     "_id": "6459ed5ec7d3e0c5c01e429f"
  //                 },
  //                 {
  //                     "option_id": "643a58b0590e7e6f7fb931a3",
  //                     "on_filter": true,
  //                     "is_main": false,
  //                     "_id": "6459ed5ec7d3e0c5c01e42a0"
  //                 },
  //                 {
  //                     "option_id": "6439404495fada302b4aa815",
  //                     "on_filter": true,
  //                     "is_main": true,
  //                     "_id": "6459ed5ec7d3e0c5c01e42a1"
  //                 },
  //                 {
  //                     "option_id": "643822b3838709f59c0c90d4",
  //                     "on_filter": true,
  //                     "is_main": false,
  //                     "_id": "6459ed5ec7d3e0c5c01e42a2"
  //                 },
  //                 {
  //                     "option_id": "6438229d838709f59c0c90d0",
  //                     "on_filter": false,
  //                     "is_main": false,
  //                     "_id": "6459ed5ec7d3e0c5c01e42a3"
  //                 }
  //             ]
  //         },
  //         "count": 134,
  //         "status": true,
  //         "famous": true,
  //         "new_product": true,
  //         "options": [
  //             {
  //                 "option_id": {
  //                     "_id": "643a5ed8590e7e6f7fb931c6",
  //                     "name": {
  //                         "uz": "Muallif",
  //                         "oz": "Муаллиф",
  //                         "ru": "Автор"
  //                     },
  //                     "type": 3
  //                 },
  //                 "value": "",
  //                 "value_id": {
  //                     "_id": "643a5f63590e7e6f7fb931d0",
  //                     "name": {
  //                         "uz": "Imom Gʻazzoliy",
  //                         "oz": "Imom Gʻazzoliy",
  //                         "ru": "Imom Gʻazzoliy"
  //                     }
  //                 },
  //                 "_id": "65cf9208cbf6aacbca83d71c"
  //             },
  //             {
  //                 "option_id": {
  //                     "_id": "643a58b0590e7e6f7fb931a3",
  //                     "name": {
  //                         "uz": "Muqovasi",
  //                         "oz": "Муқоваси",
  //                         "ru": "Тип обложки"
  //                     },
  //                     "type": 3
  //                 },
  //                 "value": "",
  //                 "value_id": {
  //                     "_id": "643a599f590e7e6f7fb931ad",
  //                     "name": {
  //                         "uz": "Yumshoq",
  //                         "oz": "Юмшоқ",
  //                         "ru": "Мягкая"
  //                     }
  //                 },
  //                 "_id": "65cf9208cbf6aacbca83d71e"
  //             },
  //             {
  //                 "option_id": {
  //                     "_id": "6439404495fada302b4aa815",
  //                     "name": {
  //                         "uz": "Nashriyot",
  //                         "oz": "Нашриёт",
  //                         "ru": "Издатель"
  //                     },
  //                     "type": 3
  //                 },
  //                 "value": "",
  //                 "value_id": {
  //                     "_id": "654a784b18e8d01d730f6043",
  //                     "name": {
  //                         "uz": "\"Ildiz nashriyoti\"",
  //                         "oz": "\"Илдиз нашриёти\"",
  //                         "ru": "\"Илдиз нашриёти\""
  //                     }
  //                 },
  //                 "_id": "65cf9208cbf6aacbca83d71f"
  //             },
  //             {
  //                 "option_id": {
  //                     "_id": "643822b3838709f59c0c90d4",
  //                     "name": {
  //                         "uz": "Kitob tili",
  //                         "oz": "Китоб тили",
  //                         "ru": "Язык книги"
  //                     },
  //                     "type": 3
  //                 },
  //                 "value": "",
  //                 "value_id": {
  //                     "_id": "643932c895fada302b4aa5c2",
  //                     "name": {
  //                         "uz": "O'zbekcha",
  //                         "oz": "Ўзбекча",
  //                         "ru": "На узбекском"
  //                     }
  //                 },
  //                 "_id": "65cf9208cbf6aacbca83d720"
  //             },
  //             {
  //                 "option_id": {
  //                     "_id": "6438229d838709f59c0c90d0",
  //                     "name": {
  //                         "uz": "Yili",
  //                         "oz": "Йили",
  //                         "ru": "Год"
  //                     },
  //                     "type": 1
  //                 },
  //                 "value": "2023",
  //                 "value_id": null,
  //                 "_id": "65cf9208cbf6aacbca83d721"
  //             }
  //         ],
  //         "content": {
  //             "uz": "<p>Hujjatul Islom Abu Homid G&lsquo;azzoliyning ko&lsquo;plab asarlari katori ushbu \"Aldanganlar\" kitobi ham musulmon olamida juda mashhurdir. Kitobda turli toifalarning turlicha aldanishlari o&lsquo;z ifodasini topgan. Xususan, muallif diniy qatlamdagi shaxslarning aldanish yo&lsquo;llarini ko&lsquo;rsatib, uning muolajalarini ham zikr qilib o&lsquo;tgan. Masalan, tasavvuf ahlini dunyoni butkul tark etib, tarkidunyolikni yoqlashini muallif tanqid ostiga olgan.</p>\n<p>Asar boshdan-oxir muammo va uning yechimi bilan yo&lsquo;g&lsquo;rilgan desak adashmaymiz!</p>",
  //             "oz": "<p>Ҳужжатул Ислом Абу Ҳомид Ғаззолийнинг кўплаб асарлари катори ушбу \"Алданганлар\" китоби ҳам мусулмон оламида жуда машҳурдир. Китобда турли тоифаларнинг турлича алданишлари ўз ифодасини топган. Хусусан, муаллиф диний қатламдаги шахсларнинг алданиш йўлларини кўрсатиб, унинг муолажаларини ҳам зикр қилиб ўтган. Масалан, тасаввуф аҳлини дунёни буткул тарк этиб, таркидунёликни ёқлашини муаллиф танқид остига олган.</p>\n<p>Асар бошдан-охир муаммо ва унинг ечими билан йўғрилган десак адашмаймиз!</p>",
  //             "ru": "<p>Ҳужжатул Ислом Абу Ҳомид Ғаззолийнинг кўплаб асарлари катори ушбу \"Алданганлар\" китоби ҳам мусулмон оламида жуда машҳурдир. Китобда турли тоифаларнинг турлича алданишлари ўз ифодасини топган. Хусусан, муаллиф диний қатламдаги шахсларнинг алданиш йўлларини кўрсатиб, унинг муолажаларини ҳам зикр қилиб ўтган. Масалан, тасаввуф аҳлини дунёни буткул тарк этиб, таркидунёликни ёқлашини муаллиф танқид остига олган.</p>\n<p>Асар бошдан-охир муаммо ва унинг ечими билан йўғрилган десак адашмаймиз!</p>"
  //         },
  //         "simular_products": [
  //             {
  //                 "_id": "64ac092962a769146f213c1f",
  //                 "slug": "hayotni-sokinlashtirish-payti",
  //                 "price": 34000,
  //                 "sale": 0,
  //                 "count": 4,
  //                 "option": {
  //                     "option_id": {
  //                         "_id": "6439404495fada302b4aa815",
  //                         "name": {
  //                             "uz": "Nashriyot",
  //                             "oz": "Нашриёт",
  //                             "ru": "Издатель"
  //                         },
  //                         "type": 3
  //                     },
  //                     "value": "",
  //                     "value_id": {
  //                         "_id": "645b3936c7d3e0c5c01e8987",
  //                         "name": {
  //                             "uz": "\"BEST-BOOK\" nashriyoti",
  //                             "oz": "\"БЕСТ-БООК\" нашриёти",
  //                             "ru": "\"БЕСТ-БООК\" нашриёти"
  //                         }
  //                     },
  //                     "_id": "65c912a3cbf6aacbca781677"
  //                 },
  //                 "image": "https://ildizkitoblari.uz/public/files/2023-07-10T13-40-43.874Z_photo_1_2023-07-10_18-40-28.jpg"
  //             },
  //             {
  //                 "_id": "645e2092c7d3e0c5c01ef16c",
  //                 "slug": "qalbimdasan-alloh",
  //                 "price": 37000,
  //                 "sale": 0,
  //                 "count": 3,
  //                 "option": {
  //                     "option_id": {
  //                         "_id": "6439404495fada302b4aa815",
  //                         "name": {
  //                             "uz": "Nashriyot",
  //                             "oz": "Нашриёт",
  //                             "ru": "Издатель"
  //                         },
  //                         "type": 3
  //                     },
  //                     "value": "",
  //                     "value_id": {
  //                         "_id": "645e0616c7d3e0c5c01ee136",
  //                         "name": {
  //                             "uz": "\"ZUMAR BOOKS\"",
  //                             "oz": "\"ЗУМАР БООКС\"",
  //                             "ru": "\"ЗУМАР БООКС\""
  //                         }
  //                     },
  //                     "_id": "652c231c3a98a287b65d7052"
  //                 },
  //                 "image": "https://ildizkitoblari.uz/public/files/2023-09-21T09-32-44.489Z_2023-05-12T11-22-57.055Z_Snapinsta.app_332335980_6140116172700638_8611954875413608633_n_1024.jpg"
  //             },
  //             {
  //                 "_id": "645b4b5dc7d3e0c5c01e9397",
  //                 "slug": "ihyou-ulumiddin-1-2-qism",
  //                 "price": 225000,
  //                 "sale": 0,
  //                 "count": 3,
  //                 "option": {
  //                     "option_id": {
  //                         "_id": "6439404495fada302b4aa815",
  //                         "name": {
  //                             "uz": "Nashriyot",
  //                             "oz": "Нашриёт",
  //                             "ru": "Издатель"
  //                         },
  //                         "type": 3
  //                     },
  //                     "value": "",
  //                     "value_id": null,
  //                     "_id": "65cf907acbf6aacbca83cb77"
  //                 },
  //                 "image": "https://ildizkitoblari.uz/public/files/2023-05-10T07-58-08.832Z_Snapinsta.app_336250207_231334115947774_6665253980849993203_n_1024.jpg"
  //             },
  //             {
  //                 "_id": "65924ef6b4469a051c48d3ac",
  //                 "slug": "kelinlik-toji",
  //                 "price": 19000,
  //                 "sale": 0,
  //                 "count": 1,
  //                 "option": {
  //                     "option_id": {
  //                         "_id": "6439404495fada302b4aa815",
  //                         "name": {
  //                             "uz": "Nashriyot",
  //                             "oz": "Нашриёт",
  //                             "ru": "Издатель"
  //                         },
  //                         "type": 3
  //                     },
  //                     "value": "",
  //                     "value_id": {
  //                         "_id": "654a784b18e8d01d730f6043",
  //                         "name": {
  //                             "uz": "\"Ildiz nashriyoti\"",
  //                             "oz": "\"Илдиз нашриёти\"",
  //                             "ru": "\"Илдиз нашриёти\""
  //                         }
  //                     },
  //                     "_id": "65cf9229cbf6aacbca83d8e1"
  //                 },
  //                 "image": "https://ildizkitoblari.uz/public/files/2024-01-07T17-26-10.118Z_ÐÐ¸Ð·Ð°Ð¹Ð½ Ð±ÐµÐ· Ð½Ð°Ð·Ð²Ð°Ð½Ð¸Ñ (45) (1).jpg"
  //             },
  //             {
  //                 "_id": "64aaa734faf501191df95843",
  //                 "slug": "vaqtingiz-hayotingiz",
  //                 "price": 17000,
  //                 "sale": 0,
  //                 "count": 25,
  //                 "option": {
  //                     "option_id": {
  //                         "_id": "6439404495fada302b4aa815",
  //                         "name": {
  //                             "uz": "Nashriyot",
  //                             "oz": "Нашриёт",
  //                             "ru": "Издатель"
  //                         },
  //                         "type": 3
  //                     },
  //                     "value": "",
  //                     "value_id": {
  //                         "_id": "6480184c6c85feeb8e0d6f12",
  //                         "name": {
  //                             "uz": "\"Tilsim\" nashriyoti",
  //                             "oz": "",
  //                             "ru": ""
  //                         }
  //                     },
  //                     "_id": "65cf9149cbf6aacbca83d121"
  //                 },
  //                 "image": "https://ildizkitoblari.uz/public/files/2023-07-09T12-27-56.223Z_photo_1_2023-07-09_17-27-31.jpg"
  //             },
  //             {
  //                 "_id": "64abb5fd62a769146f20b145",
  //                 "slug": "bolamni-yaxshi-koraman",
  //                 "price": 16000,
  //                 "sale": 0,
  //                 "count": 46,
  //                 "option": {
  //                     "option_id": {
  //                         "_id": "6439404495fada302b4aa815",
  //                         "name": {
  //                             "uz": "Nashriyot",
  //                             "oz": "Нашриёт",
  //                             "ru": "Издатель"
  //                         },
  //                         "type": 3
  //                     },
  //                     "value": "",
  //                     "value_id": {
  //                         "_id": "6459f081c7d3e0c5c01e487d",
  //                         "name": {
  //                             "uz": "Kitobdoornashr NMU",
  //                             "oz": "Китобдоорнашр НМУ",
  //                             "ru": "Китобдоорнашр НМУ"
  //                         }
  //                     },
  //                     "_id": "65c88525cbf6aacbca76a4de"
  //                 },
  //                 "image": "https://ildizkitoblari.uz/public/files/2023-07-10T07-44-39.874Z_photo_4_2023-07-10_12-43-57.jpg"
  //             },
  //             {
  //                 "_id": "65462ee518e8d01d730382de",
  //                 "slug": "havas-va-hasad",
  //                 "price": 26000,
  //                 "sale": 0,
  //                 "count": 22,
  //                 "option": {
  //                     "option_id": {
  //                         "_id": "6439404495fada302b4aa815",
  //                         "name": {
  //                             "uz": "Nashriyot",
  //                             "oz": "Нашриёт",
  //                             "ru": "Издатель"
  //                         },
  //                         "type": 3
  //                     },
  //                     "value": "",
  //                     "value_id": {
  //                         "_id": "6459f081c7d3e0c5c01e487d",
  //                         "name": {
  //                             "uz": "Kitobdoornashr NMU",
  //                             "oz": "Китобдоорнашр НМУ",
  //                             "ru": "Китобдоорнашр НМУ"
  //                         }
  //                     },
  //                     "_id": "65c6ea3ccbf6aacbca740bdc"
  //                 },
  //                 "image": "https://ildizkitoblari.uz/public/files/2023-11-04T11-49-34.211Z_photo_2023-10-27_17-25-38.jpg"
  //             },
  //             {
  //                 "_id": "64a7d7d7faf501191df89bc7",
  //                 "slug": "tazkirat-ul-avliyo",
  //                 "price": 0,
  //                 "sale": 0,
  //                 "count": 0,
  //                 "option": {
  //                     "option_id": {
  //                         "_id": "6439404495fada302b4aa815",
  //                         "name": {
  //                             "uz": "Nashriyot",
  //                             "oz": "Нашриёт",
  //                             "ru": "Издатель"
  //                         },
  //                         "type": 3
  //                     },
  //                     "value": "",
  //                     "value_id": {
  //                         "_id": "646f4175c27c97e6bfdef0e8",
  //                         "name": {
  //                             "uz": "\"Factor press\"",
  //                             "oz": "\"Фактор пресс\"",
  //                             "ru": "\"Фактор пресс\""
  //                         }
  //                     },
  //                     "_id": "650acc9666ec7a2fa243f029"
  //                 },
  //                 "image": "https://ildizkitoblari.uz/public/files/2023-09-20T10-42-12.734Z_2023-07-07T09-18-38.334Z_photo_4_2023-07-07_14-18-19.jpg"
  //             }
  //         ],
  //         "comments": [
  //             {
  //                 "_id": "65bbc043b4469a051c8a64af",
  //                 "rate": 5,
  //                 "description": "Imom Gʻazzoliy hazratlari vafot etgan boʻlsalar ham sizlarning sharofatingiz bilan kitoblarida biz bilan birgalar. Alloh hayrli qilsin. ",
  //                 "user": {
  //                     "_id": "65bbbf3bb4469a051c8a63fb",
  //                     "full_name": "Egamnazarov Muhammad Xolmamat oʻgʻli ",
  //                     "avatar": "https://ildizkitoblari.uz/public/files/2024-02-01T15-58-16.032Z_FB_IMG_1603449037822.jpg",
  //                     "createdAt": "2024-02-01T21:01:07+05:00"
  //                 },
  //                 "createdAt": "2024-02-01T16:01:07.938Z"
  //             }
  //         ],
  //         "images": [
  //             {
  //                 "_id": "658ef883f37883518b90d197",
  //                 "file": "https://ildizkitoblari.uz/public/files/2023-12-29T16-49-07.245Z_IMG_1014 (1).jpg",
  //                 "is_main": true
  //             },
  //             {
  //                 "_id": "658ef8e3f37883518b90d1a0",
  //                 "file": "https://ildizkitoblari.uz/public/files/2023-12-29T16-50-43.199Z_photo_2_2023-12-29_21-50-32.jpg",
  //                 "is_main": false
  //             }
  //         ]
  //     }
  // }
  @override
  Widget build(BuildContext context) {
    //ApiController().getProductDetail('aldanganlar');
    ApiController().getProductDetail(slug);
    return Scaffold(
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const ClassicHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = const SizedBox();
              } else if (mode == LoadStatus.loading) {
                body = const CircularProgressIndicator(color: Colors.blue, backgroundColor: Colors.white, strokeWidth: 2);
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
            _refreshController.loadComplete();
          },
          onRefresh: () async {
            _refreshController.refreshCompleted();
          },
          controller: _refreshController,
          child: Stack(
            children: [
              Positioned(top: 0, left: 0, right: 0, bottom: 0,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Obx(() => _getController.productDetailModel.value.data != null
                      ? Column(
                      children: [
                        AppBar(
                          surfaceTintColor: Colors.transparent,
                          leading: IconButton(
                              icon: Icon(Icons.arrow_back,
                                  color: Theme.of(context).colorScheme.onBackground,
                                  size: _getController.width.value * 0.065),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),
                          actions: [
                            IconButton(
                                icon: Icon(
                                    TablerIcons.share,
                                    color: Theme.of(context).colorScheme.onBackground,
                                    size: _getController.width.value * 0.065),
                                onPressed: () {
                                }
                            ),
                            IconButton(
                                icon: Icon(
                                    TablerIcons.bookmark,
                                    color: Theme.of(context).colorScheme.onBackground,
                                    size: _getController.width.value * 0.065),
                                onPressed: () {
                                }
                            )],
                        ),
                        Container(
                          width: _getController.width.value,
                          height: _getController.height.value * 0.427,
                          margin: EdgeInsets.only(
                            top: _getController.height.value * 0.01,
                            left: _getController.width.value * 0.03,
                            right: _getController.width.value * 0.03,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(4)),
                            image: DecorationImage(
                              image: NetworkImage(
                                _getController.productDetailModel.value.data?.images![0].file ?? '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: _getController.height.value * 0.061,
                          width: _getController.width.value,
                          margin: EdgeInsets.only(top: _getController.height.value * 0.007),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _getController.productDetailModel.value.data?.images!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(left: _getController.width.value * 0.03),
                                width: _getController.width.value * 0.14,
                                height: _getController.height.value * 0.06,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      _getController.productDetailModel.value.data?.images![index].file ?? '',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03, top: _getController.height.value * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getController.productDetailModel.value.data?.name?.uz ?? '',
                                  style: TextStyle(
                                    fontSize: _getController.width.value * 0.06,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: _getController.height.value * 0.013),
                                Row(
                                    children: [
                                      if (_getController.productRate.value.data != null)
                                        DetailElement(
                                          title: _getController.productRate.value.data!.result!.average == null ? '0' : _getController.productRate.value.data!.result!.average.toString(),
                                          subTitle: '',
                                          icon: Icons.star,
                                        ),
                                      DetailElement(
                                        title: _getController.productDetailModel.value.data?.views.toString() ?? '',
                                        subTitle: 'ta izoh'.tr,
                                        icon: TablerIcons.message_circle,
                                      ),
                                      DetailElement(
                                          title: _getController.productDetailModel.value.data?.searched.toString() ?? '',
                                          subTitle: 'ta ko\'rilgan'.tr,
                                          icon: TablerIcons.eye
                                      )
                                    ]
                                ),
                                Container(
                                  height: _getController.height.value * 0.08,
                                  width: _getController.width.value,
                                  margin: EdgeInsets.only(top: _getController.height.value * 0.025, bottom: _getController.height.value * 0.013),
                                  padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor3.withOpacity(0.15),
                                    border: Border.all(color: AppColors.primaryColor3, width: 1),
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child:
                                      Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Elektron kitob'.tr,
                                              style: TextStyle(
                                                  fontSize: _getController.width.value * 0.04,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).colorScheme.onBackground
                                              ),
                                            ),
                                            //price
                                            Text('${_getController.productDetailModel.value.data?.price} so\'m',
                                                style: TextStyle(
                                                    fontSize: _getController.width.value * 0.04,
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)
                                                )
                                            )
                                          ]
                                      )),
                                      Icon(
                                        TablerIcons.book_2,
                                        color: AppColors.primaryColor3,
                                        size: _getController.width.value * 0.1,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height: _getController.height.value * 0.08,
                                        width: _getController.width.value * 0.45,
                                        padding: EdgeInsets.only(
                                            left: _getController.width.value * 0.03,
                                            right: _getController.width.value * 0.03
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.grey.withOpacity(0.2),
                                          border: Border.all(color: AppColors.grey, width: 1),
                                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                                        ),
                                        child: Row(
                                            children: [
                                              Expanded(child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Elektron kitob'.tr,
                                                        style: TextStyle(
                                                            fontSize: _getController.width.value * 0.04,
                                                            fontWeight: FontWeight.w500,
                                                            color: Theme.of(context).colorScheme.onBackground
                                                        )
                                                    ),
                                                    Text('16000 so\'m',
                                                        style: TextStyle(
                                                            fontSize: _getController.width.value * 0.04,
                                                            fontWeight: FontWeight.w400,
                                                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)
                                                        )
                                                    )
                                                  ]
                                              )),
                                              Icon(
                                                TablerIcons.book,
                                                color: AppColors.primaryColor3,
                                                size: _getController.width.value * 0.06,
                                              )
                                            ]
                                        )
                                    ),
                                    Container(
                                        height: _getController.height.value * 0.08,
                                        width: _getController.width.value * 0.45,
                                        padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                        decoration: BoxDecoration(
                                          color: AppColors.grey.withOpacity(0.2),
                                          border: Border.all(color: AppColors.grey, width: 1),
                                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                                        ),
                                        child: Row(
                                            children: [
                                              Expanded(child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Audio kitob'.tr,
                                                        style: TextStyle(
                                                            fontSize: _getController.width.value * 0.04,
                                                            fontWeight: FontWeight.w500,
                                                            color: Theme.of(context).colorScheme.onBackground
                                                        )
                                                    ),
                                                    Text('16000 so\'m',
                                                        style: TextStyle(
                                                            fontSize: _getController.width.value * 0.04,
                                                            fontWeight: FontWeight.w400,
                                                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)
                                                        )
                                                    )
                                                  ]
                                              )),
                                              Icon(
                                                  TablerIcons.headphones,
                                                  color: AppColors.primaryColor3,
                                                  size: _getController.width.value * 0.06
                                              )
                                            ]
                                        )
                                    )
                                  ],
                                ),
                                SizedBox(height: _getController.height.value * 0.02),
                                Text('Tafsilotlar'.tr, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500)),
                                SizedBox(height: _getController.height.value * 0.02),
                                /*SizedBox(
                                    width: _getController.width.value,
                                    height:  _getController.productDetailModel.value != null ? _getController.productDetailModel.value.data!.options!.length * _getController.height.value * 0.035 : 0,
                                    child: Center(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        //semanticChildCount: _getController.productDetailModel.value.data?.options!.length,
                                        addAutomaticKeepAlives: true,
                                        primary: true,
                                        addRepaintBoundaries: true,
                                        scrollDirection: Axis.vertical,
                                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                        findChildIndexCallback: (key) => null,
                                        itemCount: _getController.productDetailModel.value.data?.options!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                              bottom: _getController.height.value * 0.01,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(_getController.productDetailModel.value.data?.options![index].optionId?.name?.uz ?? '',
                                                  style: TextStyle(
                                                      fontSize: _getController.width.value * 0.04,
                                                      fontWeight: FontWeight.w500,
                                                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)
                                                  ),
                                                ),
                                                Expanded(child: Text('  ---------------------------------------------------------  ',
                                                    maxLines: 1,
                                                    style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)))
                                                ),
                                                Text(
                                                  _getController.productDetailModel.value.data?.options![index].valueId?.name?.uz ?? _getController.productDetailModel.value.data?.options![index].value ?? '',
                                                  style: TextStyle(
                                                      fontSize: _getController.width.value * 0.04,
                                                      fontWeight: FontWeight.w500,
                                                      color: Theme.of(context).colorScheme.onBackground
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                      )
                                    )
                                ),*/
                                if (_getController.productDetailModel.value.data?.options != null)
                                  for (int i = 0; i < _getController.productDetailModel.value.data!.options!.length; i++)
                                    Container(
                                      margin: EdgeInsets.only(bottom: _getController.height.value * 0.019),
                                      child: Row(
                                        children: [
                                          Text(_getController.productDetailModel.value.data?.options![i].optionId?.name?.uz ?? '', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)),),
                                          Expanded(child: Text('  ---------------------------------------------------------  ', maxLines: 1, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)))),
                                          Text(_getController.productDetailModel.value.data?.options![i].valueId?.name?.uz ?? _getController.productDetailModel.value.data?.options![i].value ?? '', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground),)
                                      ],
                                    ),
                                  ),
                                SizedBox(height: _getController.height.value * 0.01),
                                if ('uz_UZ' == Get.locale.toString() && _getController.productDetailModel.value.data?.content?.uz != '' || 'ru_RU' == Get.locale.toString() && _getController.productDetailModel.value.data?.content?.ru != '' || 'oz_UZ' == Get.locale.toString() && _getController.productDetailModel.value.data?.content?.oz != '')
                                  Text('Tavsif',
                                    style: TextStyle(
                                      fontSize: _getController.width.value * 0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                if ('uz_UZ' == Get.locale.toString() && _getController.productDetailModel.value.data?.content?.uz != '' || 'ru_RU' == Get.locale.toString() && _getController.productDetailModel.value.data?.content?.ru != '' || 'oz_UZ' == Get.locale.toString() && _getController.productDetailModel.value.data?.content?.oz != '')
                                  Html(
                                    style: {
                                      'p': Style(
                                        fontSize: FontSize(_getController.width.value * 0.04),
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).colorScheme.onBackground,
                                      ),
                                    },
                                    //data: _getController.productDetailModel.value.data?.content?.uz ?? '',
                                    data: 'uz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.content?.uz ?? '' : 'ru_RU' == Get.locale.toString() ? _getController.productDetailModel.value.data?.content?.ru ?? '' : 'oz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.content?.oz ?? '' : '',
                                  ),
                                Text('Mualif haqida',
                                  style: TextStyle(
                                    fontSize: _getController.width.value * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: _getController.width.value,
                                  height: _getController.height.value * 0.09,
                                  margin: EdgeInsets.only(top: _getController.height.value * 0.02, bottom: _getController.height.value * 0.02),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.background,
                                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3)
                                        )
                                      ]
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: _getController.width.value * 0.16,
                                        height: _getController.height.value * 0.08,
                                        margin: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'uz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].image ?? '' : 'ru_RU' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].image ?? '' : 'oz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].image ?? '' : '',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'uz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].option?.valueId?.name?.uz ?? '' : 'ru_RU' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].option?.valueId?.name?.uz ?? '' : 'oz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].option?.valueId?.name?.uz ?? '' : '',
                                            style: TextStyle(
                                                fontSize: _getController.width.value * 0.04,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context).colorScheme.onBackground
                                            ),
                                          ),
                                          Text(
                                            'uz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].option?.valueId?.name?.uz ?? '' : 'ru_RU' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].option?.valueId?.name?.uz ?? '' : 'oz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].option?.valueId?.name?.uz ?? '' : '',
                                            style: TextStyle(
                                                fontSize: _getController.width.value * 0.04,
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)
                                            ),
                                          )
                                        ],
                                      )),
                                      Icon(
                                        TablerIcons.arrow_right,
                                        color: Theme.of(context).colorScheme.onBackground,
                                        size: _getController.width.value * 0.07,
                                      ),
                                      SizedBox(width: _getController.width.value * 0.03),
                                    ],
                                  ),
                                ),
                                Text('Tavsiya etiladi',
                                  style: TextStyle(
                                    fontSize: _getController.width.value * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  height: _getController.height.value * 0.35,
                                  width: _getController.width.value,
                                  margin: EdgeInsets.only(top: _getController.height.value * 0.02, bottom: _getController.height.value * 0.01),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _getController.productDetailModel.value.data?.simularProducts!.length,
                                    itemBuilder: (context, index) {
                                      return ProductItem(
                                        id: _getController.productDetailModel.value.data?.simularProducts![index].slug ?? '',
                                        title: _getController.productDetailModel.value.data?.simularProducts![index].option?.valueId?.name?.uz ?? '',
                                        deck: _getController.productDetailModel.value.data?.simularProducts![index].option?.valueId?.name?.uz ?? '',
                                        price: _getController.productDetailModel.value.data?.simularProducts![index].price.toString() ?? '',
                                        imageUrl: _getController.productDetailModel.value.data?.simularProducts![index].image ?? '',
                                        function: () {
                                          //new page for product detail
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(slug: _getController.productDetailModel.value.data?.simularProducts![index].slug ?? '')));
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Text('Sizning fikringiz', style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.bold)),
                                SizedBox(height: _getController.height.value * 0.015),
                                if (_getController.productRate.value.data != null)
                                  Text('Baholang', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500)),
                                if (_getController.productRate.value.data != null)
                                  SizedBox(height: _getController.height.value * 0.01),
                                if (_getController.productRate.value.data != null)
                                  RatingBar.builder(
                                      initialRating: _getController.productRate.value.data!.result!.average == null ? 0 : double.parse(_getController.productRate.value.data!.result!.average.toString()),
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: _getController.width.value * 0.07,
                                      itemPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01),
                                      unratedColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
                                      itemBuilder: (context, _) =>
                                      const Icon(
                                          TablerIcons.star_filled,
                                          color: AppColors.primaryColor
                                      ),
                                      onRatingUpdate: (rating) {}
                                  ),
                                SizedBox(height: _getController.height.value * 0.02),
                                Text('Izoh:', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500)),
                                SizedBox(height: _getController.height.value * 0.01),
                                Container(
                                  width: _getController.width.value,
                                  padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.background,
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2), width: 1),
                                  ),
                                  child: TextField(
                                    minLines: 1,
                                    maxLines: 3,
                                    style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onBackground),
                                    decoration: InputDecoration(
                                      hintText: 'Kiriting'.tr,
                                      labelStyle: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                                      hintStyle: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: _getController.height.value * 0.02),
                                SizedBox(
                                  width: _getController.width.value,
                                  height: _getController.height.value * 0.06,
                                  child: ElevatedButton(
                                    onPressed: () {
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text('Yuborish'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.background)))
                                ),
                                SizedBox(height: _getController.height.value * 0.033),
                                Text('Izohlar'.tr, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.bold)),

                                if (_getController.productDetailModel.value.data!.comments!.isNotEmpty)
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    semanticChildCount: _getController.productDetailModel.value.data?.comments!.length,
                                    addAutomaticKeepAlives: true,
                                    primary: true,
                                    addRepaintBoundaries: true,
                                    scrollDirection: Axis.vertical,
                                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                    findChildIndexCallback: (key) => null,
                                    itemCount: _getController.productDetailModel.value.data?.comments!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          margin: EdgeInsets.only(bottom: _getController.height.value * 0.02),
                                          padding: EdgeInsets.only(left: _getController.width.value * 0.02, right: _getController.width.value * 0.02, top: _getController.height.value * 0.01, bottom: _getController.height.value * 0.01),
                                          decoration: BoxDecoration(
                                            color: AppColors.grey.withOpacity(0.1),
                                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                                            border: Border.all(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2), width: 1),
                                          ),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                        width: _getController.width.value * 0.12,
                                                        height: _getController.width.value * 0.12,
                                                        margin: EdgeInsets.only(right: _getController.width.value * 0.03),
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: DecorationImage(image: NetworkImage(_getController.productDetailModel.value.data?.comments![index].user?.avatar ?? '',), fit: BoxFit.cover))
                                                    ),
                                                    Expanded(
                                                        child: Text(
                                                            _getController.productDetailModel.value.data?.comments![index].user?.fullName ?? '',
                                                            style: TextStyle(
                                                                fontSize: _getController.width.value * 0.04,
                                                                fontWeight: FontWeight.w500,
                                                                color: Theme.of(context).colorScheme.onBackground
                                                            )
                                                        )
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: _getController.height.value * 0.01),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: _getController.width.value * 0.32,
                                                      child: RatingBar.builder(
                                                          initialRating: _getController.productDetailModel.value.data?.comments![index].rate?.toDouble() ?? 0,
                                                          minRating: 0,
                                                          direction: Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemSize: _getController.width.value * 0.06,
                                                          itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                                                          onRatingUpdate: (rating) {}
                                                      ),
                                                    ),
                                                    Expanded(child:
                                                    Text(
                                                        DateTime.parse(_getController.productDetailModel.value.data?.comments![index].createdAt ?? '').toString().substring(0, 10),
                                                        maxLines: 1,
                                                        style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))
                                                    ))
                                                  ],
                                                ),
                                                SizedBox(height: _getController.height.value * 0.01),
                                                Text(
                                                    _getController.productDetailModel.value.data?.comments![index].description ?? '',
                                                    style: TextStyle(
                                                        fontSize: _getController.width.value * 0.04,
                                                        fontWeight: FontWeight.w400,
                                                        color: Theme.of(context).colorScheme.onBackground
                                                    )
                                                )
                                              ]
                                          )
                                      );
                                    }
                                ),
                                if (_getController.productDetailModel.value.data!.comments!.isEmpty)
                                  Container(
                                    width: _getController.width.value,
                                    height: _getController.height.value * 0.11,
                                    margin: EdgeInsets.only(top: _getController.height.value * 0.015),
                                    decoration: BoxDecoration(
                                      color: AppColors.grey.withOpacity(0.1),
                                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2), width: 1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          TablerIcons.message_circle_cancel,
                                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                                          size: _getController.width.value * 0.1,
                                        ),
                                        Text('Izohlar yo\'q'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)))
                                      ],
                                    ),
                                  )
                              ],
                            )
                        ),
                        SizedBox(height: _getController.height.value * 0.214)
                      ]
                  ) : SizedBox(
                      height: _getController.height.value,
                      width: _getController.width.value,
                      child: Center(child: Text('Ma\'lumotlar yo\'q!'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500))))
                  )
                )
              ),
              Positioned(
                  bottom: 0, left:  0, right: 0,
                  child: Obx(() => SizedBox(
                      height: _getController.height.value * 0.12,
                      width: _getController.width.value,
                      child: Expanded(
                        child: Container(
                          height: _getController.height.value * 0.1,
                          width: _getController.width.value * 0.5,
                          padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, -1)
                              )
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (_getController.productDetailModel.value.data != null)
                                Expanded(
                                    child: _getController.productDetailModel.value.data != null
                                        ? Text('${_getController.productDetailModel.value.data!.price} so\'m', style: TextStyle(fontSize: _getController.width.value * 0.045, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onBackground)) : const SizedBox()),
                              SizedBox(
                                width: _getController.width.value * 0.35,
                                height: _getController.height.value * 0.06,
                                child: ElevatedButton(
                                  onPressed: () {
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text('Xarid'.tr, style: TextStyle(
                                      fontSize: _getController.width.value * 0.04,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).colorScheme.background)
                                  ),
                                ),
                              ),
                              Container(
                                width: _getController.width.value * 0.13,
                                height: _getController.height.value * 0.06,
                                margin: EdgeInsets.only(left: _getController.width.value * 0.02),
                                child: IconButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  icon: Icon(
                                    TablerIcons.shopping_bag,
                                    color: Theme.of(context).colorScheme.background,
                                    size: _getController.width.value * 0.07,
                                  ),
                                  onPressed: () {
                                  },
                                ),
                              ),

                            ],
                          ),
                        )
                      )
                    )
                  )
              )
            ]
          )
      )
    );
  }
}