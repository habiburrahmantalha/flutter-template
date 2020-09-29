import 'package:flutter/material.dart';
import 'package:flutter_template/ui/splash/splash_screen.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';

import 'text.dart';


class KWidgets {
  static Widget appBar(
      {BuildContext context,
      String title,
      bool showBack,
      double elevation,
      bool checkCanPop}) {
    return PreferredSize(
      child: AppBar(
        leading: showBack
            ? IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: scale.scaledSize(22),
            color: ColorsX.accent,
          ),
          onPressed: () {
            if (checkCanPop == true || Navigator.canPop(context))
              Navigator.pop(context, true);
            else {
              Navigator.pushReplacementNamed(
                  context, SplashScreen.routeName);
            }
          },
        )
            : null,
        centerTitle: false,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: xText(
            text: title,
            color: ColorsX.accent,
            softWrap: true,
            fontSize: scale.scaledSize(18),
            fontWeight: FontWeight.w700),
        titleSpacing: 0,
        elevation: elevation ?? 1.0,
      ),
      preferredSize: Size.fromHeight(kToolbarHeight),
    );
  }

  static Widget mainAppBar(
      BuildContext context, String title, bool showBack, {Function onWillPop, double titleSpacing}) {
    return PreferredSize(
      child:  Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: ColorsX.appBarShadow,
              offset: Offset(0, 2),
              blurRadius: 2.0,
              spreadRadius: 0)
        ]),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: showBack
              ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: scale.scaledSize(22),
                color: ColorsX.accent,
              ),
              onPressed: () {
                if (onWillPop == null)
                  Navigator.of(context).pop(true);
                else
                  onWillPop();
              })
              : null,
          centerTitle: false,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: xText(
              text: title,
              color: ColorsX.accent,
              fontSize: scale.scaledSize(18),
              fontWeight: FontWeight.w800),
          elevation: 0.0,
          titleSpacing: titleSpacing ?? blocks.size(25),
        ),
      ),
      preferredSize: Size.fromHeight(kToolbarHeight),
    );
  }

  static void showSnackBar(String msg, BuildContext scaffoldContext) {
    Scaffold.of(scaffoldContext).showSnackBar(new SnackBar(
      backgroundColor: ColorsX.textGrey,
      content: xText(
        text: msg,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      duration: Duration(seconds: 2),
    ));
  }

  static Widget screenLoader() {
    return Scaffold(
        backgroundColor: Colors.black54.withOpacity(0.10),
        body: Center(
            child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(ColorsX.accent),
        )));
  }
}

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;

  LoadingIndicator({Key key, this.size = 24.0, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: scale.scaledSize(size),
      width: scale.scaledSize(size),
      child: new CircularProgressIndicator(
        backgroundColor: ColorsX.accent,
        valueColor: new AlwaysStoppedAnimation<Color>(color),
        value: null,
        strokeWidth: 3.0,
      ),
    );
  }
}

TextFormField prepareInputField(
    TextEditingController controller, String hintText,
    {onChanged, onFieldSubmitted}) {
  return TextFormField(
      controller: controller,
      cursorColor: ColorsX.textGrey,
      style: TextStyle(
          color: ColorsX.textBlack,
          fontSize: scale.scaledSize(14),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsX.stroke),
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsX.accent),
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        hintText: hintText,
        hintStyle:
            TextStyle(color: ColorsX.textHint, fontSize: scale.scaledSize(14)),
      ),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted);
}

Widget margin({double x = 0, double y = 0}) {
  return SizedBox(
    width: blocks.size(x),
    height: blocks.size(y),
  );
}
