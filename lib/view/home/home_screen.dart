import 'package:app_ifix/constants/controllers.dart';
import 'package:app_ifix/controller/banner_controller.dart';
import 'package:app_ifix/view/home/widget/banner-item.dart';
import 'package:app_ifix/view/search/search.dart';
import 'package:app_ifix/view/store/store_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: GestureDetector(
                      onTap: () {
                        showSearch(context: context, delegate: DataSearch());
                      },
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: "Tìm kiếm",
                          hintStyle: TextStyle(
                              color: Colors.grey.shade400, fontSize: 14),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.grey.shade400,
                          ),
                          contentPadding: EdgeInsets.fromLTRB(8, 10, 8, 0),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CarouselSlider(
                  items: imageSliders,
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        BannerController.instance.currentBanner.value = index;
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    geoLocationController.determinePosition();
                  },
                  child: Container(
                    color: Colors.blue,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    width: MediaQuery.of(context).size.width - 32,
                    height: 70,
                    child: Center(
                        child: Text(
                      'Tiệm sửa xe gần đây?',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                /*  homePageController.isLoadingNewFoods.value
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  )
                : Container(
                    height: 210.h,
                    child: ListView.builder(
                      itemCount: homePageController.newFoodList.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 16),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewItemCard(
                            newItems: homePageController.newFoodList[index]);
                      },
                    ),
                  ),
            SizedBox(
              height: 16.h,
            ), */
                Visibility(
                  visible: storeController.check.value,
                  child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: ListView.builder(
                      itemCount: storeController.stores.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            productController.getAllProducts();
                            Get.to(StoreScreen(),
                                arguments: storeController.stores[index]);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 16,
                                  height: MediaQuery.of(context).size.width / 2,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        storeController.stores[index].image!,
                                    placeholder: (context, url) =>
                                        SpinKitFadingCircle(
                                      color: Colors.grey,
                                      size: 70.0,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                  /* Image.network(
                                    storeController.stores[index].image!,
                                    fit: BoxFit.cover,
                                  ), */
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      storeController.stores[index].name!,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      storeController.stores[index].rate!
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 20)
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      storeController.stores[index].address!,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      storeController
                                              .getDistance(
                                                  geoLocationController
                                                      .currentPosition!,
                                                  storeController.stores[index]
                                                      .location!.latitude,
                                                  storeController.stores[index]
                                                      .location!.longitude)
                                              .toInt()
                                              .toString() +
                                          'm',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 18,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 210,
                  child: ListView.builder(
                    itemCount: fixerController.fixers.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 16),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          width: 136,
                          padding: EdgeInsets.only(right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                child: CachedNetworkImage(
                                    imageUrl:
                                        fixerController.fixers[index].avatar!,
                                    placeholder: (context, url) =>
                                        SpinKitFadingCircle(
                                          color: Colors.grey,
                                          size: 70.0,
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.fill),
                                /* Image.network(
                                  xuLyHttp(widget.newItems.image),
                                  height: 120.h,
                                  width: 180.w,
                                  fit: BoxFit.fill,
                                ), */
                                borderRadius: BorderRadius.circular(5),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                fixerController.fixers[index].fName!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: <Widget>[
                                  RatingBarIndicator(
                                    rating: fixerController.fixers[index].rate!
                                        .toDouble(),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    itemCount: 5,
                                    itemSize: 15,
                                    direction: Axis.horizontal,
                                  ),
                                  /*  SmoothStarRating(
                                    size: 15,
                                    allowHalfRating: false,
                                    color: Colors.yellow,
                                    borderColor: Colors.yellow,
                                    isReadOnly: true,
                                    rating: fixerController.fixers[index].rate!
                                        .toDouble(),
                                  ), */
                                  Text(
                                    ' ' +
                                        fixerController.fixers[index].rate!
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
