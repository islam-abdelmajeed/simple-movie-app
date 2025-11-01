import 'package:flutter/material.dart';
import 'core/di/dependency_injection.dart';
import 'core/theme/theme_manager.dart';
import 'movie_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ThemeManager.init();
  await setupServiceLocator();
  runApp(const MovieApp());
}
