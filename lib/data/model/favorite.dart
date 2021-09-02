class Favorite {
  late int? id;
  late String? idFavorite;
  late String? name;
  late String? desc;
  late String? urlImage;
  late String? city;
  late String? rating;
  late String? foods;
  late String? drinks;

/*  
  int get id => _id;

  String get idFavorite => this._idFavorite;
  set idFavorite(String value) => this._idFavorite;

  String get name => this._name;
  set name(String value) => this._name;

  String get urlImage => this._urlImage;
  set urlImage(String value) => this._urlImage;

  String get city => this._city;
  set city(String value) => this._city;

  String get rating => this._rating;
  set rating(String value) => this._rating;
*/

  Favorite(
      {this.id,
      required this.idFavorite,
      required this.name,
      required this.desc,
      required this.urlImage,
      required this.city,
      required this.rating,
      required this.foods,
      required this.drinks});

/*
  Favorite.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._idFavorite = map['idFavorite'];
    this._name = map['name'];
    this._urlImage = map['urlImage'];
    this._city = map['city'];
    this._rating = map['rating'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['idFavorite'] = this._idFavorite;
    map['name'] = this._name;
    map['urlImage'] = this._urlImage;
    map['city'] = this._city;
    map['rating'] = this._rating;
    return map;
  }
*/
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idfavorit': idFavorite,
      'name': name,
      'desc': desc,
      'urlimage': urlImage,
      'city': city,
      'rating': rating,
      'foods': foods,
      'drinks': drinks,
    };
  }

  Favorite.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idFavorite = map['idfavorite'];
    name = map['name'];
    desc = map['desc'];
    urlImage = map['urlimage'];
    city = map['city'];
    rating = map['rating'];
    foods = map['foods'];
    drinks = map['drinks'];
  }
}
