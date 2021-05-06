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

		bool get isEmptyOrNull{
			return this == null || this.trim().isEmpty;
		}

		bool get isValidEmail{
			Pattern pattern =
					r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
			RegExp regex = new RegExp(pattern as String);
			if (!regex.hasMatch(this))
				return false;
			else
				return true;
		}
}
