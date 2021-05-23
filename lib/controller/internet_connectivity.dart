import 'dart:async';

import 'package:connectivity/connectivity.dart';

enum NetworkStatus { online, offline, restored }

class InternetConnectivity {
  static final StreamController _networkController =
      StreamController<NetworkStatus>.broadcast();

  static Stream<NetworkStatus> get networkStream => _networkController.stream as Stream<NetworkStatus>;

  static NetworkStatus _status = NetworkStatus.online;
  static NetworkStatus get status => _status;

  static networkStatusService() async {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult status) async {
      if (status != ConnectivityResult.none) {
        _networkController.add(NetworkStatus.restored);
        await Future.delayed(Duration(seconds: 5));
        if (status != ConnectivityResult.none) {
          _networkController.add(NetworkStatus.online);
        }
      } else {
        _networkController.add(NetworkStatus.offline);
      }
    });
    _networkController.stream.listen((event) {
      _status = event;
    });
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      _networkController.add(NetworkStatus.offline);
    }
  }

  void dispose() {
    _networkController.close();
  }
}
