


import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

enum LoadingType{
  login, register, updatePassword,updateProfile,
  verifyMobile, verifyMobileCode,
  logout, checkMobileExists,
  search,
}


enum BottomSheetType{
  liveAudioRoom, signUp, login, forgetPassword
}


class LoadingBloc{

  final BehaviorSubject<List<LoadingType>> _subjectIsLoading = BehaviorSubject<List<LoadingType>>();
  BehaviorSubject<List<LoadingType>> get subjectIsLoading => _subjectIsLoading;

  final BehaviorSubject<List<BottomSheetType>> _subjectBottomSheetIsOpened = BehaviorSubject<List<BottomSheetType>>();
  BehaviorSubject<List<BottomSheetType>> get subjectBottomSheetIsOpened => _subjectBottomSheetIsOpened;

  List<LoadingType> list = [];
  List<BottomSheetType> listBottomSheet = [];

  start(LoadingType type){
    print(type);
    list.add(type);
    _subjectIsLoading.sink.add(list);
  }

  end(LoadingType type){
    if(list.contains(type))
      list.remove(type);
    _subjectIsLoading.sink.add(list);
  }

  open(BottomSheetType type){
    listBottomSheet.add(type);
    _subjectBottomSheetIsOpened.sink.add(listBottomSheet);
  }

  close(BottomSheetType type){
    if(listBottomSheet.contains(type))
      listBottomSheet.remove(type);
    _subjectBottomSheetIsOpened.sink.add(listBottomSheet);
  }

  dispose() {
    _subjectIsLoading.close();
    _subjectBottomSheetIsOpened.close();
  }

  bool isBottomSheetOpened(AsyncSnapshot<List<BottomSheetType>> isOpened, BottomSheetType type) {
    return isOpened.hasData && isOpened.data !=null && isOpened.data!.contains(type);
  }

  // bool isLoading(AsyncSnapshot<List<LoadingType>> isLoading, LoadingType type) {
  //   return isLoading.hasData && isLoading.data !=null && isLoading.data!.contains(type);
  // }
}
final loadingBloc = LoadingBloc();

extension LoadingTypeExtension on AsyncSnapshot<List<LoadingType>>{
  bool isLoading(LoadingType type){
    return this.hasData && this.data !=null && this.data!.contains(type);
  }
}
