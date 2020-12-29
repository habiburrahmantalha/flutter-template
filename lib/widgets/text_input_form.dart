import 'package:flutter/material.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:flutter_template/widgets/widgets.dart';
import 'package:rxdart/rxdart.dart';

class TextInputForm extends StatefulWidget {
  final String value;
  final String title;
  final FocusNode current;
  final FocusNode next;
  final bool enabled;
  final bool errorText;
  final String hintText;
  final TextInputAction action;
  final onSaved;
  final onChanged;
  final Function(String) validator;
  final TextInputType keyboardType;
  final bool paddingNone;
  final bool borderNone;
  final controller;
  final Function onTap;

  TextInputForm(
      {Key key,
      this.keyboardType = TextInputType.text,
      this.paddingNone = false,
      this.errorText = false,
      this.hintText = "Type here",
      this.title = '',
      this.value = "",
      this.onSaved,
      this.current,
      this.next,
      this.action,
      this.enabled = true,
      this.controller,
      this.onChanged,
      this.validator,
      this.borderNone = false,
      this.onTap})
      : super(key: key);

  @override
  _TextInputFormState createState() {
    return _TextInputFormState();
  }
}

class _TextInputFormState extends State<TextInputForm> {

  final TextInputBloc bloc = TextInputBloc();
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
    // print(widget.value);
    return Container(
      child: Padding(
        padding: widget.paddingNone
            ? EdgeInsets.all(0)
            : EdgeInsets.only(
                left: blocks.size(25),
                right: blocks.size(25),
                top: blocks.size(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            xText(
                text: widget.title,
                color: ColorsX.textBlack,
                fontSize: scale.size(14)),
            margin(y: widget.title.isEmpty ? 0 : 10),
            StreamBuilder<bool>(
              stream: bloc.subjectPasswordVisibility,
              builder: (context, snapshot) {
                return TextFormField(
                  onTap: widget.onTap,
                  readOnly: widget.onTap != null,
                  showCursor:  widget.onTap == null,
                  cursorColor: ColorsX.textGrey,
                  keyboardType: widget.keyboardType,
                  autofocus: false,
                  enabled: widget.enabled ? true : false,
                  controller: widget.controller != null ? widget.controller : null,
                  initialValue: widget.controller == null ? widget.value : null,
                  //initialValue: widget.value,
                  obscureText: snapshot.hasData && snapshot.data ? false : true,
                  focusNode: widget.current,
                  textInputAction: widget.action,

                  style: new TextStyle(
                      color: ColorsX.textBlack,
                      fontSize: scale.size(14),
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal),
                  decoration: widget.borderNone
                      ? InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(0),
                          ),
                        )
                      : InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: blocks.size(12),
                              bottom: blocks.size(12),
                              left: blocks.size(15),
                              right: blocks.size(15)),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: prepareBorder(ColorsX.accent, 4),
                          disabledBorder: prepareBorder(ColorsX.stroke, 4),
                          enabledBorder: prepareBorder(ColorsX.stroke, 4),
                          errorBorder: prepareBorder(ColorsX.error, 4),
                          focusedErrorBorder: prepareBorder(ColorsX.error, 4),
                          suffixIcon: widget.keyboardType == TextInputType.visiblePassword ? _getSuffixButton(snapshot): SizedBox.shrink(),
                          hintText: widget.hintText,
                          errorStyle: new TextStyle(
                              fontSize: widget.errorText ? scale.size(12) : 0),
                          hintStyle: new TextStyle(
                              color: ColorsX.coolGrey, fontSize: scale.size(14))),
                  onFieldSubmitted: (term) {
                    widget.onSaved(term);
                    if(widget.current != null)
                      widget.current.unfocus();
                    if (widget.current != widget.next)
                      FocusScope.of(context).requestFocus(widget.next);
                  },
                  onChanged: widget.onChanged,
                  onSaved: widget.onSaved,
                  //validator: widget.validator,
                  validator: (val) {
                    return widget.validator(val);
                  },
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  _getSuffixButton(AsyncSnapshot<bool> snapshot) {
    return IconButton(
        icon: Icon(
          snapshot.hasData && snapshot.data ? Icons.visibility_off : Icons.visibility,
          semanticLabel:  snapshot.hasData && snapshot.data ? 'hide password' : 'show password',
          color: Colors.grey,
        ),
        onPressed: () {
          bloc.updateVisibility(!snapshot.data);
        });
  }


  prepareBorder(Color color, double radius){
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }
}

class TextInputBloc{

  final BehaviorSubject<bool> _subjectPasswordVisibility = BehaviorSubject<bool>();
  BehaviorSubject<bool> get subjectPasswordVisibility => _subjectPasswordVisibility;

  TextInputBloc(){
    _subjectPasswordVisibility.sink.add(false);
  }

  dispose(){
    _subjectPasswordVisibility.close();
  }

  updateVisibility(bool v){
    _subjectPasswordVisibility.sink.add(v);
  }

}
