import 'package:app_ifix/constants/firebase.dart';
import 'package:app_ifix/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  RxList<ProductModel> products = <ProductModel>[].obs;
  String collection = "products";
  RxBool check = false.obs;

  @override
  void onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() {
    return firebaseFirestore.collection(collection).snapshots().map((query) =>
        query.docs
            .map((item) => ProductModel.fromMapStore(item.data()))
            .toList());
  }
}
