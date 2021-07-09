import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String? name;
  num? rate;
  String? address;
  GeoPoint? location;
  String? image;
  String? storeID;

  StoreModel.fromMapHome(Map<String, dynamic> map) {
    name = map['storeName'];
    rate = map['rate'];
    address = map['address'];
    location = map['location'];
    image = map['image'];
    storeID = map['storeID'];
  }
}
