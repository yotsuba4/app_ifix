class FixerModel {
  String? avatar;
  String? fName;
  num? rate;

  FixerModel.fromMapHome(Map<String, dynamic> map) {
    avatar = map['avatar'];
    fName = map['fName'];
    rate = map['rate'];
  }
}
