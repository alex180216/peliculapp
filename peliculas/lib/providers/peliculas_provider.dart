import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:peliculas/models/pelicula_model.dart';

class PeliculasProvider{
  String _apikey = '25206e097ede44bbb85c5424e1444810';
  String _url ='api.themoviedb.org';
  String _language = 'es';

  int _popularesPage = 0; //para el Stream
  bool _cargando = false;

  //la info del stream
  List<Pelicula> _populares = [];

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();//broadcast, para que pueda ser escuchado por varios widgets

  //la entrada del stream
  //osea, el sink
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;//agregamos peliculas al afluente del stream

  //la salida del stream
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  //metodo para hacer que se cierren los streams
  void disposeStreams(){
    _popularesStreamController.close(); //el ?. dice,si tiene un valor, lo va a cerrar; sino tiene, no lo cierra
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final respuesta = await http.get(url);

    if(respuesta.statusCode == 200){

      //decodificar respuesta
      Map<String, dynamic> decodedData = json.decode(respuesta.body);
     

      List<Pelicula> listaDePeliculas = [];

      for(var pelicula in decodedData['results']){
        listaDePeliculas.add(Pelicula.fromJsonMap(pelicula));
      }

      return listaDePeliculas;

    }else{
      throw Exception('Falló la consulta');
    }
  }

  
  Future<List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url, '3/movie/now_playing', { //este metodo le setea automaticamente el https
      'api_key' : _apikey,
      'language' : _language
    }); 

    return await _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async{
    
    if(_cargando) return []; //si esta cargando, retorname una lista vacia,

    //si no esta cargando, haz la solicitud. Esto es para evitar que haga solicitudes http antes de llegar
    //al final de la lista de peliculas, y, ademas,ponme _cargando como true
    _cargando = true;
    _popularesPage++;

    print('Cargando siguientes...');

    final url = Uri.https(_url, '3/movie/popular', { //este metodo le setea automaticamente el https
      'api_key' : _apikey,
      'language' : _language,
      'page':_popularesPage.toString()
    }); 


    //cambios a stream
    final resp = await _procesarRespuesta(url);//esto es lo que quiero mandar por el stream

    _populares.addAll(resp);//addAll() es una funcion para insertar listas, y resp es una lista
    popularesSink(_populares);//añadiendo info al stream medio el sink
    
    //una vez hecha la solicitud, ponme a _cargando en false
    _cargando = false;

    return resp;
  }

}