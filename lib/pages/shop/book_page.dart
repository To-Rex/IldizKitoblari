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

  final double minNumber = 0.008;

  double _clampMin(double v) {
    if (v < minNumber && v > -minNumber) {
      if (v >= 0) {
        v = minNumber;
      } else {
        v = -minNumber;
      }
    }
    return v;
  }

  Future<void> _downloadPDF() async {
    _getController.currentPageBack.value = 1;
    _getController.currentPage.value = 0;
    _getController.totalPages.value = 0;
    try {
      var response = await http.get(Uri.parse(widget.url));
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/book.pdf");
      _getController.filePath.value = file.path;
      await file.writeAsBytes(response.bodyBytes);
      _getController.setBackController();
      _renderPDF();
      _getController.setBackController();
    } catch (e) {
      debugPrint("Error downloading PDF: $e");
    }
  }

  Future<void> _renderPDF() async {
    try {
      if (_getController.filePath.value.isNotEmpty) {
        final pdf = PDFView(
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
            debugPrint(error.toString());
          },
          onPageError: (page, error) {
            debugPrint('$page: ${error.toString()}');
          },
        );
        pdf.onRender;
      }
    } catch (e) {
      debugPrint("Error rendering PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    _downloadPDF();
    return Obx(() => Scaffold(
        appBar: _getController.isFullScreen.isTrue
        ? AppBar(
            title: Text(widget.title),
            actions: [
              IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.onSurface,size: Get.width * 0.05),
                  onPressed: () {
                    _getController.goToPreviousPage();
                  }
              ),
              //Obx(() => Text('${_getController.currentPage.value + 1}/${_getController.totalPages.value}')),
              Text('${_getController.currentPage.value + 1}/${_getController.totalPages.value}'),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.onSurface,size: Get.width * 0.05),
                onPressed: () {
                  _getController.goToNextPage();
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.onSurface,size: Get.width * 0.05),
                onPressed: () {
                  _getController.toggleFullScreen();
                },
              ),

            ]
        )
        : null,
        body: _getController.filePath.value.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Stack(
        children: [
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
                    _getController.pdfBackController = vc;
                  },
                  onPageChanged: (page, total) {
                    _getController.currentPageBack.value = page!;
                  },
                  onError: (error) {
                    debugPrint(error.toString());
                  },
                  onPageError: (page, error) {
                    debugPrint('$page: ${error.toString()}');
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
                          _getController.width.value * 6,
                          _getController.height.value * 6
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
                            debugPrint(error.toString());
                          },
                          onPageError: (page, error) {
                            debugPrint('$page: ${error.toString()}');
                          }
                      )
                  )
              )
          )
        ]
    )
    ));
  }
}