import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService{

		BuildContext _context;
		Location location = new Location();
		LocationService(this._context);

		checkLocationService() async {
				isServiceEnabled();
				bool serviceEnabled = await isLocationServiceEnabled();
				if (!serviceEnabled) {
						serviceEnabled = await location.requestService();
				}
		}

		bool isStopped = false;

		isServiceEnabled() {
				print("// === TIMER --- isServiceEnabled === //");
				Timer.periodic(Duration(seconds: 2), (timer) async {
						bool serviceEnabled = await isLocationServiceEnabled();
						if (serviceEnabled) {
								isStopped = true;
								timer.cancel();
								requestPermission(Permission.location);
						}
				});
		}

		requestPermission(Permission permission) async {
				final status = await permission.request();
				if (status.isGranted) {
						//locationBloc.getCurrentLocation();
				} else {
						//locationBloc.onPermissionDenied(false);
						showToast("Location permission not granted", _context);
				}
		}
}