import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
class PDFScreen extends StatefulWidget {
  final String? path;
  const PDFScreen({super.key, this.path});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
   final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
    bool isDownloading = false;
  String? downloadedFilePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Get.back();
          }),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
                false, // if set to true the link is handled in flutter
            backgroundColor: Colors.black,
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              print('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              print('page change: ${page ?? 0 + 1}/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         _downloadPDF();
        },
        child: Icon(Icons.download),
      ),
    );
  }

  Future<void> _downloadPDF() async {
    setState(() {
      isDownloading = true;
    });

    try {
      String url = widget.path ?? "";
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = "${directory.path}/downloaded_file.pdf";

      Dio dio = Dio();
      await dio.download(url, filePath);

      setState(() {
        isDownloading = false;
        downloadedFilePath = filePath;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Download Complete")));
    } catch (e) {
      setState(() {
        isDownloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Download Failed")));
    }
  }
}
