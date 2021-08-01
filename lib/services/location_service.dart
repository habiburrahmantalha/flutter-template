import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as LocationPackage;

class LocationServiceBloc {

  Future<bool> isLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    return serviceEnabled;
  }

  Future<bool> isLocationPermissionGranted() async {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          print('Location### Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        print('Location### Location permissions are permanently denied, we cannot request permissions.');
      }
      // locationBloc.setLocationPermissionStatus(permission);
      switch(permission){

        case LocationPermission.denied:
        case LocationPermission.deniedForever:

          return false;
        case LocationPermission.whileInUse:
        case LocationPermission.always:
          return true;
      }
  }

  getLocation() {
    isLocationServiceEnabled().then((value) async {
      if(value){
        print("Location###isLocationServiceEnabled");
        isLocationPermissionGranted().then((value) {
          if(value){
            print("Location###isLocationPermissionGranted");
            getCurrentLocation();
          }else{
            print("Location###isLocationPermissionGranted #NO");
          }
        });
      }else{
        print("Location###isLocationServiceEnabled #NO");
        //await Geolocator.openLocationSettings();
        LocationPackage.Location location = new LocationPackage.Location();
        await location.requestService();
        getLocation();
      }
    });

  }
  late StreamSubscription _positionStream;
  getCurrentLocation() {
    print("Location###getCurrentLocation");
    try {
      _positionStream = Geolocator.getPositionStream(
          desiredAccuracy: LocationAccuracy.best,
          distanceFilter: 10,
          intervalDuration: Duration(milliseconds: 10)).listen((Position position) {
        print("Location###getCurrentLocation ${position.toJson()}");
        // locationBloc.setCurrentLocationPosition(position);
        _positionStream.cancel();
      }, onError: (e){
        print("Location###getCurrentLocation #NO $e");
      }, onDone: (){
        print("Location###getCurrentLocation #DONE");
      });
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      print("Location###getCurrentLocation #NO $e");
    }
  }

  dispose(){
    _positionStream.cancel();
  }

  openAppSettings() async {
    await Geolocator.openAppSettings();
    //getLocation();
  }
}

final locationServiceBloc = LocationServiceBloc();






