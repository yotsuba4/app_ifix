class ProductModel {
  String? image;
  String? pdtName;
  num? price;

  ProductModel.fromMapStore(Map<String, dynamic> map) {
    image = map['image'];
    pdtName = map['pdtName'];
    price = map['price'];
  }
}
