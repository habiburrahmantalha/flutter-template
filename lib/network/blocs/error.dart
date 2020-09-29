import 'package:dio/dio.dart';
import 'package:flutter_template/network/models/enum.dart';

import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class ErrorBloc{

    final PublishSubject<Tuple2<dynamic, ErrorType>> _subjectError = PublishSubject<Tuple2<dynamic, ErrorType>>();
    PublishSubject<Tuple2<dynamic, ErrorType>> get subjectError => _subjectError;

    handleError(DioError error, ErrorType type){
        switch(error.type){
            case DioErrorType.RESPONSE:
                print("Exception Reactions: ${error.response} ${error.type == DioErrorType.RESPONSE} , ${error.response.statusCode}");
                _subjectError.sink.add(Tuple2(error, type));
                break;
            case DioErrorType.CANCEL:

                break;
            case DioErrorType.CONNECT_TIMEOUT:

                break;
            case DioErrorType.RECEIVE_TIMEOUT:

                break;
            case DioErrorType.SEND_TIMEOUT:

                break;
            default:

                break;
        }

    }


    dispose() {
        _subjectError.close();
    }

}
final errorBloc = ErrorBloc();