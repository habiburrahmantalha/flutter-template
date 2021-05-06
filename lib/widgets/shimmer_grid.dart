import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGridLoading extends StatelessWidget {
    final ShimmerCardType? type;
  ShimmerGridLoading({Key? key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemBuilder: (_, int i) => Container(
            //height: blocks.size(240),
            child: ShimmerRow(top: i == 0, bottom: i== 5, type: type),
        ),
        itemCount: 6,
    );
  }
}

class ShimmerRow extends StatelessWidget {
    final bool? top;
    final bool? bottom;
    final ShimmerCardType? type;
  ShimmerRow({Key? key, this.top, this.bottom, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: top!? 20: 10, bottom: bottom!? 20: 10),
      child: Row(
          children: [
              margin(x:20),
              ShimmerItem(type: type),
              margin(x:20),
              ShimmerItem(type: type),
              margin(x:20),
          ],
      ),
    );
  }
}


class ShimmerItem extends StatelessWidget {
    final ShimmerCardType? type;
  ShimmerItem({Key? key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
            children: [
                Shimmer.fromColors(
                    baseColor: Colors.grey[800]!,
                    highlightColor: Colors.grey[700]!,
                    enabled: true,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                      child: Container(
                        height: 112.0,
                        color: Colors.white,
                    ),
                  ),
                ),
                Container(
                    height: type == ShimmerCardType.prank ? 90 : 70,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4)),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey[800]!,
                        highlightColor: Colors.grey[700]!,
                        enabled: true,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                              ),
                             margin(y:2),
                              Container(
                                  width: 80.0,
                                  height: 8.0,
                                  color: Colors.white,
                              ),
                              margin(y: type == ShimmerCardType.prank ? 20: 10),
                              Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                              ),
                              margin(y:2),
                              Container(
                                  width: 40.0,
                                  height: 8.0,
                                  color: Colors.white,
                              ),
                          ],
                      ),
                    ),
                )

                ,
            ],
        ),
    );
  }
}

enum ShimmerCardType{
    prank, reaction
}

