import 'package:rxdart/subjects.dart';

class RadioSelectionBloc {
  final BehaviorSubject<int> _subjectGroupValue = BehaviorSubject<int>();

  BehaviorSubject<int> get subjectGroupValue => _subjectGroupValue;

  final BehaviorSubject<bool> _subjectEnable = BehaviorSubject<bool>();

  BehaviorSubject<bool> get subjectEnable => _subjectEnable;

  RadioSelectionBloc(int x) {
    _subjectEnable.sink.add(false);
    _subjectGroupValue.sink.add(x);
  }

  dispose() {
    _subjectGroupValue.close();
    _subjectEnable.close();
  }

  setValue(int x) {
    _subjectGroupValue.sink.add(x);
  }

  void setEnable(bool bool) {
    _subjectEnable.sink.add(true);
  }
}