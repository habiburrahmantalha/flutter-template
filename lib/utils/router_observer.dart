import 'package:flutter/material.dart';


class RouteObserverX extends RouteObserver<PageRoute<dynamic>> {

		void _sendScreenView(PageRoute<dynamic> route, PageRoute<dynamic>? previousRoute, String event) {
				//if(route == null || previousRoute == null) return;

				var screenName = route.settings.name;
				//var previousScreenName = previousRoute.settings.name;
				//print('screenName $screenName $previousScreenName $event' );

				switch(screenName){

						// case PromoScreen.routeName:
						// 		setCurrentScreen(PromoScreen.routeName);
						// 		break;
				}

				// do something with it, ie. send it to your analytics service collector
		}
		@override
		void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
				super.didPush(route, previousRoute);
				if (route is PageRoute) {
						_sendScreenView(route, previousRoute as PageRoute<dynamic>?, "didPush");
				}
		}
		@override
		void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
				super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
				if (newRoute is PageRoute) {
						_sendScreenView(newRoute, oldRoute as PageRoute<dynamic>?,  "didReplace");
				}
		}
		@override
		void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
				super.didPop(route, previousRoute);
				if (previousRoute is PageRoute && route is PageRoute) {
						_sendScreenView(previousRoute, route, "didPop");
				}
		}

			void setCurrentScreen(String routeName) {
					//SingletonSettings.instance.currentScreen = routeName;
			}
}