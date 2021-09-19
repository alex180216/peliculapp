import 'package:peliculas/pages/home_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:peliculas/pages/pelicula_detalle.dart';


Map<String , WidgetBuilder> getMainRoutes(){
  return<String, WidgetBuilder>{
    '/' : (BuildContext context) => HomePage(),
    'detalle' : (BuildContext context) => PeliculaDetalle(),
  };
}