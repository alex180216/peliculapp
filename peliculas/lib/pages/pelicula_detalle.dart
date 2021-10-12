import 'package:flutter/material.dart';
import 'package:peliculas/models/actores_model.dart';
import 'package:peliculas/models/pelicula_model.dart';
import 'package:peliculas/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {

  final List<Actor> actores = [];

  @override
  Widget build(BuildContext context) {
  
    //se debe parsear como el objeto que es.. para que lo pueda detectar sin problemas
    final  Pelicula pelicula =  ModalRoute.of(context)!.settings.arguments as Pelicula;

    return Scaffold(
      body: CustomScrollView(
        //los slivers son como los children y hacen ciertas cosas con el customScrollView
        slivers: [
          _crearAppbar(pelicula),
          SliverList(//elementos normales, es como un listView, pero en lugar del children, tiene un delegation
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                _crearCasting(pelicula),
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

  Widget _crearCasting(Pelicula pelicula) {
    
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot){
        //print(snapshot); //esto retorna una lista de instancias de actores
        if(snapshot.hasData){ //cuando haya data del future, muestrala
          return _crearActoresPageView(snapshot.data as List<Actor>, context);
        }else{ //sino, muestra un loader
          return Center(
            child: CircularProgressIndicator() ,
          );
        }
      }
    );
  }

  Widget _crearActoresPageView(List<Actor> actores, BuildContext context) {
    //print(actores);
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actores.length,
        itemBuilder:(context, i) => _actorTarjeta(actores[i], context)
      ),
    );
    
  }

  Widget _actorTarjeta(Actor actor, BuildContext context){

    final _sizeScreen = MediaQuery.of(context).size;

    return Container(
      padding:EdgeInsets.symmetric(horizontal: _sizeScreen.width * 0.01),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(_sizeScreen.width * 0.03),
            child: FadeInImage(
              image: NetworkImage(actor.getFoto()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: _sizeScreen.height * 0.25,
              fit: BoxFit.cover,
            ),
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }
}