import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stories/pages/home_page.dart';
import 'package:stories/theme/theme_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kumpulan Cerita',
        theme: Provider.of<ThemeProvider>(context).themeData,
        home: const HomePage(),
      ),  
    );
  }
}
