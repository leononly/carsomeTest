import 'package:equatable/equatable.dart';

abstract class ManagerBlocState extends Equatable {
  ManagerBlocState([List props = const []]) : super(props);
}

class InitialManagerBlocState extends ManagerBlocState {
  @override
  String toString() => 'Manager Initiate';
}

class ManagerLoading extends ManagerBlocState {
  @override
  String toString() => 'Loading...';
}

class ManagerLoaded extends ManagerBlocState {
  @override
  String toString() => 'Loaded!';
}

class ManagerErrorFound extends ManagerBlocState {
  String error;
  ManagerErrorFound({this.error});
  @override
  String toString() => 'Error: $error';
}
