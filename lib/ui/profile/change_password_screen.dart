import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/network/blocs/auth.dart';
import 'package:flutter_template/network/blocs/loading.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/buttons/loader_button.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:flutter_template/widgets/text_input_form.dart';
import 'package:flutter_template/widgets/widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/change_password';
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() {
    return _ChangePasswordScreenState();
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _form = GlobalKey<FormState>();
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
    double height = MediaQuery.of(context).size.height - 84;
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
    title: TextX(text: "Change Password", color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17.0),
    centerTitle: true,
    ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: blocks.size(24)),
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Column(
              children: [
                Form(key:_form, child: Column(
                  children: [

                    margin(y:24),
                    TextInputForm(

                      title: "Current Password",
                      hintText: "Enter your current password",
                      keyboardType: TextInputType.visiblePassword,
                      action: TextInputAction.done,
                      onSaved: (value) {
                        authBloc.setValue("current_password", value);
                      },
                      validator: (v) {
                        if (v!.length >= 6)
                          return null;
                        else
                          return "Enter password";
                      },),
                    margin(y:16),
                    TextInputForm(

                      title: "New Password",
                      hintText: "Enter a new password",
                      keyboardType: TextInputType.visiblePassword,
                      action: TextInputAction.done,
                      onSaved: (value) {
                        authBloc.setValue("new_password", value);
                      },
                      validator: (v) {
                        if (v!.length >= 6)
                          return null;
                        else
                          return "Enter password";
                      },),
                    margin(y:16),
                    TextInputForm(

                      title: "Re-enter New Password",
                      hintText: "Enter the new password again",
                      keyboardType: TextInputType.visiblePassword,
                      action: TextInputAction.done,
                      onSaved: (value) {
                        authBloc.setValue("new_confirm_password", value);
                      },
                      validator: (v) {
                        if (v!.length >= 6)
                          return null;
                        else
                          return "Enter password";
                      },),
                  ],
                )),
                Spacer(),
                TextX(text: "By pressing ‘Update Password’ you will be logged out from this session and need to login again.",textAlign: TextAlign.center, color: ColorsX.lightGreyBlue, fontWeight: FontWeight.w400, fontSize: 13.0),
                margin(y:16),
                StreamBuilder<List<LoadingType>>(
                    stream: loadingBloc.subjectIsLoading,
                    builder: (context, isLoading) {
                      return LoaderButton(label: "Update Password", isLoading: isLoading.hasData && isLoading.data!.contains(LoadingType.updatePassword),
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            _form.currentState!.save();
                            authBloc.updatePassword();

                          }
                          //Navigator.pushNamed(context, GetNumberModelScreen.routeName);
                        },  );
                    }
                ),
                margin(y:24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}