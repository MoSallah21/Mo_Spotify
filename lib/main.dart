import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mospotify/core/theme/theme.dart';
import 'package:mospotify/features/auth/view/pages/login_page.dart';
import 'package:mospotify/features/auth/viewmodel/auth_viewmodel.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final container=ProviderContainer();
  await container.read(authViewmodelProvider.notifier).initSharedPreferences();

  runApp(
      UncontrolledProviderScope(
      container: container,
      child: MyApp(),

      )
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mo Spotify',
      theme: AppTheme.dartThemeMode,
      home:LoginPage(),
    );
  }
}
