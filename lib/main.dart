import 'package:app_ifix/constants/firebase.dart';
import 'package:app_ifix/controller/banner_controller.dart';
import 'package:app_ifix/controller/fixer_controller.dart';
import 'package:app_ifix/controller/location_controller.dart';
import 'package:app_ifix/controller/product_controller.dart';
import 'package:app_ifix/controller/store_controller.dart';
import 'package:app_ifix/view/authentication/sign_in_screen.dart';
import 'package:app_ifix/view/chat/chat_screen.dart';
import 'package:app_ifix/view/home/home_screen.dart';
import 'package:app_ifix/view/home/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(BannerController());
    Get.put(StoreController());
    Get.put(GeoLocationController());
    Get.put(ProductController());
    Get.put(FixerController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'IFIX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey.shade300,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        currentIndex: _currentIndex,
        onTap: (index) async {
          //    var token = await SPref.get(SPrefCache.KEY_TOKEN);
          if (index == 3) {
            // if (token == null || token == '')
            Get.to(SignInScreen());
          } /* else {
              authController.getProfile();
              Get.to(ProfileScreen());
            } */
          else if (index == 1) {
            Get.to(ChatScreen());
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Tin nhắn",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important),
            label: "Thông báo",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_ind),
            label: "Tài khoản",
          )
        ],
        type: BottomNavigationBarType.fixed,
      ),
      body: getBodyWidget(),
    );
  }

  getBodyWidget() {
    if (_currentIndex == 0) {
      return HomeScreen();
    }
    return NotiFicationScreen();
  }
}
