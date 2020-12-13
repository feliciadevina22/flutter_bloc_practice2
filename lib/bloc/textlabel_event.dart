part of 'textlabel_bloc.dart';

@immutable
abstract class TextlabelEvent {}

class ChangeTextLabel extends TextlabelEvent {
  final String kata;

  ChangeTextLabel(this.kata);
}
