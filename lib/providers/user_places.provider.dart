import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:great_places/models/place.model.dart';
import 'package:great_places/models/place_location.model.dart';

Future<Database> _getDB() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier()
      : super(
          const [],
        );

  Future<void> loadPlaces() async {
    final db = await _getDB();
    final data = await db.query('user_places');
    final places = data.map(
      (e) => Place(
        id: e['id'] as String,
        title: e['title'] as String,
        image: File(e['image'] as String),
        location: PlaceLocation(
          latitude: e['lat'] as double,
          longitude: e['lng'] as double,
          address: e['address'] as String,
        ),
      ),
    ).toList();

    state = places;
  }

  void addPlace({
    required String title,
    required File image,
    required PlaceLocation location,
  }) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');
    final newPlace = Place(
      title: title,
      image: copiedImage,
      location: location,
    );
    final db = await _getDB();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });

    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
