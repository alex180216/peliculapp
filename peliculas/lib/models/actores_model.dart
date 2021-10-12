//para trabajar con la lista completa de actores
class Cast{
  List<Actor> items = [];

  //constructor
  Cast({required this.items});

  //constructor nuevo
  factory Cast.fromJsonList(Map<String, dynamic> jsonList){

    List listActores = jsonList['cast'];

    List<Actor>? actoresList = listActores.map((item) => Actor.fromJsonMap(item)).toList();

    return Cast(items: actoresList);
    /* if(jsonList == null) return;
    
    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    }); */
  }
}

//para trabajar con un actor solito

class Actor {
  final int gender;
  final int id;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;

  Actor({
    required this.gender,
    required this.id,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.character,
    required this.creditId,
    required this.order,
    required this.castId
  });

  factory Actor.fromJsonMap(Map<String, dynamic> json){
    return Actor(
      gender            : json['gender'] as int,
      id                : json['id'] as int,
      name              : json['name'] as String,
      originalName      : json['original_name'] as String,
      popularity        : json['popularity'] / 1 as double,//para que lo tome como double cuando venga cerrado[ 5.0 => se transforma en 5 (entero)],
      profilePath       : json['profile_path'], 
      character         : json['character'] as String,
      creditId          : json['credit_id'] as String,
      order             : json['order'] as int,
      castId            : json['cast_id'] as int
    );
  }

  getFoto(){
    // ignore: unnecessary_null_comparison
    if(profilePath == null){
      return 'https://static.wikia.nocookie.net/rockyhorrorshow/images/e/e2/Sinperfil.png/revision/latest?cb=20171004220441&path-prefix=es';
    }
    return 'https://image.tmdb.org/t/p/w500$profilePath';
  }
}
