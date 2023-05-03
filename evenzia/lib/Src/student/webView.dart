
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';




class WebViewScreen extends StatefulWidget {
  String url;

  WebViewScreen({Key? key,required this.url}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  double progress = 0;
  bool isLoading = true;
  String? paymentRequestId='';
  var selectedUrl;
  @override
  Widget build(BuildContext context) {

    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: Uri.tryParse(widget.url.toString()),

      ),

      onWebViewCreated: (InAppWebViewController controller) {


      },
      onProgressChanged: (InAppWebViewController controller, int progress) {
        setState(() {
          this.progress = progress / 100;
          print('taskkk');
        });
      },
      onUpdateVisitedHistory: (_, Uri? uri, __) {
        String url=uri.toString();
        print({'print uri',uri});
        print({'uri?.queryParameters',uri?.queryParameters['payment_id']});
        // uri containts newly loaded url
        if (mounted) {
          if (url.contains('https://www.google.com/')) {
//Take the payment_id parameter of the url.
            String? paymentRequestId = uri?.queryParameters['payment_id'];
            print("value is: " +paymentRequestId.toString());







          }
        }
      },

    );
  }
}
