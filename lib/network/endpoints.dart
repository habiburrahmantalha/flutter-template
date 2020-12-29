class Endpoints {
  //AUTH


  static String register() => "user/register";
  static String login() => "user/login";
  static String logout() => "user/logout";
  static String detail() => "user/detail";
  static String refreshToken() => "user/refresh-token";
  static String profileImage() => "user/profile-image";

  static String notifierToken() => "user/notifier-token";
  static String name() => "user/name";
  static String changePassword() => "user/change-password";
  static String deleteLogs() => "user/logs/delete-all";

  static String healthCheck() => "health-check";

}
