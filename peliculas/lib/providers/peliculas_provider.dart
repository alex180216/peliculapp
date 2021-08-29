import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/models/pelicula_model.dart';

class PeliculasProvider{
  String _apikey = '25206e097ede44bbb85c5424e1444810';
  String _url ='api.themoviedb.org';
  String _language = 'es';

  
  Future<List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url, '3/movie/now_playing', { //este metodo le setea automaticamente el https
      'api_key' : _apikey,
      'language' : _language
    }); 

    final respuesta = await http.get(url);

    if(respuesta.statusCode == 200){

      //decodificar respuesta
      Map<String, dynamic> decodedData = json.decode(respuesta.body);
     

      List<Pelicula> listaDePeliculas = [];

      for(var pelicula in decodedData['results']){
        listaDePeliculas.add(Pelicula.fromJsonMap(pelicula));
      }

      print(listaDePeliculas); //me retorna una lista de instancias de Pelicula


    return listaDePeliculas;

    }else{
      throw Exception('Falló la consulta');
    }


  }

}