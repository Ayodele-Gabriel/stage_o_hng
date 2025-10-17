import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_o_hng/profile_screen.dart';
import 'package:stage_o_hng/utilities/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: themeProvider.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const ProfileScreen(),
        );
      }
    );
  }
}