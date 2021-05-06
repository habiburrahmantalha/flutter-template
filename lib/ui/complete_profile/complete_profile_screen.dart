import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/network/blocs/auth.dart';
import 'package:flutter_template/network/blocs/loading.dart';
import 'package:flutter_template/network/models/extension.dart';
import 'package:flutter_template/res.dart';
import 'package:flutter_template/ui/login/login_screen.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/buttons/loader_button.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:flutter_template/widgets/text_input_form.dart';
import 'package:flutter_template/widgets/widgets.dart';

class CompleteProfileScreen extends StatefulWidget {
  static const routeName = '/complete_profile';
  CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  _CompleteProfileScreenState createState() {
    return _CompleteProfileScreenState();
  }
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: blocks.size(24)),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  Res.ic_circular_google,
                  width: scale.size(184),
                ),
                margin(y: 36),
                xText(
                    text: "Complete your profile",
                    textAlign: TextAlign.center,
                    color: ColorsX.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0),
                margin(y: 46),
                Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextInputForm(
                          errorText: true,
                          paddingNone: true,
                          title: "Email Address",
                          hintText: "Enter email address",
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
                          },
                        ),
                        margin(y: 16),
                        Row(
                          children: [
                            Expanded(
                                child: TextInputForm(
                              errorText: true,
                              paddingNone: true,
                              title: "First Name",
                              hintText: "Enter first Name",
                              keyboardType: TextInputType.emailAddress,
                              action: TextInputAction.next,
                              onSaved: (value) {
                                // setState(() {
                                //   _signupKeys[field.payloadKey] = val.trim();
                                // });
                                authBloc.setValue("first_name", value);
                              },
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return "Please insert first name";
                                } else
                                  return null;
                              },
                            )),
                            margin(x: 12),
                            Expanded(
                              child: TextInputForm(
                                errorText: true,
                                paddingNone: true,
                                title: "Last Name",
                                hintText: "Enter last name",
                                keyboardType: TextInputType.emailAddress,
                                action: TextInputAction.next,
                                onSaved: (value) {
                                  // setState(() {
                                  //   _signupKeys[field.payloadKey] = val.trim();
                                  // });
                                  authBloc.setValue("last_name", value);
                                },
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "Please insert last name";
                                  } else
                                    return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        margin(y: 16),
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
                          },
                        ),
                      ],
                    )),
                margin(y: 16),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: ColorsX.coolGrey, fontSize: 12.0),
                    children: <TextSpan>[
                      TextSpan(text: 'By proceeding on, you agree to ...’s '),
                      TextSpan(
                          text: 'terms & conditions',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print(' Terms of Service"');
                            }),
                    ],
                  ),
                ),
                margin(y: 12),
                StreamBuilder<List<LoadingType>>(
                    stream: loadingBloc.subjectIsLoading,
                    builder: (context, isLoading) {
                      return LoaderButton(
                        label: "Create Account",
                        color: ColorsX.watermelon,
                        isLoading: isLoading.hasData && isLoading.data!.contains(LoadingType.register),
                        onPressed: () {
                          //Navigator.pushNamed(context, GetNumberModelScreen.routeName);
                          if (_form.currentState!.validate()) {
                            _form.currentState!.save();
                            authBloc.register();
                          }
                        },
                      );
                    }),
                margin(y: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    xText(
                        text: "Already have an account? ",
                        color: ColorsX.blueyGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                    margin(x: 4),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      child: xText(
                          text: "Login Now", color: ColorsX.watermelon, fontWeight: FontWeight.w600, fontSize: 14.0),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
    ;
  }
}
