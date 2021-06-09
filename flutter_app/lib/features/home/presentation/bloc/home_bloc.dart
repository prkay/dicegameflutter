import 'package:flutter/material.dart';
import 'package:flutter_app/core/repository/firebase_repositroy.dart';
import 'package:flutter_app/resources/string_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  String versiontemp = "";
  @override
  HomeState get initialState => EmptyState(false);
  final FireBaseRepository fireBaseRepository;
  HomeBloc({@required this.fireBaseRepository,});

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomePageReadyEvent) {
      await _getVersionName();
      yield HomePageReadyState(true,false);
    }else if(event is GetAllUserListEvent){
      yield* getAllUserList();
    }
  }
  _getVersionName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versiontemp = packageInfo.version;
  }

  Stream<HomeState> getAllUserList() async* {
    yield GetAllUserListStartState(true);
      try{
        var userList = await fireBaseRepository.getListOfAllUsers();
        yield GetAllUserListSuccessState(false,userList);
      }catch(e){
        GetAllUserListFailedState(false,StringKeys.somethingWentWrong);
      }
  }
}