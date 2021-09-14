import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/res.dart';
import 'package:flutter_template/ui/profile/change_password_screen.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:flutter_template/widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        title: TextX(text: "My Profile", color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17.0),
    centerTitle: true,
    ),
      body: Column(
        children: [
          Image.asset(Res.ic_circular_google),
          FloatingActionButton(onPressed: (){}, mini: true, child: Icon(Icons.add, color: ColorsX.watermelon,), backgroundColor: Colors.white,),
          margin(y:12),
          Divider(height: 0,),
          ListTile(
            title: Row(
              children: [
                Container(width: blocks.size(120),child: TextX(text: "FULL NAME", color: ColorsX.coolGrey, fontWeight: FontWeight.w500, fontSize: 14.0)),
                TextX(text: "contents", color: ColorsX.darkGreyBlue, fontWeight: FontWeight.w500, fontSize: 17.0),
              ],
            ),
            onTap: (){

            },
          ),
          Divider(height: 0,),
          ListTile(
            title: Row(
              children: [
                Container(width: blocks.size(120),child: TextX(text: "EMAIL ADDRESS", color: ColorsX.coolGrey, fontWeight: FontWeight.w500, fontSize: 14.0)),
                TextX(text: "contents", color: ColorsX.darkGreyBlue, fontWeight: FontWeight.w500, fontSize: 17.0),
              ],
            ),
            onTap: (){

            },
          ),
          Divider(height: 0,),

          ListTile(
            title: Row(
              children: [
                Container(width: blocks.size(120),child: TextX(text: "PASSWORD", color: ColorsX.coolGrey, fontWeight: FontWeight.w500, fontSize: 14.0)),
                TextX(text: "Change Password", color: ColorsX.darkGreyBlue, fontWeight: FontWeight.w500, fontSize: 17.0),
              ],
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: (){
              Navigator.pushNamed(context, ChangePasswordScreen.routeName);
            },
          ),
          Divider(height: 0,),

          Spacer(),
          Divider(height: 0,),
          ListTile(
            leading: TextX(text: "Logout", color: ColorsX.watermelon, fontWeight: FontWeight.w500, fontSize: 17.0),
            onTap: (){

            },
          ),
          Divider(height: 0,),
          ListTile(
            leading: TextX(text: "Delete My Account", color: ColorsX.watermelon, fontWeight: FontWeight.w400, fontSize: 17.0),
            onTap: (){

            },
          )

        ],
      ),
    );
  }
}