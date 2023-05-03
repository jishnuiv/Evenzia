import 'dart:async';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/foundation.dart' show TargetPlatform;

import '../../constant/myColor.dart';




class PdfViewerPage extends StatefulWidget {
  String val='';
  String title='';
  PdfViewerPage({Key? key,
    required this.val,
    required this.title
  }) : super(key: key);
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  Future<File?> createFile() async {
    try {
      /// setting filename
      final filename = urlPDFPath;

      /// getting application doc directory's path in dir variable
      String dir = (await getApplicationDocumentsDirectory()).path;

      /// if `filename` File exists in local system then return that file.
      /// This is the fastest among all.
      if (await File('$dir/$filename').exists()) return File('$dir/$filename');

      ///if file not present in local system then fetch it from server

       String url = urlPDFPath;

      /// requesting http to get url
      var request = await HttpClient().getUrl(Uri.parse(url));

      /// closing request and getting response
      var response = await request.close();

      /// getting response data in bytes
      var bytes = await consolidateHttpClientResponseBytes(response);

      /// generating a local system file with name as 'filename' and path as '$dir/$filename'
      File file = new File('$dir/$filename');

      /// writing bytes data of response in the file.
      await file.writeAsBytes(bytes);

      /// returning file.
      return file;
    }

    /// on catching Exception return null
    catch (err) {
    String?  errorMessage = "Error";
      print(errorMessage);
      print(err);
      return null;
    }
  }

  @override
  void initState() {

    getFileFromUrl(widget.val).then(
          (value) =>
      {
        setState(() {
          if (value!= null) {
            urlPDFPath = value.path;
            loaded = true;
            exists = true;
          } else {
            exists = false;
          }
        })
      },
    );
    super.initState();
  }


  String urlPDFPath='';
  bool exists = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  late PDFViewController _pdfViewController;
  bool loaded = false;

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'testonline';
    if (name != null) {
      fileName = name;
    }
    try {
      var data = await http.get(  Uri.parse(url),);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + fileName + ".pdf");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  // void requestPersmission() async {
  //   await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  //
  // }


  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print({urlPDFPath,'kk'});
    if (loaded) {
      return Scaffold(
        appBar:AppBar(centerTitle: true,
            title: const Text('Certificate',),
            leading:IconButton(onPressed: (){
              // createFile();
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(

                  content: const Text('Downloaded successfully'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );

              // ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(content: Text('Certificate downloaded successfully')));

            }, icon: const Icon(Icons.download),) ,
            flexibleSpace: Container(
              decoration:  BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors:tileColors),
              ),)
        ),
        backgroundColor: Colors.white,
        body:Column(
          children: [
            Stack(
              children: <Widget>[
                // The containers in the background


                new Container(
                  padding: new EdgeInsets.only(
                    top: 10,
                  ),
                  child: new Container(
                    padding: EdgeInsets.only(top:5),
                    child:   PDFView(

                      filePath: urlPDFPath,
                      autoSpacing: true,
                      enableSwipe: true,
                      pageSnap: true,
                      swipeHorizontal: true,
                      nightMode: false,
                      onError: (e) {
                        //Show some error message or UI
                      },
                      onRender: (_pages) {
                        setState(() {
                          _totalPages = _pages!;
                          pdfReady = true;
                        });
                      },
                      onViewCreated: (PDFViewController vc) {
                        setState(() {
                          _pdfViewController = vc;
                        });
                      },
                      onPageChanged: ( page,  total) {
                        setState(() {
                          _currentPage = page!;
                        });
                      },
                      onPageError: (page, e) {},
                    ),

                    height: height/1.3,
                    width: width,

                    decoration: BoxDecoration(
                        color: platform == TargetPlatform.iOS ?
                        Color.fromARGB(255, 236,239,244,) :
                        Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))),

                  ),
                ),

              ],
            ),
          ],
        ),

        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.chevron_left),
              iconSize: 50,
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (_currentPage > 0) {
                    _currentPage--;
                    _pdfViewController.setPage(_currentPage);
                  }
                });
              },
            ),
            Text(
              "${_currentPage + 1}/$_totalPages",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              iconSize: 50,
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (_currentPage < _totalPages - 1) {
                    _currentPage++;
                    _pdfViewController.setPage(_currentPage);
                  }
                });
              },
            ),
          ],
        ),
      );
    } else {
      if (exists) {
        //Replace with your loading UI
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 236,239,244,),

          body:Column(
            children: [
              Stack(
                children: <Widget>[
                  // The containers in the background
                  new Column(
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.only(bottom: 190),
                        child: new Container(




                          height: MediaQuery.of(context).size.height/3.5,
                        ),
                      )
                    ],
                  ),

                  new Container(

                    padding: new EdgeInsets.only(
                      top: MediaQuery.of(context).size.height/8,
                    ),
                    child: new Container(
                      padding: EdgeInsets.only(top:30),
                      child:    Center(child: CircularProgressIndicator()),

                      height: 600.0,
                      width: 500,

                      decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))),

                    ),
                  ),

                ],
              ),
            ],
          ),




        );
      } else {
        //Replace Error UI
        return Scaffold(

          body: Text(
            "PDF Not Available...",
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    }
  }


}