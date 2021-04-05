import 'package:flutter/material.dart';
import 'package:flutter_template/network/models/extension.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/buttons/loader_button.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:flutter_template/widgets/text_input_form.dart';
import 'package:flutter_template/widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot_password';
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() {
    return _ForgotPasswordScreenState();
  }
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                margin(y:24),
                xText(text: "Forgot password",
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
                      onSaved: (val) {
                        // setState(() {
                        //   _signupKeys[field.payloadKey] = val.trim();
                        // });
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

                LoaderButton(label: "Submit", color: ColorsX.watermelon, onPressed: () {
                  //Navigator.pushNamed(context, GetNumberModelScreen.routeName);
                },  ),
              ],
            ),
          )
      ),
    );
  }
}