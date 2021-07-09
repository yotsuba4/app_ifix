import 'package:app_ifix/constants/firebase.dart';
import 'package:app_ifix/model/store_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  static StoreController instance = Get.find();
  RxList<StoreModel> stores = <StoreModel>[].obs;
  String collection = "stores";
  RxBool check = false.obs;

  @override
  void onReady() {
    super.onReady();
    stores.bindStream(getAllStores());
  }

  Stream<List<StoreModel>> getAllStores() {
    return firebaseFirestore.collection(collection).snapshots().map((query) =>
        query.docs.map((item) => StoreModel.fromMapHome(item.data())).toList());
  }

  void sortByDistance(Position curent) {
    stores.sort((a, b) =>
        getDistance(curent, a.location!.latitude, a.location!.longitude)
            .compareTo((getDistance(
                curent, b.location!.latitude, b.location!.longitude))));
  }

  double getDistance(
      Position current, double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(
        current.latitude, current.longitude, endLatitude, endLongitude);
  }
}
