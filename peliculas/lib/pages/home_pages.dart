import 'package:flutter/material.dart';
import 'package:peliculas/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
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
          children: [_swiperTarjetas()],
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

}
