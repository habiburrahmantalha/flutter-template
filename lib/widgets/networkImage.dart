import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/imports.dart';

class NetworkImageX extends StatelessWidget {
  NetworkImageX({Key? key, required this.imageUrl, this.width, this.height, this.fit = BoxFit.cover, this.errorWidget}) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width != null ? blocks.size(width!) : null,
      height: height,
      /*  placeholder: (context, url) => Container(

      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Res.placeholder), fit: BoxFit.cover)),
    ),*/
      placeholder: (context, url) => Container(height: width != null ? blocks.size(width!) : null, width: width != null ? blocks.size(width!) : null,),
      errorWidget: (context, url, error) =>  errorWidget ?? Icon(Icons.error),
    );
  }
}


