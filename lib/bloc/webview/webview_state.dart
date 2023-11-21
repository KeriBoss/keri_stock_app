part of 'webview_bloc.dart';

abstract class WebviewState extends Equatable {
  const WebviewState();
}

class WebviewInitial extends WebviewState {
  @override
  List<Object> get props => [];
}

class WebviewLoadingState extends WebviewState {
  @override
  List<Object?> get props => [];
}

class WebviewLoadedState extends WebviewState {
  final String url;

  const WebviewLoadedState(this.url);

  @override
  List<Object?> get props => [url];
}
