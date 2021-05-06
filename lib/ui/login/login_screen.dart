import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/network/blocs/auth.dart';
import 'package:flutter_template/network/blocs/loading.dart';
import 'package:flutter_template/network/models/extension.dart';
import 'package:flutter_template/ui/forgot_password/forgot_password_screen.dart';
import 'package:flutter_template/ui/sign_up/sign_up_screen.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/buttons/loader_button.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:flutter_template/widgets/text_input_form.dart';
import 'package:flutter_template/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
		static const routeName = '/login';
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
    _subscription = authBloc.subjectLogin.listen((value) {
     // Navigator.pushNamedAndRemoveUntil(context, GetNumberModelScreen.routeName, (Route<dynamic> route) => false);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, brightness: Brightness.light, elevation: 0,  leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: blocks.size(24)),
        alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                margin(y:24),
                xText(text: "Login to",
                    textAlign: TextAlign.center,
                    color:  ColorsX.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0
                ),
                margin(y:46),
                Form(key:_form, child: Column(
                  children: [
                    TextInputForm(
                      paddingNone: true,
                      title: "Email Address",
                      hintText: "Enter email",
                      keyboardType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                      onSaved: (value) {
                        // setState(() {
                        //   _signupKeys[field.payloadKey] = val.trim();
                        // });
                        authBloc.setValue("email", value);
                      },
                      validator: (v) {
                        if (v == null || !v.isValidEmail) {
                          return "Please insert valid email";
                        } else
                          return null;
                      },),
                    margin(y:16),
                    TextInputForm(
                      paddingNone: true,
                      title: "Password",
                      hintText: "Enter password",
                      keyboardType: TextInputType.visiblePassword,
                      action: TextInputAction.done,
                      onSaved: (value) {
                        // setState(() {
                        //   _signupKeys[field.payloadKey] = val.trim();
                        // });
                        authBloc.setValue("password", value);
                      },
                      validator: (v) {
                        if (v!.length >= 6)
                          return null;
                        else
                          return "Enter password";
                      },),
                  ],
                )),
                margin(y:16),
                Row(
                  children: [
                    SizedBox(height: 24.0,
                      width: 24.0,
                      child: Checkbox(onChanged: (bool? value) {
                      }, value: false, materialTapTargetSize: MaterialTapTargetSize.padded, ),
                    ),
                    margin(x:10),
                    xText(text: "Keep me logged in",
                        color:  ColorsX.blueyGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0
                    ),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                      },
                      child: xText(text: "Forgot Password?",
                          color:  ColorsX.watermelon,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0
                      ),
                    ),
                  ],
                ),
                margin(y:15),
                StreamBuilder<List<LoadingType>>(
                  stream: loadingBloc.subjectIsLoading,
                  builder: (context, isLoading) {
                    return LoaderButton(label: "Submit", color: ColorsX.watermelon, isLoading: isLoading.hasData && isLoading.data!.contains(LoadingType.login),
                      onPressed: () {
                        if (_form.currentState!.validate()) {
                          _form.currentState!.save();
                          authBloc.login();
                        }
                      //Navigator.pushNamed(context, GetNumberModelScreen.routeName);
                    },  );
                  }
                ),
                margin(y:60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    xText(text: "New to ...?",
                        color:  ColorsX.blueyGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0
                    ),
                    margin(x:4),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                      child: xText(text: "Signup Now",
                          color:  ColorsX.watermelon,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}