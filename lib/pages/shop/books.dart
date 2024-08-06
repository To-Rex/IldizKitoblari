import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ildiz/companents/filds/text_small.dart';
import 'package:ildiz/controllers/get_controller.dart';
import 'package:ildiz/resource/colors.dart';
import '../../book_custom_lib/src/book_controller.dart';
import '../../book_custom_lib/src/e_book.dart';
import '../../book_custom_lib/src/ebook_controller.dart';

class BookPages extends StatefulWidget {
  final String url;
  final String title;

  const BookPages({super.key, required this.url, required this.title});

  @override
  State<BookPages> createState() => _BookState();
}

class _BookState extends State<BookPages> {
  final GetController _getController = Get.put(GetController());
  String data = '''''';
  TextEditingController textEditingController = TextEditingController();

  EBookController eBookController = EBookController();
  BookController bookController = BookController();

  @override
  void initState() {
    rootBundle.loadString('assets/ok.txt').then((value) {
      setState(() {
        data = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _getController.whileApi.value = true;
    rootBundle.loadString('assets/ok.txt').then((value) {
      setState(() {
        data = value;
      });
    });
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.blackTransparent,
          surfaceTintColor: AppColors.blackTransparent,
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.format_size),
              onPressed: () {
                Get.defaultDialog(
                    title: 'Font Size',
                    content: Column(
                      children: [
                        TextField(
                          controller: textEditingController,
                          decoration: const InputDecoration(labelText: 'Font Size'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            eBookController.fontSize = double.parse(textEditingController.text);
                            Get.back();
                          },
                          child: const Text('OK'),
                        )
                      ],
                    ));
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                bookController.last();
              },
            ),
            TextSmall(text: '${_getController.currentIndex.value == 0 ? _getController.currentIndex.value + 1 : _getController.currentIndex.value } / ${_getController.allPages.isNotEmpty ? _getController.allPages.length - 1 : 0}', color: Theme.of(context).colorScheme.onSurface, fontSize: Theme.of(context).textTheme.titleSmall!.fontSize, fontWeight: FontWeight.w400),
            IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: () {
              bookController.next();
            })
          ]
        ),
        body: data.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
            children: [
              EBook(
                  maxWidth: MediaQuery.of(context).size.width,
                  eBookController: eBookController,
                  bookController: bookController,
                  duration: const Duration(milliseconds: 400),
                  fontHeight: 1.6,
                  data: data,
                  fontSize: eBookController.fontSize,
                  padding: const EdgeInsetsDirectional.all(15),
                  maxHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQueryData.fromView(window).padding.top -40)
            ]
        )
    );
  }
}