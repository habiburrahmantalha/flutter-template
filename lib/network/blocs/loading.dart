import 'package:rxdart/rxdart.dart';

enum LoadingType{
  login, register, country, area, number, plan, updatePassword
}

class LoadingBloc{

  final BehaviorSubject<List<LoadingType>> _subjectIsLoading = BehaviorSubject<List<LoadingType>>();
  BehaviorSubject<List<LoadingType>> get subjectIsLoading => _subjectIsLoading;

  List<LoadingType> list = [];

  start(LoadingType type){
    list.add(type);
    _subjectIsLoading.sink.add(list);
  }

  end(LoadingType type){
    if(list.contains(type))
      list.remove(type);
    _subjectIsLoading.sink.add(list);
  }

  dispose() {
    _subjectIsLoading.close();
  }
}
final loadingBloc = LoadingBloc();