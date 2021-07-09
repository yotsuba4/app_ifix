import 'package:app_ifix/constants/firebase.dart';
import 'package:app_ifix/model/fixer_model.dart';
import 'package:get/get.dart';

class FixerController extends GetxController {
  static FixerController instance = Get.find();
  RxList<FixerModel> fixers = <FixerModel>[].obs;
  String collection = "Vehicle_Fixer";
  RxBool check = false.obs;

  @override
  void onReady() {
    super.onReady();
    fixers.bindStream(getAllFixers());
  }

  Stream<List<FixerModel>> getAllFixers() {
    return firebaseFirestore.collection(collection).snapshots().map((query) =>
        query.docs.map((item) => FixerModel.fromMapHome(item.data())).toList());
  }
}
