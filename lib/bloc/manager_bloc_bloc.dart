import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carsomeTest/service/api.dart';

import './bloc.dart';

class ManagerBloc extends Bloc<ManagerBlocEvent, ManagerBlocState> {
  List dataList = [];

  @override
  ManagerBlocState get initialState => InitialManagerBlocState();

  @override
  Stream<ManagerBlocState> mapEventToState(
    ManagerBlocEvent event,
  ) async* {
    // TODO: Add Logic

    if (event is FetchData) {
      int index = event.index;
      yield ManagerLoading();

      try {
        var response = await fetchData(index);

        dataList = response;

        yield ManagerLoaded();
      } catch (error) {
        yield ManagerErrorFound(error: error);
      }
    }
  }

  Future fetchData(int index) async {
    try {
      List response = await API().getButton1API(index);
      return response;
    } catch (error) {
      throw error;
    }
  }
}
