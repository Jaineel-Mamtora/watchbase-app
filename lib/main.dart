import 'package:material_ui/material_ui.dart';

import 'package:watchbase_app/app/app.dart';
import 'package:watchbase_app/core/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(const WatchBaseApp());
}
