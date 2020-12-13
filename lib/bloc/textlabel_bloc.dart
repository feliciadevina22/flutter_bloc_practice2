import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'textlabel_event.dart';
part 'textlabel_state.dart';

class TextlabelBloc extends Bloc<TextlabelEvent, TextlabelState> {
  TextlabelBloc(TextlabelState initialState) : super(initialState);

  @override
  Stream<TextlabelState> mapEventToState(
    TextlabelEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is ChangeTextLabel) {
      yield TextlabelState(event.kata);
    }
  }
}
