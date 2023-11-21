import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'webview_event.dart';
part 'webview_state.dart';

class WebviewBloc extends Bloc<WebviewEvent, WebviewState> {
  WebviewBloc() : super(WebviewInitial()) {
    on<OnLoadWebviewEvent>((event, emit) async {
      emit(WebviewLoadedState(event.url));
    });
  }
}
