import 'package:flutter/material.dart';

import 'package:watchbase_app/app/app.dart';
import 'package:watchbase_app/core/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(const WatchBaseApp());
}
