import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  
    //se debe parsear como el objeto que es.. para que lo pueda detectar sin problemas
    final  Pelicula pelicula =  ModalRoute.of(context)!.settings.arguments as Pelicula;

    return Scaffold(
      body: CustomScrollView(
        //los slivers son como los children y hacen ciertas cosas con el customScrollView
        slivers: [
          _crearAppbar(pelicula),
          SliverList(//elementos normales, es como un listView, pero en lugar del children, tiene un children
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula)
              ]
            ),
          )
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(//es como un appbar pero mejorcito
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false, //para quitarle la animacion de esconderse con el scroll en la parte superior
      pinned: true, //esconde completo(false) o no (true) el appbar con el scroll
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color:Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(image: NetworkImage(pelicula.getPosterImg()),
            height: 150.0,),
          ),
          SizedBox(width: 20.0,),
          Flexible(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pelicula.title, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis,),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis),
                Row(children: [
                  Icon(Icons.star_border),
                  Text(pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle1)
                ],)
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical:20.0),
      child: Text(pelicula.overview, textAlign: TextAlign.justify,)
    );
  }
}