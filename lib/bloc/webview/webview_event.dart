part of 'webview_bloc.dart';

abstract class WebviewEvent extends Equatable {
  const WebviewEvent();
}

class OnLoadWebviewEvent extends WebviewEvent {
  final String url;

  const OnLoadWebviewEvent(this.url);

  @override
  List<Object?> get props => [url];
}
