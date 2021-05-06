import 'package:flutter/material.dart';
import 'package:flutter_template/res.dart';
import 'package:flutter_template/utils/network_connectivity.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/buttons/loader_button.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:flutter_template/widgets/widgets.dart';

class DialogNoInternet extends StatefulWidget {
  final String? message;
  final Function? function;
  DialogNoInternet({ this.message, this.function});

  @override
  _DialogNoInternetState createState() => _DialogNoInternetState();
}

class _DialogNoInternetState extends State<DialogNoInternet> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(blocks.size(20)))),
        backgroundColor: Colors.white,
        content: Wrap(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: blocks.size(30),
                  bottom: blocks.size(30),
                  left: blocks.size(25),
                  right: blocks.size(25)),
              child: Column(
                children: <Widget>[
                  margin(y: 10),
                  Container(
                    height: blocks.size(106),
                    width: blocks.size(214),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(Res.ic_circular_fb))),
                  ),
                  margin(y: 30),
                  Container(
                    width: blocks.getWidth(),
                    child: xText(
                        textAlign: TextAlign.center,
                        text: widget.message,
                        color: ColorsX.textGrey,
                        fontSize: scale.size(18)),
                  ),
                  margin(y: 30),

                  LoaderButton(
                    label: "Retry",
                    height: blocks.size(40),
                    width: blocks.size(190),
                    color: ColorsX.accent,
                    isLoading: _isLoading,
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      Future.delayed(Duration(milliseconds: 300)).then((_) {
                        if(mounted) {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      });
                      networkConnectivity.checkStatus();
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
