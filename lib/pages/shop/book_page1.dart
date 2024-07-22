/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class BookPage extends StatefulWidget {
  final String url;
  final String title;

  const BookPage({super.key, required this.url, required this.title});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _downloadPDF();
  }

  Future<void> _downloadPDF() async {
    try {
      //if ${dir.path}/book.pdf exists, delete it
      var response = await http.get(Uri.parse(widget.url));
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/book.pdf");
      _filePath = file.path;
      file = await file.writeAsBytes(response.bodyBytes);
      setState(() {});
    } catch (e) {
      print("Error downloading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Page"),
      ),
      body: _filePath != null
          ? PDFView(filePath: _filePath!
        ,nightMode: true,
        fitEachPage: true,
        swipeHorizontal: true,
        pageSnap: true,
        pageFling: true,
        autoSpacing: true,
        onRender: (pages) {},
        onError: (error) {},
        onPageError: (page, error) {},
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}*/

/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flip_widget/flip_widget.dart';
import 'dart:math' as math;

class BookPage extends StatefulWidget {
  final String url;
  final String title;

  const BookPage({super.key, required this.url, required this.title});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  String? _filePath;
  GlobalKey<FlipWidgetState> _flipKey = GlobalKey();
  late PDFViewController _pdfViewController;
  int _currentPage = 0;
  int? _totalPages;

  @override
  void initState() {
    super.initState();
    _downloadPDF();
  }

  Future<void> _downloadPDF() async {
    try {
      var response = await http.get(Uri.parse(widget.url));
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/book.pdf");
      _filePath = file.path;
      file = await file.writeAsBytes(response.bodyBytes);
      setState(() {});
    } catch (e) {
      print("Error downloading PDF: $e");
    }
  }

  void _goToNextPage() {
    if (_pdfViewController != null && _currentPage < (_totalPages ?? 0) - 1) {
      _pdfViewController.setPage(_currentPage + 1);
    }
  }

  void _goToPreviousPage() {
    if (_pdfViewController != null && _currentPage > 0) {
      _pdfViewController.setPage(_currentPage - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _filePath != null
          ? GestureDetector(
        onHorizontalDragStart: (details) {
          _flipKey.currentState?.startFlip();
        },
        onHorizontalDragUpdate: (details) {
          Offset off = details.delta;
          double tilt = 1 / _clampMin((-off.dy + 20) / 100);
          double percent = math.max(0, -details.delta.dx / size.width * 1.4);
          percent = percent - percent / 2 * (1 - 1 / tilt);
          _flipKey.currentState?.flip(percent, tilt);
        },
        onHorizontalDragEnd: (details) {
          _flipKey.currentState?.stopFlip();
          if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
            _goToNextPage();
          } else if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
            _goToPreviousPage();
          }
        },
        onHorizontalDragCancel: () {
          _flipKey.currentState?.stopFlip();
        },
        child: FlipWidget(
          key: _flipKey,
          textureSize: size * 2,
          child: PDFView(
            filePath: _filePath!,
            enableSwipe: false,
            swipeHorizontal: false,
            autoSpacing: true,
            pageFling: true,
            onRender: (pages) {
              setState(() {
                _totalPages = pages;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },

            onError: (error) {
              print(error.toString());
            },
            onPageError: (page, error) {
              print('$page: ${error.toString()}');
            },
          ),
        ),
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  double _clampMin(double v) {
    const double _minNumber = 0.008;
    if (v < _minNumber && v > -_minNumber) {
      if (v >= 0) {
        v = _minNumber;
      } else {
        v = -_minNumber;
      }
    }
    return v;
  }
}
*/



import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flip_widget_flutter/flip_widget_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

class BookPage1 extends StatefulWidget {
  final String url;
  final String title;

  const BookPage1({super.key, required this.url, required this.title});

  @override
  _BookPageState createState() => _BookPageState();
}

const double _MinNumber = 0.008;
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

class _BookPageState extends State<BookPage1> {
  String? _filePath;
  PDFViewController? _pdfViewController;
  int _currentPage = 0;
  int? _totalPages;
  final GlobalKey<FlipWidgetState> _flipKey = GlobalKey();
  Offset _oldPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _downloadPDF();
  }

  Future<void> _downloadPDF() async {
    try {
      var response = await http.get(Uri.parse(widget.url));
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/book.pdf");
      _filePath = file.path;
      file = await file.writeAsBytes(response.bodyBytes);
      setState(() {});
    } catch (e) {
      print("Error downloading PDF: $e");
    }
  }

  void _goToNextPage() {
    if (_pdfViewController != null && _currentPage < (_totalPages ?? 0) - 1) {
      _pdfViewController?.setPage(_currentPage + 1);
      setState(() {
        _currentPage++;
      });
    }
  }

  void _goToPreviousPage() {
    if (_pdfViewController != null && _currentPage > 0) {
      _pdfViewController?.setPage(_currentPage - 1);
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(title: Text(widget.title)),
      body: _filePath != null
          ? Stack(
        children: [
          // PDFView widget for current page
          Positioned.fill(
            child: PDFView(
              filePath: _filePath!,
              enableSwipe: false,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
              onRender: (pages) {
                setState(() {
                  _totalPages = pages;
                });
              },
              onViewCreated: (PDFViewController vc) {
                _pdfViewController = vc;
              },
              onPageChanged: (page, total) {
                setState(() {
                  _currentPage = page!;
                });
              },
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
            ),
          ),
          // FlipWidget for page flipping animation
          Positioned.fill(
            child: GestureDetector(
              onHorizontalDragStart: (details) {
                _oldPosition = details.globalPosition;
                _flipKey.currentState?.startFlip();
              },
              onHorizontalDragUpdate: (details) {
                Offset off = details.globalPosition - _oldPosition;
                double tilt = 1 / _clampMin((-off.dy + 20) / 100);
                double percent = math.max(0, -off.dx / size.width * 1.4);
                percent = percent - percent / 2 * (1 - 1 / tilt);
                _flipKey.currentState?.flip(percent, tilt);
              },
              onHorizontalDragEnd: (details) {
                _flipKey.currentState?.stopFlip();
                if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
                  _goToNextPage();
                } else if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
                  _goToPreviousPage();
                }
              },
              onHorizontalDragCancel: () {
                _flipKey.currentState?.stopFlip();
              },
              child: FlipWidget(
                key: _flipKey,
                textureSize: size * 2,
                child: PDFView(
                  filePath: _filePath!,
                  enableSwipe: false,
                  swipeHorizontal: false,
                  autoSpacing: true,
                  pageFling: true,
                  onRender: (pages) {
                    setState(() {
                      _totalPages = pages;
                    });
                  },
                  onViewCreated: (PDFViewController vc) {
                    _pdfViewController = vc;
                  },
                  onPageChanged: (page, total) {
                    setState(() {
                      _currentPage = page!;
                    });
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
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
