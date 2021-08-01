
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/imports.dart';


class LabeledRadio extends StatelessWidget {
		const LabeledRadio({
				required this.label,
				this.padding,
				required this.groupValue,
				required this.value,
				required this.onChanged, this.fontSize, this.imageUrl
		});
		final String label;
		final EdgeInsets? padding;
		final int groupValue;
		final int value;
		final double? fontSize;
		final Function onChanged;
		final String? imageUrl;

		@override
		Widget build(BuildContext context) {
				return InkWell(
						onTap: () {
								if (value != groupValue) onChanged(value);
						},
						child: Padding(
								padding: padding ?? EdgeInsets.all(0),
								child: Row(
										children: <Widget>[
											imageUrl !=null ? Padding(
											  padding: EdgeInsets.symmetric(horizontal: blocks.size(8)),
											  child: Image.network(imageUrl!, width: blocks.size(32),),
											) : SizedBox.shrink(),
											TextX(
													text: label,
													fontSize: scale.size(fontSize ?? 12),
													color: ColorsX.white,
													fontWeight: FontWeight.w500),
												Spacer(),
												Theme(
														data: ThemeData(unselectedWidgetColor:  ColorsX.white_60),
														child: Radio(
																activeColor: ColorsX.white,
																materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
																groupValue: groupValue,
																value: value,
																onChanged: (value) {
																		onChanged(value);
																},
														),
												),

										],
								),
						),
				);
		}
}