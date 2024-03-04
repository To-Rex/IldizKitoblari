import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../companents/category_item.dart';
import '../../controllers/get_controller.dart';
import 'cat_detail_page.dart';

class SubCategoryPage extends StatelessWidget {
  var title;
  var menuSlug;
  var menuIndex;
  var index;

  SubCategoryPage(
      {super.key,
      required this.title,
      required this.menuSlug,
      required this.menuIndex,
      required this.index});

  final GetController _getController = Get.put(GetController());

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
  "_id": "64548332dbf73cf417069bc0",
  "title": {
  "uz": "Bolalar uchun",
  "oz": "Болалар учун",
  "ru": "Для детей"
  },
  "slug": "bolalar-uchun",
  "link": "",
  "menu_id": null,
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
  "_id": "64f7251542f8c222198f9162",
  "title": {
  "uz": "Farzand tarbiyasi",
  "oz": "Фарзанд тарбияси",
  "ru": "Образование детей"
  },
  "slug": "farzand-tarbiyasi",
  "link": "",
  "menu_id": "64548332dbf73cf417069bc0",
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
  "_id": "65072a9e7dbfeb465fdfd96e",
  "title": {
  "uz": "Bolalar uchun ",
  "oz": "Болалар учун",
  "ru": "Болалар учун"
  },
  "slug": "bolalar-uchun-",
  "link": "",
  "menu_id": "64548332dbf73cf417069bc0",
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
  }
  ],
  "banner": null
  },
  {
  "_id": "64d76fe196c5555d04fede77",
  "title": {
  "uz": "Disklar",
  "oz": "Дисклар",
  "ru": "Диски"
  },
  "slug": "disklar",
  "link": "",
  "menu_id": null,
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
  "_id": "643a644c590e7e6f7fb9321e",
  "title": {
  "uz": "Ibodat anjomlari",
  "oz": "Ибодат анжомлари",
  "ru": "Молитвенные наборы"
  },
  "slug": "ibodat-anjomlari",
  "link": "",
  "menu_id": null,
  "is_static": false,
  "is_header": true,
  "is_footer": false,
  "order": 3,
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "children": [
  {
  "_id": "6454d3a4dbf73cf41706b0f9",
  "title": {
  "uz": "Do'ppilar",
  "oz": "Дўппилар",
  "ru": "Дўппилар"
  },
  "slug": "doppilar",
  "link": "",
  "menu_id": "643a644c590e7e6f7fb9321e",
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "is_static": false,
  "is_header": true,
  "is_footer": false,
  "order": 1,
  "children": [
  {
  "_id": "6454d995dbf73cf41706b251",
  "title": {
  "uz": "Bangladesh",
  "oz": "Бангладеш",
  "ru": "Бангладеш"
  },
  "slug": "bangladesh",
  "link": "",
  "menu_id": "6454d3a4dbf73cf41706b0f9",
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
  "_id": "6454da0bdbf73cf41706b262",
  "title": {
  "uz": "chechen",
  "oz": "Чечен",
  "ru": "Чечен"
  },
  "slug": "chechen",
  "link": "",
  "menu_id": "6454d3a4dbf73cf41706b0f9",
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
  "_id": "6454da89dbf73cf41706b290",
  "title": {
  "uz": "Milliy",
  "oz": "Миллий",
  "ru": "Национальный"
  },
  "slug": "milliy",
  "link": "",
  "menu_id": "6454d3a4dbf73cf41706b0f9",
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
  "_id": "64dcd0788c6e134962b1ec12",
  "title": {
  "uz": "Chet elda ishlab chiqarilgan",
  "oz": "Чет элда ишлаб чиқарилган",
  "ru": "Сделано за границей"
  },
  "slug": "chet-elda-ishlab-chiqarilgan",
  "link": "",
  "menu_id": "6454d3a4dbf73cf41706b0f9",
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
  "_id": "64dcd9818c6e134962b1f559",
  "title": {
  "uz": "To'qilgan do'ppilar",
  "oz": "Тўқилган дўппилар",
  "ru": "Вязаные тюбетейки"
  },
  "slug": "toqilgan-doppilar",
  "link": "",
  "menu_id": "6454d3a4dbf73cf41706b0f9",
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
  }
  ],
  "banner": null
  },
  {
  "_id": "643a6480590e7e6f7fb93224",
  "title": {
  "uz": "Joynamozlar",
  "oz": "Жойнамозлар",
  "ru": "Молитвенные коврики"
  },
  "slug": "joynamozlar",
  "link": "",
  "menu_id": "643a644c590e7e6f7fb9321e",
  "is_static": false,
  "is_header": true,
  "is_footer": false,
  "order": 2,
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "banner": null
  },
  {
  "_id": "6454d875dbf73cf41706b220",
  "title": {
  "uz": "Tasbehlar",
  "oz": "Тасбеҳлар",
  "ru": "Четки"
  },
  "slug": "tasbehlar",
  "link": "",
  "menu_id": "643a644c590e7e6f7fb9321e",
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
  "_id": "6454d943dbf73cf41706b226",
  "title": {
  "uz": "Boshqa anjomlar",
  "oz": "Бошқа анжомлар",
  "ru": "Другие наборы"
  },
  "slug": "boshqa-anjomlar",
  "link": "",
  "menu_id": "643a644c590e7e6f7fb9321e",
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
  }
  ],
  "banner": null
  },
  {
  "_id": "6482f3e29adac94f5d9c1ae8",
  "title": {
  "uz": "Mus'haflar",
  "oz": "Мусъҳафлар",
  "ru": "Мусҳафы"
  },
  "slug": "mushaflar",
  "link": "",
  "menu_id": null,
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "is_static": false,
  "is_header": true,
  "is_footer": false,
  "order": 4,
  "children": [
  {
  "_id": "6409cb611b6f87596a6579ad",
  "title": {
  "uz": "Tajvidli",
  "oz": "Тажвидли",
  "ru": "С таджвидом"
  },
  "slug": "tajvidli",
  "link": "",
  "menu_id": "6482f3e29adac94f5d9c1ae8",
  "is_static": false,
  "order": 1,
  "is_footer": false,
  "is_header": false,
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "banner": null
  },
  {
  "_id": "64547d6adbf73cf417069859",
  "title": {
  "uz": "Mavzuli",
  "oz": "Мавзули",
  "ru": "Тематический"
  },
  "slug": "mavzuli",
  "link": "",
  "menu_id": "6482f3e29adac94f5d9c1ae8",
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "is_static": false,
  "is_header": false,
  "is_footer": false,
  "order": 2,
  "banner": null
  },
  {
  "_id": "64548023dbf73cf417069a9c",
  "title": {
  "uz": "Tajvidsiz",
  "oz": "Тажвидсиз",
  "ru": "Без таджвида"
  },
  "slug": "tajvidsiz",
  "link": "",
  "menu_id": "6482f3e29adac94f5d9c1ae8",
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "is_static": false,
  "is_header": false,
  "is_footer": false,
  "order": 3,
  "banner": null
  },
  {
  "_id": "64548061dbf73cf417069acd",
  "title": {
  "uz": "Poralik",
  "oz": "Поралик",
  "ru": "В отдельных 30 джузах"
  },
  "slug": "poralik",
  "link": "",
  "menu_id": "6482f3e29adac94f5d9c1ae8",
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "is_static": false,
  "is_header": false,
  "is_footer": false,
  "order": 4,
  "banner": null
  },
  {
  "_id": "645480a9dbf73cf417069ad7",
  "title": {
  "uz": "Ruchkali",
  "oz": "Ручкали",
  "ru": "С ручкой"
  },
  "slug": "ruchkali",
  "link": "",
  "menu_id": "6482f3e29adac94f5d9c1ae8",
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "is_static": false,
  "is_header": false,
  "is_footer": false,
  "order": 5,
  "banner": null
  },
  {
  "_id": "64da07ba96c5555d04ff6980",
  "title": {
  "uz": "Muqovalar",
  "oz": "Муқовалар",
  "ru": "Oболочки"
  },
  "slug": "muqovalar",
  "link": "",
  "menu_id": "6482f3e29adac94f5d9c1ae8",
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
  }
  ],
  "banner": null
  },
  {
  "_id": "6454df0adbf73cf41706b3a0",
  "title": {
  "uz": "Mushklar",
  "oz": "Мушклар",
  "ru": "Мускусы"
  },
  "slug": "mushklar",
  "link": "",
  "menu_id": null,
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "is_static": false,
  "is_header": true,
  "is_footer": false,
  "order": 5,
  "children": [
  {
  "_id": "6454e0a6dbf73cf41706b3a6",
  "title": {
  "uz": "Ayollar uchun",
  "oz": "Аёллар учун",
  "ru": "Для женщин"
  },
  "slug": "ayollar-uchun",
  "link": "",
  "menu_id": "6454df0adbf73cf41706b3a0",
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
  "_id": "6454e0f2dbf73cf41706b3ac",
  "title": {
  "uz": "Erkaklar uchun",
  "oz": "Эркаклар учун",
  "ru": "Для мужчин"
  },
  "slug": "erkaklar-uchun",
  "link": "",
  "menu_id": "6454df0adbf73cf41706b3a0",
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
  "_id": "6454e276dbf73cf41706b442",
  "title": {
  "uz": "Atirlar",
  "oz": "Атирлар",
  "ru": "Духи"
  },
  "slug": "atirlar",
  "link": "",
  "menu_id": "6454e0f2dbf73cf41706b3ac",
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
  "_id": "6454e542dbf73cf41706b502",
  "title": {
  "uz": "Mushklar",
  "oz": "Мушклар",
  "ru": "Мускусы"
  },
  "slug": "mushklarchild",
  "link": "",
  "menu_id": "6454e0f2dbf73cf41706b3ac",
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
  }
  ],
  "banner": null
  },
  {
  "_id": "64d0cd8996c5555d04fd8b55",
  "title": {
  "uz": "Buxurlar",
  "oz": "Бухурлар",
  "ru": "Бухурлар"
  },
  "slug": "buxurlar",
  "link": "",
  "menu_id": "6454df0adbf73cf41706b3a0",
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
  "_id": "64d5c85496c5555d04fe8cc0",
  "title": {
  "uz": "Uy,ofis uchun",
  "oz": "Уй, офис учун",
  "ru": "Для дома,офиса"
  },
  "slug": "uyofis-uchun",
  "link": "",
  "menu_id": "6454df0adbf73cf41706b3a0",
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
  }
  ],
  "banner": {
  "_id": "648dd855e5d5f27a0f370878",
  "name": "Mushklar",
  "link": "https://ildizkitoblari.uz/products/mushklarchild/maqomi-ibrohim",
  "menu": "6454df0adbf73cf41706b3a0",
  "status": true,
  "image_uz": "https://ildizkitoblari.uz/public/files/2023-07-18T07-15-35.587Z_ÐÐ¸Ð·Ð°Ð¹Ð½ Ð±ÐµÐ· Ð½Ð°Ð·Ð²Ð°Ð½Ð¸Ñ (19).png",
  "image_oz": "https://ildizkitoblari.uz/public/files/2023-09-17T16-29-59.591Z_160d1adac1e67f559464962cac96f421.jpg",
  "image_ru": "https://ildizkitoblari.uz/public/files/2023-07-10T14-32-55.944Z_ÐÐ¸Ð·Ð°Ð¹Ð½ Ð±ÐµÐ· Ð½Ð°Ð·Ð²Ð°Ð½Ð¸Ñ (3).png"
  }
  },
  {
  "_id": "6454dbd9dbf73cf41706b2c2",
  "title": {
  "uz": "Sovg'abop to'plamlar",
  "oz": "Совғабоп тўпламлар",
  "ru": "Подарочные наборы"
  },
  "slug": "sovgabop-toplamlar",
  "link": "",
  "menu_id": null,
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "is_static": false,
  "is_header": true,
  "is_footer": false,
  "order": 5,
  "children": [
  {
  "_id": "64f1888742f8c222198d5710",
  "title": {
  "uz": "Soatlar",
  "oz": "Соатлар",
  "ru": "Соатлар"
  },
  "slug": "soatlar",
  "link": "",
  "menu_id": "6454dbd9dbf73cf41706b2c2",
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
  "_id": "6454dce8dbf73cf41706b36d",
  "title": {
  "uz": "Suvenirlar",
  "oz": "Сувенирлар",
  "ru": "Сувениры"
  },
  "slug": "suvenirlar",
  "link": "",
  "menu_id": "6454dbd9dbf73cf41706b2c2",
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
  "_id": "6454dd48dbf73cf41706b373",
  "title": {
  "uz": "To'plamlar",
  "oz": "Тўпламлар",
  "ru": "Наборы"
  },
  "slug": "toplamlar",
  "link": "",
  "menu_id": "6454dbd9dbf73cf41706b2c2",
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
  "_id": "64d9eba796c5555d04ff5fe9",
  "title": {
  "uz": "Qur'on tilovati jamlangan audiotexnikalar",
  "oz": "Қуръон тиловати жамланган аудиотехникалар",
  "ru": "Аудиотехника чтения Корана"
  },
  "slug": "quron-tilovati-jamlangan-audiotexnikalar",
  "link": "",
  "menu_id": "6454dbd9dbf73cf41706b2c2",
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
  "_id": "64ddabd592888bdc47d808e4",
  "title": {
  "uz": "Fonuslar",
  "oz": "Фонуслар",
  "ru": "Фонуси"
  },
  "slug": "fonuslar",
  "link": "",
  "menu_id": "6454dbd9dbf73cf41706b2c2",
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
  "_id": "64f3337342f8c222198e0c76",
  "title": {
  "uz": "Duo tablichka",
  "oz": "Дуо табличка",
  "ru": "Дуо табличка"
  },
  "slug": "duo-tablichka",
  "link": "",
  "menu_id": "6454dbd9dbf73cf41706b2c2",
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
  "_id": "64f0243242f8c222198d13dc",
  "title": {
  "uz": "Zam-Zam",
  "oz": "Зам-Зам",
  "ru": "Зам-Зам"
  },
  "slug": "zam-zam",
  "link": "",
  "menu_id": "6454dbd9dbf73cf41706b2c2",
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
  "_id": "64de1d1a28745f8339ffe37b",
  "title": {
  "uz": "Misvak",
  "oz": "Мисвак",
  "ru": "Мисвак"
  },
  "slug": "misvak",
  "link": "",
  "menu_id": "6454dbd9dbf73cf41706b2c2",
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
  "_id": "64e2f289b3764b47fc6c2dc8",
  "title": {
  "uz": "Choy",
  "oz": "Чой",
  "ru": "Чай"
  },
  "slug": "choy",
  "link": "",
  "menu_id": "6454dbd9dbf73cf41706b2c2",
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
  "_id": "64f466b742f8c222198ee4e3",
  "title": {
  "uz": "Bookmark",
  "oz": "Bookmark",
  "ru": "Bookmark"
  },
  "slug": "bookmark",
  "link": "",
  "menu_id": "6454dbd9dbf73cf41706b2c2",
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
  "_id": "64f349c742f8c222198e1a92",
  "title": {
  "uz": "Boshqalar",
  "oz": "Бошқалар",
  "ru": "Другие"
  },
  "slug": "boshqalar",
  "link": "",
  "menu_id": "6454dbd9dbf73cf41706b2c2",
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "is_static": false,
  "is_header": true,
  "is_footer": false,
  "order": 10,
  "banner": null
  }
  ],
  "banner": null
  },
  {
  "_id": "6454e74fdbf73cf41706b568",
  "title": {
  "uz": "Tabobat",
  "oz": "Табобат",
  "ru": "Медицина"
  },
  "slug": "tabobat",
  "link": "",
  "menu_id": null,
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "is_static": false,
  "is_header": false,
  "is_footer": false,
  "order": 6,
  "children": [
  {
  "_id": "6454e808dbf73cf41706b593",
  "title": {
  "uz": "Yuz va teri parvarishi",
  "oz": "Юз ва тери парвариши",
  "ru": "Уход за лицом и кожей"
  },
  "slug": "yuz-va-teri-parvarishi",
  "link": "",
  "menu_id": "6454e74fdbf73cf41706b568",
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
  "_id": "6454e912dbf73cf41706b633",
  "title": {
  "uz": "Soch va soqol parvarishi",
  "oz": "Соч ва соқол парвариши",
  "ru": "Уход за волосами и бородой"
  },
  "slug": "soch-va-soqol-parvarishi",
  "link": "",
  "menu_id": "6454e74fdbf73cf41706b568",
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
  "_id": "6454eb54dbf73cf41706b639",
  "title": {
  "uz": "BFQ - vitaminlar, sedana, yog'lar",
  "oz": "БФҚ - витаминлар, седана, ёғлар",
  "ru": "БАД - витамины, седана, жиры"
  },
  "slug": "bfq---vitaminlar-sedana-yoglar",
  "link": "",
  "menu_id": "6454e74fdbf73cf41706b568",
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
  }
  ],
  "banner": null
  },
  {
  "_id": "6409d783029a90759dacee18",
  "title": {
  "uz": "Hamkorlar",
  "oz": "Ҳамкорлар",
  "ru": "Партнеры"
  },
  "slug": "hamkorlar",
  "link": "partners",
  "menu_id": null,
  "is_static": false,
  "order": 9,
  "is_footer": true,
  "is_header": true,
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "banner": null
  },
  {
  "_id": "6454a07cdbf73cf41706ab7d",
  "title": {
  "uz": "Filiallar",
  "oz": "Филиаллар",
  "ru": "Филиалы"
  },
  "slug": "filiallar",
  "link": "contact",
  "menu_id": null,
  "short_content": {
  "uz": "",
  "oz": "",
  "ru": ""
  },
  "is_static": false,
  "is_header": false,
  "is_footer": true,
  "order": 10,
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

  @override
  Widget build(BuildContext context) {
    print('shuuuuu ${_getController.menuModel.value.data!.result![menuIndex].children![index]!.children![index]!.title!.uz}');
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Obx(() => _getController.menuModel.value.data!.result![menuIndex].children![menuIndex]! == null
            ? Center(child: Text('Ma\'lumotlar yo\'q!'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w600)))
            : Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: _getController.menuModel.value.data!.result![menuIndex].children![index]!.children!.length,
                    itemBuilder: (context, indexs) {
                      return CategoryItem(
                          _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].sId!,
                          'uz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].title!.uz! : 'oz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].title!.oz! : _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].title!.ru!, () {
                        _getController.page.value = 1;
                        _getController.productModelLength.value = 0;
                        _getController.clearProductModel();
                        print('menuIndex: $menuIndex');
                        Get.to(() => CatDetailPage(title: 'uz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].title!.uz! : 'oz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].title!.oz! : _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].title!.ru!, menuSlug: _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].slug!));
                      });
                    }
                ),
              ),
            ])
        )
    );
  }
}
