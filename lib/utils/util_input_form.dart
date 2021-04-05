class UtilInputForm {
  static String getLabel(InputType type) {
    switch (type) {
      case InputType.name:
        {
          return "Name";
        }
        break;
      case InputType.email:
        {
          return "Email";
        }
        break;
      case InputType.password:
        {
          return "Password";
        }
        break;
      case InputType.retypePassword:
        {
          return "Password";
        }
        break;
      case InputType.mobile:
        {
          return "Phone Number";
        }
        break;
      case InputType.recipientName:
        {
          return "Recepient name";
        }
        break;
      case InputType.phoneNumber:
        {
          return "Phone Number";
        }
        break;
      case InputType.fromName:
        {
          return "From name";
        }
        break;
      case InputType.description:
        {
          return "Description";
        }
        break;
      case InputType.token:
        {
          return "Token";
        }
        break;
      case InputType.gender:
        return "Choose Gender";
        break;
      case InputType.birthday:
        return "Choose Birthday";
        break;

      default:
        return "";
        break;
    }
  }

  static String getHintText(InputType type) {
    switch (type) {
      case InputType.name:
        {
          return "Type here";
        }
        break;
      case InputType.firstName:
        {
          return "Type your first name";
        }
        break;
      case InputType.lastName:
        {
          return "Type your last name";
        }
        break;
      case InputType.email:
        {
          return "Type your email address";
        }
        break;
      case InputType.password:
        {
          return "Password";
        }
        break;
      case InputType.retypePassword:
        {
          return "Confirm Password";
        }
        break;
      case InputType.mobile:
        {
          return "01XXXXXXXXX";
        }
        break;
      case InputType.recipientName:
        {
          return "Recepient name";
        }
        break;
      case InputType.phoneNumber:
        {
          return "1XXXXXXXXXX";
        }
        break;
      case InputType.fromName:
        {
          return "From name";
        }
        break;
      case InputType.description:
        {
          return "Description";
        }
        break;
      case InputType.token:
        {
          return "Token";
        }
        break;
      case InputType.gender:
        {
          return 'Gender';
        }
        break;
      case InputType.birthday:
        return 'DD/MM/YYYY';
        break;
    }
    return "";
  }

  static String getErrorText(InputType type) {
    switch (type) {
      case InputType.name:
        {
          return "Enter name";
        }
        break;
      case InputType.firstName:
        {
        //  return "Please insert first name";
          return "";
        }
        break;
      case InputType.lastName:
        {
         // return "Please insert last name";
          return "";
        }
        break;
      case InputType.email:
        {
          //return "Please insert valid email";
          return "";
        }
        break;
      case InputType.password:
        {
          return "Minimum length 6";
        }
        break;
      case InputType.retypePassword:
        {
          return "Password not matched";
        }
        break;
      case InputType.mobile:
        {
          return "Please insert valid phone number";
        }
        break;
      case InputType.recipientName:
        {
          return "Enter name";
        }
        break;
      case InputType.phoneNumber:
        {
          return "Please insert valid phone number";
        }
        break;
      case InputType.fromName:
        {
          return "Enter name";
        }
        break;
      case InputType.gender:
        {
          return "Choose Gender";
        }
        break;
      case InputType.birthday:
        {
          return "Select Birthdate";
        }
        break;
      case InputType.description:
        {
          return "Enter description";
        }
        break;
      case InputType.token:
        {
          return "Enter token";
        }
        break;
    }
    return "";
  }

  static bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern as String);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }
}

enum InputType {
  name,
  email,
  mobile,
  gender,
  birthday,
  lastName,
  firstName,

  token,
  password,
  retypePassword,


  recipientName,
  phoneNumber,
  fromName,
  description
}