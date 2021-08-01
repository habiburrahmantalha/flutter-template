import 'package:flutter/material.dart';
import 'package:flutter_template/imports.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/values/constants.dart';
import 'package:intl/intl.dart';

import 'enum.dart';

extension StringExtension on String{

		NotificationType? get toNotificationType{
				switch(this){

						case "notification":
								return NotificationType.notification;
						case "profile":
								return NotificationType.profile;
						case "home":
								return NotificationType.home;
						default:
								return null;
				}
		}


		bool get isValidEmail {
			Pattern pattern =
					r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
			RegExp regex = new RegExp(pattern as String);
			if (!regex.hasMatch(this))
				return false;
			else
				return true;
		}

		Color get toHexColor {
			final buffer = StringBuffer();
			if(this.length < 6 || this.isEmpty){
				return ColorsX.bgGrey;
			}
			if (this.length == 6 || this.length == 7) buffer.write('ff');
			buffer.write(this.replaceFirst('#', ''));
			return Color(int.parse(buffer.toString(), radix: 16));
		}

		DateTime get toDateTime{
			return DateFormat(Constant.DATE_TIME_FORMAT).parse(this, true).toLocal();
		}

		DateTime get toDate{
			return DateFormat(Constant.DATE_FORMAT).parse(this, true).toLocal();
		}

		DateTime toDateFormat(String format){
			return DateFormat(format).parse(this, true).toLocal();
		}

		DateTime get toTime{
			return DateFormat(Constant.TIME_FORMAT).parse(this, true).toLocal();
		}

		bool get isToday{
			return this.toDateTime.isToday;
		}

		String toDateTimeString(String format){
			return DateFormat(format).format(this.toDateTime);
		}

		int get getDayDifferenceToday {
			return this.toDateTime.difference(DateTime.now()).inDays;
		}
}


extension DateHelpers on DateTime {
	bool get isToday {
		final now = DateTime.now();
		return now.day == this.day &&
				now.month == this.month &&
				now.year == this.year;
	}

	bool isInBetween(String a, String b){
		DateTime dateA = a.toDateTime;
		DateTime dateB = b.toDateTime;

		if (dateA.isBefore(this) && dateB.isAfter(this)){
			return true;
		} else {
			return false;
		}

	}

	bool isAfterDate(String d){
		DateTime date = d.toDateTime;


		if (this.isAfter(date)){
			return true;
		} else {
			return false;
		}

	}

	bool isTomorrow() {
		final yesterday = DateTime.now().add(Duration(days: 1));
		return yesterday.day == this.day &&
				yesterday.month == this.month &&
				yesterday.year == this.year;
	}

	String toFrenchMonth (){
		int m = this.month;
		switch(m){
			case 1:
				return "janvier";
			case 2:
				return "février";
			case 3:
				return "mars";
			case 4:
				return "avril";
			case 5:
				return "mai";
			case 6:
				return "juin";
			case 7:
				return "juillet";
			case 8:
				return "août";
			case 9:
				return "septembre";
			case 10:
				return "octobre";
			case 11:
				return "novembre";
			case 12:
				return "décembre";
			default:
				return "";
		}
	}
}

extension DoubleExtension on double{

	double get toWidthScale {
		return blocks.size(this);
	}

	double get toFontScale {
		return blocks.size(this);
	}

}