import 'package:flutter/material.dart';
import 'package:flutter_template/imports.dart';
import 'package:rxdart/rxdart.dart';

class TextInputForm extends StatefulWidget {
  final String value;
  final String title;
  final FocusNode? current;
  final FocusNode? next;
  final bool enabled;
  final bool errorText;
  final String hintText;
  final TextInputAction? action;
  final onSaved;
  final onChanged;
  final Function(String?)? validator;
  final TextInputType keyboardType;

  final controller;
  final Function? onTap;
  final bool? autoFocus;
  final Color? fillColor;

  TextInputForm(
      {Key? key,
        this.autoFocus,
        this.keyboardType = TextInputType.text,
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
        this.fillColor,
        //this.borderNone = false,
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
    if(widget.keyboardType == TextInputType.visiblePassword){
      bloc.updateVisibility(true);
    }

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.value);
    return StreamBuilder<bool>(
        stream: bloc.subjectPasswordVisibility,
        builder: (context, snapshot) {
          bool obscureText = snapshot.hasData ? (snapshot.data ?? false) : false;
          return StreamBuilder<bool>(
              stream: bloc.subjectFocus,
              builder: (context, snapshotFocus) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: snapshotFocus.hasData && (snapshotFocus.data ?? false) ? "C03BFF".toHexColor : Colors.transparent ,
                        width: 1),
                  ),
                  child: Focus(
                    onFocusChange: (focus) {
                      bloc.setFocus(focus);
                      print("focus: $focus");
                    },
                    child: TextFormField(
                      onTap: widget.onTap as void Function()?,
                      readOnly: widget.onTap != null,
                      showCursor:  widget.onTap == null,
                      cursorColor: ColorsX.primary_button_start,
                      keyboardType: widget.keyboardType,
                      autofocus: widget.autoFocus ?? false,
                      enabled: widget.enabled ? true : false,
                      controller: widget.controller != null ? widget.controller : null,
                      initialValue: widget.controller == null ? widget.value : null,
                      //initialValue: widget.value,
                      obscureText: widget.keyboardType == TextInputType.visiblePassword ? obscureText : false,
                      focusNode: widget.current,
                      textInputAction: widget.action,
                      style: TextStyle(
                          color: ColorsX.black,
                          fontSize: scale.size(17),
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal),
                      decoration: InputDecoration(
                          labelText: widget.title,
                          contentPadding: EdgeInsets.only(
                              top: blocks.size(9),
                              bottom: blocks.size(9),
                              left: blocks.size(16),
                              right: blocks.size(16)),
                          filled: true,
                          fillColor: widget.fillColor ?? Colors.white,
                          focusedBorder: prepareBorder(ColorsX.primary_button_start, 4),
                          disabledBorder: prepareBorder(ColorsX.stroke, 4),
                          enabledBorder: prepareBorder(ColorsX.stroke, 4),
                          errorBorder: prepareBorder(ColorsX.stroke, 4),
                          focusedErrorBorder: prepareBorder(ColorsX.stroke, 4),
                          suffixIcon: widget.keyboardType == TextInputType.visiblePassword ? _getSuffixButton(snapshot): SizedBox.shrink(),
                          hintText: widget.hintText,
                          errorStyle: new TextStyle(
                              fontSize: widget.errorText ? scale.size(12) : 0),
                          hintStyle: new TextStyle(
                              color: ColorsX.grey98, fontSize: scale.size(16), fontWeight: FontWeight.w500)),
                      onFieldSubmitted: (term) {
                        widget.onSaved(term);
                        if(widget.current != null)
                          widget.current!.unfocus();
                        if (widget.current != widget.next)
                          FocusScope.of(context).requestFocus(widget.next);
                      },
                      onChanged: widget.onChanged,
                      onSaved: widget.onSaved,
                      //validator: widget.validator,
                      validator: (val) {
                        return widget.validator!(val);
                      },
                    ),
                  ),
                );
              }
          );
        }
    );
  }

  _getSuffixButton(AsyncSnapshot<bool> snapshot) {
    return IconButton(
        icon: Icon(
          snapshot.hasData && snapshot.data! ? Icons.visibility_off : Icons.visibility,
          semanticLabel:  snapshot.hasData && snapshot.data! ? 'hide password' : 'show password',
          color: Colors.grey,
        ),
        onPressed: () {
          bloc.updateVisibility(!snapshot.data!);
        });
  }


  prepareBorder(Color color, double radius){
    return UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }
}


class TextInputBloc{

  final BehaviorSubject<bool> _subjectPasswordVisibility = BehaviorSubject<bool>();
  BehaviorSubject<bool> get subjectPasswordVisibility => _subjectPasswordVisibility;

  final BehaviorSubject<bool> _subjectFocus = BehaviorSubject<bool>();
  BehaviorSubject<bool> get subjectFocus => _subjectFocus;

  TextInputBloc(){
    _subjectPasswordVisibility.sink.add(false);
  }

  dispose(){
    _subjectPasswordVisibility.close();
    _subjectFocus.close();
  }

  setFocus(bool focus){
    print("FOCUS $focus");
    _subjectFocus.sink.add(focus);
  }

  updateVisibility(bool v){
    _subjectPasswordVisibility.sink.add(v);
  }

}
