/*import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../controllers/get_controller.dart';

class BookPage extends StatelessWidget {
  final String url;
  final String title;
  BookPage({super.key, required this.url, required this.title});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
        toolbarTextStyle: TextStyle(fontSize: _getController.width.value * 0.048, fontWeight: FontWeight.w600),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
          onPressed: () {Get.back();}
        ),
        actions: [
          IconButton(
            icon: Icon(TablerIcons.bookmark, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
            onPressed: () {},
          ),
        ],
      ),
        body: SfPdfViewer.network(
          url, key: UniqueKey(),initialZoomLevel: 0.5,enableTextSelection: false,
    ),
    );
  }
}*/


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class BookPage extends StatefulWidget {
  final String url;
  final String title;

  BookPage({super.key, required this.url, required this.title});

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
          ? PDFView(filePath: _filePath!)
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
