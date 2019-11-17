import 'package:flutter/widgets.dart';

class Constants extends InheritedWidget {
  static Constants of(BuildContext context) => context.inheritFromWidgetOfExactType(Constants);
  const Constants({Widget child, Key key}): super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  final String appTitle = 'Wanderlust';
  final String homeRoute = 'home';
  final String authenticationRoute = 'authentication';
  final String email = 'Email';
  final String password = 'Password';
  final String encryptionKey = 'Key';
  final String login = 'Login';
  final String loading = 'Loading...';
}

enum ConnectivityStatus {
  WiFi,
  Cellular,
  Offline
}
