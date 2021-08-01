import 'dart:collection';
import 'package:flutter_template/values/constants.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_template/network/models/extension.dart';

enum InputFrom{
  onBoardCreateAccount, verifyMobile, verifyMobileCode, createProfile, updatePassword, search
}


class ButtonStatusBloc {
  HashMap<InputFrom, bool> _buttonStatus = HashMap();
  final Map<String, dynamic> _values = {};
  
  final PublishSubject _subjectEnableButton = PublishSubject<HashMap<InputFrom, bool>>();
  PublishSubject<HashMap<InputFrom, bool>> get subjectEnableButton => _subjectEnableButton as PublishSubject<HashMap<InputFrom, bool>>;


  setValue(String key, String? value, InputFrom from){

    if(value != null) {
      _values[key] = value;
    }else {
      _values.remove(key);
    }
    switch(from){
      case InputFrom.onBoardCreateAccount:
        _buttonStatus[InputFrom.onBoardCreateAccount] =  isValid(_values[InputKeys.email], checkEmail: true) && isValid(_values[InputKeys.password], minLength: 3);
        break;
      case InputFrom.verifyMobile:
        _buttonStatus[InputFrom.verifyMobile] = isValid(_values[InputKeys.mobile]);
        break;
      case InputFrom.verifyMobileCode:
        _buttonStatus[InputFrom.verifyMobileCode] = _values[InputKeys.mobileCode]!= null &&  _values[InputKeys.mobileCode].toString().isNotEmpty;
        break;
      case InputFrom.createProfile:
        _buttonStatus[InputFrom.createProfile] = _values[InputKeys.firstName]!= null &&  _values[InputKeys.firstName].toString().isNotEmpty;
        break;
      case InputFrom.updatePassword:
        _buttonStatus[InputFrom.updatePassword] = isValid(_values[InputKeys.newPassword])  && isValid(_values[InputKeys.confirmPassword]) && _values[InputKeys.newPassword] == _values[InputKeys.confirmPassword];
        break;

      case InputFrom.search:
        // TODO: Handle this case.
        break;
    }
    _subjectEnableButton.sink.add(_buttonStatus);
  }

  setMobile({String? value, bool? status}){
    if(value !=null){
      _values[InputKeys.mobile] = value;
    }
    if(status !=null){
      _buttonStatus[InputFrom.verifyMobile] = status;
      _subjectEnableButton.sink.add(_buttonStatus);
    }
  }
  
  getInputValue(String key){
    return _values[key];
  }
  
  getButtonStatus(String key){
    return _buttonStatus[key];
  }

  bool isValid(String? _value,{int? minLength, bool? checkEmail}){
    if(_value != null && _value.isNotEmpty){
      if(minLength != null && _value.length < minLength){
        return false;
      }
      if(checkEmail != null && !_value.isValidEmail){
        return false;
      }
      return true;
    }
    return false;
  }

  dispose() {
    _subjectEnableButton.close();
  }

  void clearValues(List<String> list, InputFrom from) {
    list.forEach((element) {
      setValue(element, null, from);
    });
  }

}
final buttonStatusBloc = ButtonStatusBloc();

