import 'package:equatable/equatable.dart';

class Province extends Equatable {
  final String id, name;

  Province({this.id, this.name});

  @override
  List<Object> get props => [id, name];
}
