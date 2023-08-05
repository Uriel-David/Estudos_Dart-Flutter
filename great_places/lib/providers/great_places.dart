import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get itemsCounts {
    return _items.length;
  }

  Place getItemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: PlaceLocation(latitude: 0.0000, longitude: 0.0000),
      image: image,
    );

    _items.add(newPlace);
    notifyListeners();
  }
}
