import 'package:peliculas/pages/home_pages.dart';
import 'package:flutter/cupertino.dart';


Map<String , WidgetBuilder> getMainRoutes(){
  return<String, WidgetBuilder>{
    '/' : (BuildContext context) => HomePage(),
  };
}