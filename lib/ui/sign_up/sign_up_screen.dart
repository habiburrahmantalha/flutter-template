import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/network/blocs/auth.dart';
import 'package:flutter_template/network/models/extension.dart';
import 'package:flutter_template/res.dart';
import 'package:flutter_template/ui/complete_profile/complete_profile_screen.dart';
import 'package:flutter_template/ui/login/login_screen.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/buttons/loader_button.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:flutter_template/widgets/text_input_form.dart';
import 'package:flutter_template/widgets/widgets.dart';


class SignUpScreen extends StatefulWidget {
		static const routeName = '/sign_up';
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
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
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0,  leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),),
      body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: blocks.size(24)),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(Res.ic_circular_google, width: scale.size(184),),
                margin(y:36),
                TextX(text: "Sign up with ...",
                    textAlign: TextAlign.center,
                    color:  ColorsX.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0
                ),
                margin(y:46),
                Form(key:_form, child: Column(
                  children: [
                    TextInputForm(
                      errorText: true,

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
                      },),
                  ],
                )),
                margin(y:16),

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

                margin(y:12),

              LoaderButton(label: "Continue",
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    _form.currentState!.save();
                    Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                  }
                },
              ),
                margin(y:60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextX(text: "Already have an account? ",
                        color:  ColorsX.blueyGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0
                    ),
                    margin(x:4),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      child: TextX(text: "Login Now",
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