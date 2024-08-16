// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

class WebViewExample extends StatefulWidget {
  final String url;
  final Color themeColor;
  const WebViewExample(
      {super.key, required this.url, required this.themeColor});

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  WebViewController? _controller;
  final GlobalKey webViewKey = GlobalKey();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            // debugPrint('Page started loading: $url');
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            // debugPrint('Page finished loading: $url');
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
          Page resource error:
          code: ${error.errorCode}
          description: ${error.description}
          errorType: ${error.errorType}
          isForMainFrame: ${error.isForMainFrame}
                  ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('status=approved&code=000')) {
              // debugPrint('blocking navigation to ${request.url}');
              Navigator.pop(context, "Success");
              return NavigationDecision.prevent;
            }
            if (request.url.contains('status=declined&code=106')) {
              // debugPrint('blocking navigation to ${request.url}');
              Navigator.pop(context, "Transaction declined or terminated");
              return NavigationDecision.prevent;
            }

            if (request.url.contains('code=101')) {
              debugPrint('blocking navigation to ${request.url}');
              Navigator.pop(context, "Insufficient funds in wallet");
              return NavigationDecision.prevent;
            }

            if (request.url.contains('code=103')) {
              debugPrint('blocking navigation to ${request.url}');
              Navigator.pop(context, "Wrong PIN or transaction timed out");
              return NavigationDecision.prevent;
            }

            if (request.url.contains('code=100')) {
              debugPrint('blocking navigation to ${request.url}');
              Navigator.pop(context, "Transaction not permitted to cardholder");
              return NavigationDecision.prevent;
            }

            debugPrint('allowing navigation to ${request.url}');
             Navigator.pop(context, "Payment Processing Failed");
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: widget.themeColor,
          title: Text("Checkout"),
          elevation: 0,
          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : WebViewWidget(key: webViewKey, controller: _controller!),
        // floatingActionButton: favoriteButton(),
      ),
    );
  }
}
