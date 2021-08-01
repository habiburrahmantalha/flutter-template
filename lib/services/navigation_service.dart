import 'package:flutter/material.dart';
import 'package:flutter_template/values/constants.dart';
import 'package:flutter_template/widgets/dialogs/dialog_confirmation.dart';
import 'package:launch_review/launch_review.dart';

class NavigationService {
		final GlobalKey<NavigatorState> navigatorKey =
		new GlobalKey<NavigatorState>();
		Future<dynamic> navigateTo(String routeName, {bool replace = false}) {
				if(replace)
						return navigatorKey.currentState!.pushReplacementNamed(routeName);
				else
					return navigatorKey.currentState!.pushNamed(routeName);
		}
		Future<dynamic> navigateToWithArgument(String routeName, {dynamic arguments,bool replace = false}) {
				if(replace)
						return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
				else
					return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
		}

		Future<dynamic> showUpdateDialog(String? alertMsg) {
			return showDialog(
					barrierDismissible: false,
					context: navigatorKey.currentState!.overlay!.context,
					builder: (BuildContext context) {
						return DialogConfirmation(
							message: alertMsg,
							buttonText: "Update",
							function: () {
								LaunchReview.launch(
										writeReview: false,
										androidAppId: Texts.android_app_id,
										iOSAppId: Texts.ios_app_id);
							},
						);
					});
		}
}
