import 'package:flutter/material.dart';
import 'package:flutter_template/network/blocs/loading.dart';
import 'package:flutter_template/widgets/widgets.dart';


class PaginationListView extends StatefulWidget {
  final int count;
  final Widget? loadingView;
  final LoadingType loadingType;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool Function(ScrollNotification, bool) onNotificationUpdate;

  PaginationListView({Key? key,required this.loadingType, required this.count, required this.onNotificationUpdate, this.loadingView, required this.itemBuilder }) : super(key: key);

  @override
  _PaginationListViewState createState() {
    return _PaginationListViewState();
  }


}

class _PaginationListViewState extends State<PaginationListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<LoadingType>>(
      stream: loadingBloc.subjectIsLoading,
      builder: (context, isLoading) {
        return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) => widget.onNotificationUpdate(scrollNotification, isLoading.hasData && isLoading.data!.contains(widget.loadingType)),
            child: ListView.builder(
                cacheExtent: 1.0,
                shrinkWrap: true,
                itemCount: widget.count + 1,
                itemBuilder: (context, index){
                    return index == widget.count ?
                    (isLoading.hasData && isLoading.data!.contains(widget.loadingType) ? widget.loadingView ?? LoadingIndicator() : Container())
                        : widget.itemBuilder(context, index);
                },
            ),
        );
      }
    );
  }
}
