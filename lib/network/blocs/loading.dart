import 'package:flutter_template/network/models/enum.dart';
import 'package:rxdart/rxdart.dart';

class LoadingBloc{

    final BehaviorSubject<List<LoadingType>> _subjectIsLoading = BehaviorSubject<List<LoadingType>>();
    BehaviorSubject<List<LoadingType>> get subjectIsLoading => _subjectIsLoading;

    List<LoadingType> list = List();


    start(LoadingType type){
        list.add(type);
        _subjectIsLoading.sink.add(list);
    }

    end(LoadingType type){
        list.remove(type);
        _subjectIsLoading.sink.add(list);
    }

    dispose() {
        _subjectIsLoading.close();
    }

}
final loadingBloc = LoadingBloc();
