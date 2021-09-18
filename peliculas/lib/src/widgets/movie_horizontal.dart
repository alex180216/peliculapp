import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';

//es un stateless porque va a recibir los datos del padre,
//por lo que no va a mantener o cambiar su estado
class MovieHorizontal extends StatelessWidget { 
  
  final List<Pelicula> peliculas;

  //propiedad para recargar proxima pagina de populares
  final Function siguientePagina;

  MovieHorizontal({required this.peliculas, required this.siguientePagina});

  final _pageController = PageController(
          initialPage: 1, //empieza con la pagina 1
          viewportFraction: 0.3); //cuantas tarjetas quieres mostrar en el viewPort);

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    //listener para escuchar todos los cambios en el pageviewController
    _pageController.addListener(() {
      //si la posicion del pageController es mayor o igual a la maxima medida de scroll - 200 px
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){

        //cargar siguientes peliculas
        //print('cargar siguientes');
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.3, //el 30%
      child: PageView(
        controller:_pageController,
        children: _tarjetas(context),
        pageSnapping: false, //para quitarle el efecto pegajoso en el movimiento(scroll) de las tarjetas
      ),  
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula){
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                image: NetworkImage( pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 3,),
            Text(
              pelicula.title, 
              overflow: TextOverflow.ellipsis,//coloca los 3 puntos de continuar, si el texto no cabe
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}