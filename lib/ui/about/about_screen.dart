import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/res.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/utils/version_info.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:flutter_template/widgets/widgets.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = '/about';
  AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() {
    return _AboutScreenState();
  }
}

class _AboutScreenState extends State<AboutScreen> {
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

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: TextX(text: "About", color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17.0),
          centerTitle: true,),
      body: Column(
        children: [
          margin(y: 64),
          Image.asset(Res.ic_circular_google,  width: blocks.size(140)),
          margin(y: 44),
          Image.asset(Res.ic_circular_google, width: blocks.size(140),),
          Spacer(),
          VersionInfo(),
          TextX(text: "©2020 Rabbapps Inc.", color: ColorsX.coolGrey, fontWeight: FontWeight.w400, fontSize: 12.0),
          margin(y: 44)
        ],
      ),
    );
  }
}