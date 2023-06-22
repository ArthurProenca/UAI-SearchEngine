import 'package:flutter/material.dart';
import 'package:uai/src/screens/home/home.dart';
import 'package:uai/src/screens/search/result/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'UAI - Cadê?',
        initialRoute: SearchForm.route,
        routes: {
          SearchForm.route: (context) => const SearchForm(),
          SearchResult.route: (context) => const SearchResult(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ));
  }
}
