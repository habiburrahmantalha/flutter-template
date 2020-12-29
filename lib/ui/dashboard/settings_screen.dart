import 'package:flutter/material.dart';
import 'package:flutter_template/res.dart';
import 'package:flutter_template/ui/about/about_screen.dart';
import 'package:flutter_template/ui/profile/ProfileScreen.dart';
import 'package:flutter_template/utils/version_info.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/text.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {

  List<SettingsItem> contents = [
    SettingsItem(title: "My Number & Plan", type: 0, to: ProfileScreen.routeName),
    SettingsItem(title: "Notifications", type: 0, to: ""),
    SettingsItem(title: "Give Some Love", type: 0, to: ""),
    SettingsItem(title: "Help & Feedback", type: 0, to: ""),
    SettingsItem(title: "About", type: 0, to: AboutScreen.routeName),
  ];

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
        brightness: Brightness.light,
        elevation: 0,
        title: xText(text: "Settings", color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17.0),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                  if(index == 0) {
                    return ListTile(
                      leading: Image.asset(Res.ic_circular_google),
                      title: xText(text: "name", color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17.0),
                      subtitle: xText(text: "My Profile", color: ColorsX.coolGrey, fontWeight: FontWeight.w400, fontSize: 14.0),
                      trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.pushNamed(context, ProfileScreen.routeName);
                      },
                    );
                  }
                    else{
                      return ListTile(
                        title: xText(text: contents[index-1].title, color: ColorsX.darkGreyBlue, fontWeight: FontWeight.w500, fontSize: 17.0),
                        trailing: Icon(Icons.chevron_right),
                        onTap: (){
                          Navigator.pushNamed(context, contents[index-1].to);
                        },
                      );
                  }
                }
              , separatorBuilder: (context, index) {
              return Divider(height: 0,);
            }, itemCount: contents.length + 1,
            ),
          ),
          VersionInfo()
        ],
      ),
    );
  }
}

class SettingsItem{
  String title;
  int type;
  String to;

  SettingsItem({this.title, this.type, this.to});
}