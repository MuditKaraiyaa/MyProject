import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckConnection extends StatefulWidget {
  const CheckConnection({
    super.key,
    required this.builder,
  });
  final Widget Function(BuildContext context, bool isOffline) builder;
  @override
  State<CheckConnection> createState() => CheckConnectionState();
}

class CheckConnectionState extends State<CheckConnection> {
  final _connectivity = Connectivity();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (mounted) {
      setState(() {
        _connectionStatus = result;
      });
    }
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status : $e');

      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  void initState() {
    initConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _connectionStatus == ConnectivityResult.none);
  }
}
