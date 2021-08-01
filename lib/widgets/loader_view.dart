import 'package:flutter/material.dart';
import 'package:flutter_template/imports.dart';
import 'package:flutter_template/network/blocs/loading.dart';



class LoadingView extends StatelessWidget {
  const LoadingView({required this.type, this.emptyView, this.loadingView, required this.connectionState}) ;

  final LoadingType type;
  final Widget? emptyView;
  final Widget? loadingView;
  final ConnectionState connectionState;

  @override
  Widget build(BuildContext context) {

    bool isActive = connectionState == ConnectionState.active;
    return StreamBuilder<List<LoadingType>>(
        stream: loadingBloc.subjectIsLoading,
        builder: (context, snapshotIsLoading) {
          return snapshotIsLoading.isLoading(type) ? Center(child: loadingView ?? LoadingIndicator()) : emptyView ?? Container();
        }
    );
  }
}