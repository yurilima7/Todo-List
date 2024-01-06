import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';

class SqlAdmConnection with WidgetsBindingObserver {
  final connection = SqliteConnectionFactory();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        connection.closeConnection();
        break;
      case AppLifecycleState.hidden:
    }
    
    super.didChangeAppLifecycleState(state);
  }
}
