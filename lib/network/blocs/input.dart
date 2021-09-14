import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_template/values/constants.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_template/imports.dart';


enum InputFrom{
  verifyMobileCode, createProfile, createProfileWIthBirthDay, updatePassword, search,
  selectAccount, enterEmail, enterMobile, setPassword, joinNetwork, profilePicture,login, enterAddress,
  settings, updateProfileStudent, updateProfileAssociation, updateProfileClubOwner, createTrend, none, termsCondition, chat, searchUser
}


class InputBloc {
  Map<InputFrom, bool> _buttonStatus = HashMap();
  final Map<String, dynamic> _values = {};

  final Map<String, dynamic> _tempValues = {};
  
  final PublishSubject<Map<InputFrom, bool>> _subjectEnableButton = PublishSubject<Map<InputFrom, bool>>();
  PublishSubject<Map<InputFrom, bool>> get subjectEnableButton => _subjectEnableButton;

  final BehaviorSubject<Map<String, dynamic>> _subjectInputValues = BehaviorSubject<Map<String, dynamic>>();
  BehaviorSubject<Map<String, dynamic>> get subjectInputValues => _subjectInputValues;

  final BehaviorSubject _subjectPickedImages = BehaviorSubject<Map<String, File>>();
  BehaviorSubject<Map<String, File>> get subjectPickedImages => _subjectPickedImages as BehaviorSubject<Map<String, File>>;


  setValue(String key, dynamic value, InputFrom from){

    print("ButtonStatusBloc $key $value $from");
    if(value != null) {
      _values[key] = value;
    }else {
      _values.remove(key);
    }
    print("ButtonStatusBloc $_values");
    switch(from){
      case InputFrom.enterEmail:
        _buttonStatus[InputFrom.enterEmail] =  isValid(_values[InputKeys.email], checkEmail: true);
        break;
      case InputFrom.enterMobile:
        //_buttonStatus[InputFrom.enterMobile] = isValid(_values[InputKeys.mobile]);
        break;
      case InputFrom.verifyMobileCode:
        _buttonStatus[InputFrom.verifyMobileCode] = _values[InputKeys.mobileCode]!= null &&  _values[InputKeys.mobileCode].toString().isNotEmpty;
        break;
      case InputFrom.updatePassword:
        _buttonStatus[InputFrom.updatePassword] = isValid(_values[InputKeys.newPassword])  && isValid(_values[InputKeys.confirmPassword]) && _values[InputKeys.newPassword] == _values[InputKeys.confirmPassword];
        break;

      case InputFrom.search:
        // TODO: Handle this case.
        break;

      case InputFrom.setPassword:
        _buttonStatus[InputFrom.setPassword] = isValid(_values[InputKeys.password], minLength: 6)  && isValid(_values[InputKeys.confirmPassword]) && _values[InputKeys.password] == _values[InputKeys.confirmPassword];
        break;

      case InputFrom.profilePicture:
        _buttonStatus[InputFrom.profilePicture] = true;
        break;
      case InputFrom.login:
        _buttonStatus[InputFrom.login] = isValid(_values[InputKeys.password]) &&  isValid(_values[InputKeys.email], checkEmail: true);
        break;

      case InputFrom.settings:
        // TODO: Handle this case.
        break;
      case InputFrom.updateProfileStudent:
        // TODO: Handle this case.
        break;
      case InputFrom.updateProfileAssociation:
        // TODO: Handle this case.
        break;
      case InputFrom.updateProfileClubOwner:
        // TODO: Handle this case.
        break;

      case InputFrom.none:
        // TODO: Handle this case.
        break;
      case InputFrom.termsCondition:
        // TODO: Handle this case.
        break;

    }
    _subjectEnableButton.sink.add(_buttonStatus);
    _subjectInputValues.sink.add(_values);
  }

  getInputValue(String key){
    return _values[key];
  }

  setTempValue(String key, dynamic value){
    if(value != null) {
      _tempValues[key] = value;
    }else {
      _tempValues.remove(key);
    }
  }

  setMobile(InputFrom from, {String? value, bool? status}){
    if(value !=null){
      _values[InputKeys.mobile] = value;
    }
    if(status !=null){
      _buttonStatus[from] = status;
      _subjectEnableButton.sink.add(_buttonStatus);
    }
  }

  getTempValue(String key){
    return _tempValues[key];
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
    _subjectInputValues.close();
    _subjectPickedImages.close();
  }

  void clearValues(List<String> list, InputFrom from) {
    list.forEach((element) {
      setValue(element, null, from);
    });
  }

  void setImage(File? file, String key) {
    Map<String, File> m = _subjectPickedImages.hasValue ? _subjectPickedImages.value : Map();

    if(file != null) {
      if (m.containsKey(key)) {
        m.update(key, (value) => file);
      } else {
        m.putIfAbsent(key, () => file);
      }
    }else{
      m.remove(key);
    }
    _subjectPickedImages.sink.add(m);
  }

  File? getImage(String key){
    Map<String, File> m = _subjectPickedImages.hasValue ? _subjectPickedImages.value : Map();
    return m[key];
  }

}
final inputBloc = InputBloc();

extension ButtonStatusExtension on AsyncSnapshot<Map<InputFrom, bool>>{
  bool isEnable(InputFrom from){
    bool isEnable = false;
    if(this.hasData && this.data != null){
      isEnable = this.data?[from] ?? false;
    }
    return isEnable;
  }
}
