import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flip_widget_flutter/flip_widget_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

import '../../controllers/get_controller.dart';

class BookPage extends StatefulWidget {
  final String url;
  final String title;

  const BookPage({super.key, required this.url, required this.title});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final GetController _getController = Get.put(GetController());

  Offset _oldPosition = Offset.zero;

  final double _MinNumber = 0.008;

  double _clampMin(double v) {
    if (v < _MinNumber && v > -_MinNumber) {
      if (v >= 0) {
        v = _MinNumber;
      } else {
        v = -_MinNumber;
      }
    }
    return v;
  }

  Future<void> _downloadPDF() async {
    try {
      var response = await http.get(Uri.parse(widget.url));
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/book.pdf");
      _getController.filePath.value = file.path;
      await file.writeAsBytes(response.bodyBytes);
    } catch (e) {
      print("Error downloading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    _downloadPDF();
    _getController.currentPage.value = 0;
    _getController.totalPages.value = 0;
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                _getController.goToPreviousPage();
              }
            ),
            Obx(() => Text('${_getController.currentPage.value + 1}/${_getController.totalPages.value}')),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _getController.goToNextPage();
              },
            )
          ]
      ),
      body: Obx(() {
        if (_getController.filePath.value.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            // PDFView widget for current page
            Positioned.fill(
                child: PDFView(
                    filePath: _getController.filePath.value,
                    enableSwipe: false,
                    swipeHorizontal: false,
                    autoSpacing: true,
                    pageFling: true,
                    onRender: (pages) {
                      _getController.totalPages.value = pages!;
                    },
                    onViewCreated: (PDFViewController vc) {
                      _getController.pdfController = vc;
                    },
                    onPageChanged: (page, total) {
                      _getController.currentPage.value = page!;
                    },
                    onError: (error) {
                      print(error.toString());
                    },
                    onPageError: (page, error) {
                      print('$page: ${error.toString()}');
                    }
                )
            ),
            // FlipWidget for page flipping animation
            Positioned.fill(
              child: GestureDetector(
                onHorizontalDragStart: (details) {
                  _oldPosition = details.globalPosition;
                  _getController.flipKey.value.currentState?.startFlip();
                },
                onHorizontalDragUpdate: (details) {
                  Offset off = details.globalPosition - _oldPosition;
                  double tilt = 1 / _clampMin((-off.dy + 20) / 100);
                  double percent = math.max(0, -off.dx / _getController.width.value * 1.4);
                  percent = percent - percent / 2 * (1 - 1 / tilt);
                  _getController.flipKey.value.currentState?.flip(percent, tilt);
                },
                onHorizontalDragEnd: (details) {
                  _getController.flipKey.value.currentState?.stopFlip();
                  if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
                    _getController.goToNextPage();
                  } else if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
                    _getController.goToPreviousPage();
                  }
                },
                onHorizontalDragCancel: () {
                  _getController.flipKey.value.currentState?.stopFlip();
                },
                child: FlipWidget(
                  key: _getController.flipKey.value,
                  textureSize: Size(
                    _getController.width.value * 2,
                    _getController.height.value * 2,
                  ),
                  child: PDFView(
                    filePath: _getController.filePath.value,
                    enableSwipe: false,
                    swipeHorizontal: false,
                    autoSpacing: true,
                    pageFling: true,
                    onRender: (pages) {
                      _getController.totalPages.value = pages!;
                    },
                    onViewCreated: (PDFViewController vc) {
                      _getController.pdfController = vc;
                    },
                    onPageChanged: (page, total) {
                      _getController.currentPage.value = page!;
                    },
                    onError: (error) {
                      print(error.toString());
                    },
                    onPageError: (page, error) {
                      print('$page: ${error.toString()}');
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}