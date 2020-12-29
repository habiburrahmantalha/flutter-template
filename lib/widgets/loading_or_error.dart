import 'package:flutter/material.dart';
import 'package:flutter_template/network/blocs/loading.dart';
import 'package:flutter_template/network/models/enum.dart';
import 'package:flutter_template/widgets/widgets.dart';


class LoadingOrError extends StatelessWidget {
  const LoadingOrError({@required this.type, this.errorView, this.loadingView, @required this.connectionState}) ;

  final LoadingType type;
  final Widget errorView;
  final Widget loadingView;
  final ConnectionState connectionState;

  @override
  Widget build(BuildContext context) {

    bool isActive = connectionState == ConnectionState.active;
    return StreamBuilder<List<LoadingType>>(
        stream: loadingBloc.subjectIsLoading,
        builder: (context, isLoading) {
          return !isActive || (isLoading.hasData && isLoading.data.contains(type)) ? loadingView ?? LoadingIndicator() : errorView ?? Container();
        }
    );
  }
}