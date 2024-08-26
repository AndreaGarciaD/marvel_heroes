import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/personaje_model.dart';
import 'package:marvel_heroes/pages/home_page.dart';
import 'package:marvel_heroes/pages/personaje_detail.dart';
import 'package:marvel_heroes/pages/personaje_form.dart';
import 'package:marvel_heroes/pages/superherolist_page.dart';
import 'package:marvel_heroes/providers/database_provider.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  //await DatabaseProvider.deleteDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromRGBO(242, 38, 75, 1)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (context) =>
                    const MyHomePage(title: 'Flutter Demo Home Page'));
          case '/superherolist':
            return MaterialPageRoute(
                builder: (context) => const SuperheroListPage());
          case '/personajeform':
            return MaterialPageRoute(
                builder: (context) => const PersonajeFormPage());
          case '/personajedetail':
            final personaje = settings.arguments as Personaje;
            return MaterialPageRoute(
              builder: (context) => PersonajeDetailPage(personaje: personaje),
            );
          default:
            return MaterialPageRoute(
                builder: (context) =>
                    const MyHomePage(title: 'Flutter Demo Home Page'));
        }
      },
    );
  }
}
