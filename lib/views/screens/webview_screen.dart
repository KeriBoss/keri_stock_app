import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

import '../../bloc/webview/webview_bloc.dart';
import '../../main.dart';

@RoutePage()
class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, this.url, this.code});

  final String? code;
  final String? url;

  @override
  State<StatefulWidget> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController webviewController;
  String host = "https://keri.vn";
  String file = "link.txt";
  String? link;
  int count = 0;

  void loadWebViewData() async {
    try {
      link = widget.url ?? "$host/${widget.code}/$file";
      final response = await dio.get(link!);

      if (response.statusCode == 200) {
        setState(() {
          link = response.data.toString();

          print('@@@ ' + link!);

          context.read<WebviewBloc>().add(OnLoadWebviewEvent(link!));
        });
      }
    } catch (e) {
      debugPrint("Caught loading webview error: $e");
    }
  }

  @override
  void initState() {
    loadWebViewData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<WebviewBloc, WebviewState>(
        listener: (context, state) {
          if (state is WebviewLoadedState) {
            setState(() {
              link = state.url;
              webviewController.loadUrl(link!);
              debugPrint("url: $link");
            });
          }
        },
        child: WebView(
          onWebViewCreated: (WebViewController webViewController) {
            webviewController = webViewController;
            webviewController.loadUrl(link!);
            debugPrint("url: $link");
          },
          initialUrl: widget.url ?? link ?? "https://keri.vn/",
          javascriptMode: JavascriptMode.unrestricted,
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          javascriptChannels: const <JavascriptChannel>{},
          navigationDelegate: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
            if (url == "https://keri.vn/" && count < 3) {
              loadWebViewData();
              setState(() {
                count++;
              });
            }
          },
          onPageFinished: (String url) {},
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }
}
