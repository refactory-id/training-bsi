import 'package:equatable/equatable.dart';

class Cost extends Equatable {
  final String etd, note;
  final int value;

  Cost({this.etd, this.note, this.value});

  @override
  List<Object> get props => [etd, note, value];
}
