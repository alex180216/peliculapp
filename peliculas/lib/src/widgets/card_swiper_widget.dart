import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:peliculas/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Pelicula> peliculas;


//constructor, aca inicializamos a esta lista
  CardSwiper({ required this.peliculas});

  @override
  Widget build(BuildContext context) {

    //el mediaQuery nos da informacion del tamaño de la pantalla del dispositivo
    final _screenSize = MediaQuery.of(context).size;

    
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child:Swiper(
        itemBuilder: (BuildContext context, int index) {
          //setear id unico para las tarjetas aunque se repita el id de las peliculas, para que 
          //pueda funcionar el HeroAnimation, hacemos una edicion en el model de peliculas===> anda a pelicula_model.dart
          //revisalo, y vuelve

          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta-principal';


          return Hero(
            tag: peliculas[index].uniqueId as Object,
            child: ClipRRect( //para crear el borde circular
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage( peliculas[index].getPosterImg()),
                  fit: BoxFit.fill,
                ),
              )
            ),
          );
        },
        indicatorLayout: PageIndicatorLayout.SCALE,
        itemCount: peliculas.length,
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.6, //el 60% del ancho
        itemHeight: _screenSize.height *0.45, //el 45% del alto
        
      )
    );
  }
}