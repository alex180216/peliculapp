import 'package:flutter/material.dart';
import 'package:peliculas/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    //stream
    peliculasProvider.getPopulares();



    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
      ),

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }
  Widget _swiperTarjetas() {
 
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if(snapshot.hasData){ //cuando haya data del future, muestrala
          return CardSwiper(peliculas: snapshot.data);

        }else{ //sino, muestra un loader
          return Container(
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }

      }
    );
  }

  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity, //para que agarre todo el espacio de ancho
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left:20),
            child: Text('Populares', style: Theme.of(context).textTheme.subtitle1,)
          ),//para centralizar el thema de toda la app de manera global
          SizedBox(height: 3,),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if(snapshot.hasData){ //cuando haya data del future, muestrala
                //snapshot.data?.forEach((p) => print(p.title));
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,  
                );

              }else{ //sino, muestra un loader
                return Container(
                  child: Center(
                    child: CircularProgressIndicator()
                  )
                );
              }

            }
          )
        ],
      ),
    );
  }
}
