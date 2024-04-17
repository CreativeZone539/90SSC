import 'package:flutter/material.dart';
import 'package:ninety_ssc/my_web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const WebViewApp(),
    );
  }
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(Uri.parse("http://90ssc.com/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web View for 90 SSC'),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    if (await controller.canGoBack()) {
                      await controller.goBack();
                    } else {
                      messenger.showSnackBar(const SnackBar(
                          content: Text('There is no back History')));

                      return;
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              IconButton(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    if (await controller.canGoForward()) {
                      await controller.goForward();
                    } else {
                      messenger.showSnackBar(const SnackBar(
                          content: Text('There is no forward History')));

                      return;
                    }
                  },
                  icon: const Icon(Icons.arrow_forward_ios)),
              IconButton(
                  icon: const Icon(Icons.replay),
                  onPressed: () {
                    controller.reload();
                  })
            ],
          )
        ],
      ),
      body: MyWebView(
        controller: controller,
      ),
    );
  }
}
