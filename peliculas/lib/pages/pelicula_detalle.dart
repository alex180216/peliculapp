import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  
    //se debe parsear como el objeto que es.. para que lo pueda detectar sin problemas
    final  Pelicula pelicula =  ModalRoute.of(context)!.settings.arguments as Pelicula;

    return Scaffold(
      body: CustomScrollView(
        //los slivers son como los children
        slivers: [
          _crearAppbar(pelicula),
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(//es como un appbar pero mejorcito
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false, //para quitarle la animacion de esconderse con el scroll
      pinned: true, //esconde completo(false) o no (true) el appbar con el scroll
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color:Colors.white),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}