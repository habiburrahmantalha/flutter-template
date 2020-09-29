import 'package:flutter/material.dart';
import 'package:flutter_template/values/colors.dart';

import 'objects.dart';

class PaginationLoader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(blocks.size(24)),
      child: Center(
        child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(ColorsX.accent),
            )
        ),
      ),
    );
  }
}