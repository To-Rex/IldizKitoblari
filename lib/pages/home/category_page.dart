import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ildiz/pages/home/detail_page.dart';
import '../../companents/app_bar.dart';
import '../../companents/category_item.dart';
import '../../controllers/get_controller.dart';

class CategoryPage extends StatelessWidget {
  var menuIndex;

  CategoryPage({super.key, required this.menuIndex});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_getController.height.value * 0.06),
        child: MyAppBar(title: 'Kategoriya'),
      ),
        /*{
          "message": "Ok!",
          "status": true,
          "data": {
            "result": [
              {
                "_id": "6409d5d31b6f87596a657a5a",
                "title": {
                  "uz": "Kitoblar",
                  "oz": "Китоблар",
                  "ru": "Книги"
                },
                "slug": "kitoblar",
                "link": "",
                "menu_id": null,
                "is_static": false,
                "order": 1,
                "is_footer": false,
                "is_header": true,
                "short_content": {
                  "uz": "",
                  "oz": "",
                  "ru": ""
                },
                "children": [
                  {
                    "_id": "6409d73a029a90759dacedfe",
                    "title": {
                      "uz": "Badiiy kitoblar",
                      "oz": "Бадиий китоблар",
                      "ru": "Художественные книги"
                    },
                    "slug": "badiiy-kitoblar",
                    "link": "",
                    "menu_id": "6409d5d31b6f87596a657a5a",
                    "is_static": false,
                    "order": 1,
                    "is_footer": false,
                    "is_header": true,
                    "short_content": {
                      "uz": "",
                      "oz": "",
                      "ru": ""
                    },
                    "banner": null
                  },
                  {
                    "_id": "64548262dbf73cf417069baa",
                    "title": {
                      "uz": "Diniy",
                      "oz": "Диний",
                      "ru": "Религиозный"
                    },
                    "slug": "diniy",
                    "link": "",
                    "menu_id": "6409d5d31b6f87596a657a5a",
                    "short_content": {
                      "uz": "",
                      "oz": "",
                      "ru": ""
                    },
                    "is_static": false,
                    "is_header": true,
                    "is_footer": false,
                    "order": 2,
                    "children": [
                      {
                        "_id": "645490fadbf73cf41706a7a2",
                        "title": {
                          "uz": "Fiqhga oid",
                          "oz": "Фиқҳга оид ",
                          "ru": "Фиқҳга оид "
                        },
                        "slug": "fiqhga-oid",
                        "link": "",
                        "menu_id": "64548262dbf73cf417069baa",
                        "short_content": {
                          "uz": "",
                          "oz": "",
                          "ru": ""
                        },
                        "is_static": false,
                        "is_header": true,
                        "is_footer": false,
                        "order": 1,
                        "banner": null
                      },
                      {
                        "_id": "6454ccf8dbf73cf41706af9a",
                        "title": {
                          "uz": "Aqoid ilmlari",
                          "oz": "Ақоид илмлари",
                          "ru": "Ақоид илмлари"
                        },
                        "slug": "aqoid-ilmlari",
                        "link": "",
                        "menu_id": "64548262dbf73cf417069baa",
                        "short_content": {
                          "uz": "",
                          "oz": "",
                          "ru": ""
                        },
                        "is_static": false,
                        "is_header": true,
                        "is_footer": false,
                        "order": 2,
                        "banner": null
                      },
                      {
                        "_id": "6454cdb9dbf73cf41706afa7",
                        "title": {
                          "uz": "Siyrat",
                          "oz": "Сийрат",
                          "ru": "Сира"
                        },
                        "slug": "siyrat",
                        "link": "",
                        "menu_id": "64548262dbf73cf417069baa",
                        "short_content": {
                          "uz": "",
                          "oz": "",
                          "ru": ""
                        },
                        "is_static": false,
                        "is_header": true,
                        "is_footer": false,
                        "order": 3,
                        "banner": null
                      },
                      {
                        "_id": "6454ce04dbf73cf41706afad",
                        "title": {
                          "uz": "Sahobalar va tobeinlar",
                          "oz": "Саҳобалар ва тобеинлар",
                          "ru": "Саҳобалар ва тобеинлар"
                        },
                        "slug": "sahobalar-va-tobeinlar",
                        "link": "",
                        "menu_id": "64548262dbf73cf417069baa",
                        "short_content": {
                          "uz": "",
                          "oz": "",
                          "ru": ""
                        },
                        "is_static": false,
                        "is_header": true,
                        "is_footer": false,
                        "order": 4,
                        "banner": null
                      },
                      {
                        "_id": "6454ce66dbf73cf41706afbf",
                        "title": {
                          "uz": "Hadis kitoblari",
                          "oz": "Ҳадис китоблари",
                          "ru": "Ҳадис китоблари"
                        },
                        "slug": "hadis-kitoblari",
                        "link": "",
                        "menu_id": "64548262dbf73cf417069baa",
                        "short_content": {
                          "uz": "",
                          "oz": "",
                          "ru": ""
                        },
                        "is_static": false,
                        "is_header": true,
                        "is_footer": false,
                        "order": 5,
                        "banner": null
                      },
                      {
                        "_id": "6454cec2dbf73cf41706afc5",
                        "title": {
                          "uz": "Duolar kitobi",
                          "oz": "Дуолар китоби",
                          "ru": "Дуолар китоби"
                        },
                        "slug": "duolar-kitobi",
                        "link": "",
                        "menu_id": "64548262dbf73cf417069baa",
                        "short_content": {
                          "uz": "",
                          "oz": "",
                          "ru": ""
                        },
                        "is_static": false,
                        "is_header": true,
                        "is_footer": false,
                        "order": 6,
                        "banner": null
                      },
                      {
                        "_id": "6454cf99dbf73cf41706afd9",
                        "title": {
                          "uz": "Ruhiy tarbiya",
                          "oz": "Руҳий тарбия",
                          "ru": "Руҳий тарбия"
                        },
                        "slug": "ruhiy-tarbiya",
                        "link": "",
                        "menu_id": "64548262dbf73cf417069baa",
                        "short_content": {
                          "uz": "",
                          "oz": "",
                          "ru": ""
                        },
                        "is_static": false,
                        "is_header": true,
                        "is_footer": false,
                        "order": 7,
                        "banner": null
                      },
                      {
                        "_id": "6454cfe0dbf73cf41706afdf",
                        "title": {
                          "uz": "Darsliklar",
                          "oz": "Дарсликлар",
                          "ru": "Дарсликлар"
                        },
                        "slug": "darsliklar",
                        "link": "",
                        "menu_id": "64548262dbf73cf417069baa",
                        "short_content": {
                          "uz": "",
                          "oz": "",
                          "ru": ""
                        },
                        "is_static": false,
                        "is_header": true,
                        "is_footer": false,
                        "order": 8,
                        "banner": null
                      },
                      {
                        "_id": "64ef0e2a42f8c222198c89f6",
                        "title": {
                          "uz": "Tafsir",
                          "oz": "Тафсир",
                          "ru": "Тафсир"
                        },
                        "slug": "tafsir",
                        "link": "",
                        "menu_id": "64548262dbf73cf417069baa",
                        "short_content": {
                          "uz": "",
                          "oz": "",
                          "ru": ""
                        },
                        "is_static": false,
                        "is_header": true,
                        "is_footer": false,
                        "order": 9,
                        "banner": null
                      }
                    ],
                    "banner": null
                  },
                  {
                    "_id": "645482dbdbf73cf417069bba",
                    "title": {
                      "uz": "Biznes va marketing",
                      "oz": "Бизнес ва маркетинг",
                      "ru": "Бизнес и маркетинг"
                    },
                    "slug": "biznes-va-marketing",
                    "link": "",
                    "menu_id": "6409d5d31b6f87596a657a5a",
                    "short_content": {
                      "uz": "",
                      "oz": "",
                      "ru": ""
                    },
                    "is_static": false,
                    "is_header": true,
                    "is_footer": false,
                    "order": 3,
                    "banner": null
                  },
                  {
                    "_id": "6572bc8418e8d01d7332eba1",
                    "title": {
                      "uz": "Shaxsiy rivojlanish",
                      "oz": "Шахсий ривожланиш",
                      "ru": "Личностное развитие"
                    },
                    "slug": "shaxsiy-rivojlanish",
                    "link": "",
                    "menu_id": "6409d5d31b6f87596a657a5a",
                    "short_content": {
                      "uz": "",
                      "oz": "",
                      "ru": ""
                    },
                    "is_static": false,
                    "is_header": true,
                    "is_footer": false,
                    "order": 5,
                    "banner": null
                  },
                  {
                    "_id": "64f34d3b42f8c222198e1f5b",
                    "title": {
                      "uz": "Oila",
                      "oz": "Оила",
                      "ru": "Семья"
                    },
                    "slug": "oila",
                    "link": "",
                    "menu_id": "6409d5d31b6f87596a657a5a",
                    "short_content": {
                      "uz": "",
                      "oz": "",
                      "ru": ""
                    },
                    "is_static": false,
                    "is_header": true,
                    "is_footer": false,
                    "order": 5,
                    "banner": null
                  },
                  {
                    "_id": "64f2ec2442f8c222198df047",
                    "title": {
                      "uz": "Tarix va siyosat",
                      "oz": "Тарих ва сиёсат",
                      "ru": "История и политика"
                    },
                    "slug": "tarix-va-siyosat",
                    "link": "",
                    "menu_id": "6409d5d31b6f87596a657a5a",
                    "short_content": {
                      "uz": "",
                      "oz": "",
                      "ru": ""
                    },
                    "is_static": false,
                    "is_header": true,
                    "is_footer": false,
                    "order": 5,
                    "banner": null
                  },
                  {
                    "_id": "645483b0dbf73cf417069bc6",
                    "title": {
                      "uz": "Xorijiy tildagi kitoblar",
                      "oz": "Хорижий тилдаги китоблар",
                      "ru": "Книги на иностранных языках"
                    },
                    "slug": "xorijiy-tildagi-kitoblar",
                    "link": "",
                    "menu_id": "6409d5d31b6f87596a657a5a",
                    "short_content": {
                      "uz": "",
                      "oz": "",
                      "ru": ""
                    },
                    "is_static": false,
                    "is_header": true,
                    "is_footer": false,
                    "order": 5,
                    "banner": null
                  },
                  {
                    "_id": "64f5830542f8c222198f30d1",
                    "title": {
                      "uz": "Boshqa kitoblar",
                      "oz": "Бошқа китоблар",
                      "ru": "Другие книги"
                    },
                    "slug": "boshqa-kitoblar",
                    "link": "",
                    "menu_id": "6409d5d31b6f87596a657a5a",
                    "short_content": {
                      "uz": "",
                      "oz": "",
                      "ru": ""
                    },
                    "is_static": false,
                    "is_header": true,
                    "is_footer": false,
                    "order": 6,
                    "banner": null
                  },
                  {
                    "_id": "64c3f93eb34ce2f367353694",
                    "title": {
                      "uz": "Kundaliklar",
                      "oz": "Kundaliklar",
                      "ru": "Kundaliklar"
                    },
                    "slug": "kundaliklar",
                    "link": "",
                    "menu_id": "6409d5d31b6f87596a657a5a",
                    "short_content": {
                      "uz": "",
                      "oz": "",
                      "ru": ""
                    },
                    "is_static": false,
                    "is_header": true,
                    "is_footer": false,
                    "order": 6,
                    "banner": null
                  },
                  {
                    "_id": "64de241428745f8339ffe76b",
                    "title": {
                      "uz": "Plakatlar",
                      "oz": "Плакатлар",
                      "ru": "Плакаты"
                    },
                    "slug": "plakatlar",
                    "link": "",
                    "menu_id": "6409d5d31b6f87596a657a5a",
                    "short_content": {
                      "uz": "",
                      "oz": "",
                      "ru": ""
                    },
                    "is_static": false,
                    "is_header": true,
                    "is_footer": false,
                    "order": 7,
                    "banner": null
                  }
                ],
                "banner": null
              },
              {
                "_id": "6413f7737197c82736fb62ca",
                "title": {
                  "uz": "Biz haqimizda",
                  "oz": "Биз ҳақимизда",
                  "ru": "О нас"
                },
                "slug": "biz-haqimizda",
                "link": "about",
                "menu_id": null,
                "is_static": true,
                "order": 18,
                "is_footer": true,
                "is_header": false,
                "short_content": {
                  "uz": "Siz \"Ildiz kitoblari\"ni bilasizmi?\n\n   \"Ildiz kitoblari\" 2023-yil 1-oktabrdan boshlab faoliyat ko'rsatib kelmoqda.\"Ildiz kitoblari\"ni siz \"Azon kitoblari\" nomi orqali bilasiz.\"Ildiz kitoblari\" bir necha yildir nafaqat xalqimiz, balki dunyoning ko'p go'shalarida istiqomat qilayotgan millatdoshlarimizning diniy-ma'rifiy, axloqiy, ilmiy, huquqiy saviyasini oshirish yo'lida baqadri imkon xizmat qilib kelmoqda.\"Ildiz kitoblari\" faoliyat olib borayotganiga uncha ko'p vaqt bo'lmasa-da,bu sohada mijozlar ishonchini qozonib,ularni mamnun etib kelmoqda.",
                  "oz": "Сиз \"Илдиз китоблари\"ни биласизми?\n\n   \"Илдиз китоблари\" 2023-йил 1-октабрдан бошлаб фаолият кўрсатиб келмоқда.\"Илдиз китоблари\"ни сиз \"Азон китоблари\" номи орқали биласиз.\"Илдиз китоблари\" бир неча йилдир нафақат халқимиз, балки дунёнинг кўп гўшаларида истиқомат қилаётган миллатдошларимизнинг диний-маърифий, ахлоқий, илмий, ҳуқуқий савиясини ошириш йўлида бақадри имкон хизмат қилиб келмоқда.\"Илдиз китоблари\" фаолият олиб бораётганига унча кўп вақт бўлмаса-да,бу соҳада мижозлар ишончини қозониб,уларни мамнун этиб келмоқда.",
                  "ru": "Сиз \"Илдиз китоблари\"ни биласизми?\n\n   \"Илдиз китоблари\" 2023-йил 1-октабрдан бошлаб фаолият кўрсатиб келмоқда.\"Илдиз китоблари\"ни сиз \"Азон китоблари\" номи орқали биласиз.\"Илдиз китоблари\" бир неча йилдир нафақат халқимиз, балки дунёнинг кўп гўшаларида истиқомат қилаётган миллатдошларимизнинг диний-маърифий, ахлоқий, илмий, ҳуқуқий савиясини ошириш йўлида бақадри имкон хизмат қилиб келмоқда.\"Илдиз китоблари\" фаолият олиб бораётганига унча кўп вақт бўлмаса-да,бу соҳада мижозлар ишончини қозониб,уларни мамнун этиб келмоқда."
                },
                "banner": null
              }
            ],
            "count": 67
          }
        }*/
      body: Obx(() => _getController.menuModel.value.data!.result![menuIndex].children == null
                ? Center(child: Text('Ma\'lumotlar yo\'q!'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w600)))
                : Expanded(
                    child: ListView.builder(
                      itemCount: _getController.menuModel.value.data!.result?[menuIndex].children!.length,
                      itemBuilder: (context, index) {
                        return CategoryItem(
                          _getController.menuModel.value.data!.result![menuIndex].children![index].sId!,
                          'uz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.uz! : 'oz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.oz! : _getController.menuModel.value.data!.result![menuIndex].children![index].title!.ru!,
                          () {
                            print('CategoryItem: ${_getController.menuModel.value.data!.result![menuIndex].children![index].title!.uz!}');
                            Get.to(() => DetailPage(title: 'uz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.uz! : 'oz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.oz! : _getController.menuModel.value.data!.result![menuIndex].children![index].title!.ru!));
                          },
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
