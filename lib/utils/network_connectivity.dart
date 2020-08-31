import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:rxdart/rxdart.dart';

class NetworkConnectivity{

		final BehaviorSubject<bool> _subjectNetworkConnectivity = BehaviorSubject<bool>();
		BehaviorSubject<bool> get getSubjectNetworkConnectivity => _subjectNetworkConnectivity;
		Connectivity connectivity = Connectivity();

		//Scaffold _scaffoldKey;

		void initialise() async {
				//ConnectivityResult result = await connectivity.checkConnectivity();
				checkStatus();
				connectivity.onConnectivityChanged.listen((_) {
						checkStatus();
				});
		}

		void checkStatus() async {
				bool isOnline = false;
				if (await DataConnectionChecker().hasConnection) {
						// Wifi detected & internet connection confirmed.
						isOnline = true;
				}

//				try {
//
//						final result = await InternetAddress.lookup('google.com');
//						if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//								print("ONLINE#${result[0].rawAddress}");
//								isOnline = true;
//						} else
//								isOnline = false;
//				} on SocketException catch (_) {
//						isOnline = false;
//				}
				_subjectNetworkConnectivity.sink.add(isOnline);
				print("ONLINE#$isOnline");

		}

		dispose (){
				_subjectNetworkConnectivity.close();
		}
}

final NetworkConnectivity networkConnectivity = NetworkConnectivity();