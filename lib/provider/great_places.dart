import 'dart:io';
import 'package:flutter/widgets.dart';

import '../models/place.dart';
import '../helpers/db_connection.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File img,Placelocation coordinate) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: img,
        title: pickedTitle,
        location: coordinate);

    _items.add(newPlace);
    notifyListeners();
    DBHelper.addPlace('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat':newPlace.location.latitude,
      'long':newPlace.location.longitude
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList =await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: Placelocation(latitude: item['lat'],longitude: item['long'])))
        .toList();
    notifyListeners();    
  }
}
