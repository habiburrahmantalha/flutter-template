import 'package:dio/dio.dart';
import 'package:flutter_template/network/blocs/input.dart';
import 'package:flutter_template/network/models/enum.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class ErrorBloc{

    final PublishSubject<Tuple2<dynamic, ErrorType>> _subjectError = PublishSubject<Tuple2<dynamic, ErrorType>>();
    PublishSubject<Tuple2<dynamic, ErrorType>> get subjectError => _subjectError;

    final PublishSubject<Map<InputFrom , String>> _subjectErrorText = PublishSubject<Map<InputFrom , String>>();
    PublishSubject<Map<InputFrom , String>> get subjectErrorText => _subjectErrorText;

    Map<InputFrom , String> _mapError = Map();

    handleError(DioError error, ErrorType type){
        switch(error.type){
            case DioErrorType.response:
                print("Exception Reactions: ${error.response} ${error.type == DioErrorType.response} , ${error.response!.statusCode}");
                _subjectError.sink.add(Tuple2(error, type));
                break;
            case DioErrorType.cancel:

                break;
            case DioErrorType.connectTimeout:

                break;
            case DioErrorType.receiveTimeout:

                break;
            case DioErrorType.sendTimeout:

                break;
            default:

                break;
        }

    }

    dispose() {
        _subjectError.close();
        _subjectErrorText.close();
    }

    showError(InputFrom from, String text){
        _mapError[from] = text;
        _subjectErrorText.sink.add(_mapError);
    }

    clearError(InputFrom from){
        _mapError.remove(from);
        _subjectErrorText.sink.add(_mapError);
    }
}
final errorBloc = ErrorBloc();