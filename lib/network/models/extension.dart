
import 'enum.dart';

extension StringExtension on String{

    NotificationType get toNotificationType{
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

    bool get isEmptyOrNull {
        if (this == null) {
            return true;
        } else {
            if (this.isEmpty) {
                return true;
            } else {
                return false;
            }
        }
    }
}
