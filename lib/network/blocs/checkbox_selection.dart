import 'package:rxdart/subjects.dart';

class CheckBoxSelectionBloc {
  final BehaviorSubject<List<bool>> _subjectGroupValue = BehaviorSubject<List<bool>>();
  BehaviorSubject<List<bool>> get subjectGroupValue => _subjectGroupValue;

  List<bool>? _list = List.filled(1, false);


  CheckBoxSelectionBloc(int length) {
    _list = List.filled(length, false);
  }

  dispose() {
    _subjectGroupValue.close();
  }

  reset(int length){
    _list = List.filled(length, false);
    _subjectGroupValue.sink.add(_list!);
  }

  setValue(int x) {
    _list![x] = !_list![x];
    _subjectGroupValue.sink.add(_list!);
  }

}