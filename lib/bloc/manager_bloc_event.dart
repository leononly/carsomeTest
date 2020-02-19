import 'package:equatable/equatable.dart';

abstract class ManagerBlocEvent extends Equatable {}

class FetchData extends ManagerBlocEvent {
  int index;
  FetchData({this.index});

  @override
  String toString() => 'Fetch New Data';
}
