import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/imports.dart';


class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox(
      {required this.label,
        required this.imageUrl,
        required this.value,
        required this.subText,
        required this.onChanged,
        this.checkColor = ColorsX.accent, this.sizedBox = false});

  final String label;
  final String imageUrl;
  final bool value;
  final String subText;
  final Color checkColor;
  final Function onChanged;
  final bool sizedBox;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          onChanged(!value);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: blocks.size(4), horizontal: blocks.size(16)),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: Container(
                  height: blocks.size(48),
                  width: blocks.size(48),
                  child: NetworkImageX(
                    fit: BoxFit.cover,
                      imageUrl: Values.image_url + imageUrl,
                      width: 32,
                      errorWidget: Image.asset(Res.ic_circular_apple, fit: BoxFit.cover, ),
                  ),
                ),
              ),
              margin(x:16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextX(
                      text: label,
                      fontSize: scale.size(14),
                      color: ColorsX.textBlack,
                      fontWeight: FontWeight.w500),
                  TextX(
                      text: subText,
                      fontSize: scale.size(12),
                      color: ColorsX.grey33,
                      fontWeight: FontWeight.w400)
                ],
              ),
              Spacer(),
              Transform.scale(
                  scale: 1,
                  child: sizedBox ? SizedBox(
                    width: 20,
                    child: _buildCheckbox(),
                  ) : _buildCheckbox()
              ),
            ],
          ),
        ),
      ),
    );
  }

  Checkbox _buildCheckbox() {
    return Checkbox(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      activeColor: ColorsX.accent,
      checkColor: Colors.white,
      value: value,
      onChanged: (bool? newValue) {
        onChanged(newValue);
      },
    );
  }
}
