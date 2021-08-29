import 'package:flutter/material.dart';
import 'package:peliculas/src/routes/routes_main.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes: getMainRoutes(),
    );
  }
}
