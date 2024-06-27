import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';

class ContactUs extends StatelessWidget{
  ContactUs({super.key});

  final GetController _getController = Get.put(GetController());

  late IconData zoomInIcon;
  late IconData zoomOutIcon;
  late IconData currentLocationIcon;
  late IconData locationPinIcon;
  late Color buttonColor;
  late Color buttonTextColor;
  late Color locationPinIconColor;
  late String locationPinText;
  late TextStyle locationPinTextStyle;
  late String buttonText;
  late String hintText;
  late double buttonHeight;
  late double buttonWidth;
  late TextStyle buttonTextStyle;
  late String baseUri;


  /*Future<Position?> getCurrentPosLatLong() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      return await getPosition(locationPermission);
    }

    Position position = await Geolocator.getCurrentPosition();
    setNameCurrentPosAtInit(position.latitude, position.longitude);
    return position;
  }

  Future<Position?> getPosition(LocationPermission locationPermission) async {
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      return null;
    }
    Position position = await Geolocator.getCurrentPosition();
    setNameCurrentPosAtInit(position.latitude, position.longitude);
    return position;
  }

  void setNameCurrentPos() async {
    double latitude = _getController.mapController.center.latitude;
    //double latitude = 41.322518;
    double longitude = _getController.mapController.center.longitude;
    //double longitude = 69.241264;
    if (kDebugMode) {
      print(latitude);
    }
    if (kDebugMode) {
      print(longitude);
    }
  }

  void setNameCurrentPosAtInit(double latitude, double longitude) async {
    if (kDebugMode) {
      print(latitude);
    }
    if (kDebugMode) {
      print(longitude);
    }
  }


  Future<PickedData> pickData() async {
    LatLong center = LatLong(_getController.mapController.center.latitude, _getController.mapController.center.longitude);
    var client = http.Client();
    String url = 'https://nominatim.openstreetmap.org/reverse?format=json&lat=${_getController.mapController.center.latitude}&lon=${_getController.mapController.center.longitude}&zoom=18&addressdetails=1';
    var response = await client.get(Uri.parse(url));
    var decodedResponse =
    jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
    String displayName = decodedResponse['display_name'];
    return PickedData(center, displayName, decodedResponse["address"]);
  }
*/
  @override
  Widget build(BuildContext context) {
    zoomOutIcon = Icons.zoom_out_map;
    zoomInIcon = Icons.zoom_in_map;
    currentLocationIcon = Icons.my_location;
    buttonColor = Colors.blue;
    locationPinIconColor = Colors.blue;
    locationPinText = 'Location';
    locationPinTextStyle = const TextStyle(
    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue);
    hintText = 'Search Location';
    buttonTextStyle = const TextStyle(
    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);
    buttonTextColor = Colors.white;
    buttonText = 'Get directions';
    buttonHeight = 50;
    buttonWidth = 200;
    baseUri = 'https://nominatim.openstreetmap.org';
    locationPinIcon = Icons.location_on;
    ApiController().getContactUs();
    //_getController.mapController = MapController();


    /*_getController.mapController.mapEventStream.listen((event) async {
        if (event is MapEventMoveEnd) {
          var client = http.Client();
          String url =
              'https://nominatim.openstreetmap.org/reverse?format=json&lat=${event.camera.center.latitude}&lon=${event.camera.center.longitude}&zoom=18&addressdetails=1';
          var response = await client.get(Uri.parse(url));
          var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes))
          as Map<dynamic, dynamic>;
          print(decodedResponse);
        }
      });*/

    final Completer<GoogleMapController> _controller =
    Completer<GoogleMapController>();

    CameraPosition _kGooglePlex = CameraPosition(
      zoom: 14.4746,
      target: LatLng(41.322518, 69.241264),
    );

    const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    tilt: 59.440717697143555,
    zoom: 19.151926040649414, target: LatLng(41.322518, 69.241264));


    return Scaffold(
      appBar: AppBar(
          title: Text('Dastur haqida'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 20.sp),
              onPressed: () {
                Get.back();
              }
          )
      ),
      body: SingleChildScrollView(
          child: Obx(() => _getController.contactUsModel.value.data == null
              ? !_getController.onLoading.value
              ? SizedBox(height: Get.height * 0.8, width: Get.width, child: Center(child: Text('Ma‘lumotlar yo‘q!'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface))))
              : Skeletonizer(child: Container(
                  margin: EdgeInsets.only(top: _getController.width.value * 0.04, left: _getController.width.value * 0.03,right: _getController.width.value * 0.03),
                  child: Column(
                      children: [
                        Container(
                            width: Get.width,
                            padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 1)
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Bog‘lanish'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
                                  SizedBox(height: 10.h),
                                  Row(
                                      children: [
                                        Icon(Icons.phone, color: AppColors.backgroundApp, size: 20.sp),
                                        SizedBox(width: 10.w),
                                        Text('Bog‘lanish uchun:'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                      ]
                                  ),
                                  SizedBox(height: 10.h),
                                  Text('+998 (99) 534 03 13', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                  SizedBox(height: 10.h),
                                  Row(
                                      children: [
                                        Icon(Icons.phone, color: AppColors.backgroundApp, size: 20.sp),
                                        SizedBox(width: 10.w),
                                        Text('Hamkorlar uchun bog‘lanish:'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                      ]
                                  ),
                                  SizedBox(height: 10.w),
                                  Text('+998 (99) 534 03 13', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                  SizedBox(height: 10.w),
                                  Row(
                                      children: [
                                        Icon(TablerIcons.world, color: AppColors.backgroundApp, size: 20.sp),
                                        SizedBox(width: 10.w),
                                        Text('Ijtimoiy tarmoqlar:'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                      ]
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                      children: [
                                        Container(
                                            height: 35.h,
                                            width: 35.w,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                            child: IconButton(onPressed: () {},
                                                icon: Icon(
                                                    TablerIcons.brand_youtube,
                                                    color: AppColors.backgroundApp, size: 20.sp
                                                )
                                            )
                                        ),
                                        SizedBox(width: 15.w),
                                        Container(
                                            height: 35.h,
                                            width: 35.w,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                            child: IconButton(onPressed: () {},
                                                icon: Icon(
                                                    TablerIcons.brand_instagram,
                                                    color: AppColors.backgroundApp, size: 20.sp
                                                )
                                            )
                                        ),
                                        SizedBox(width: 15.w),
                                        Container(
                                            height: 35.h,
                                            width: 35.w,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                            child: IconButton(onPressed: () {},
                                              icon: Icon(
                                                  TablerIcons.brand_telegram,
                                                  color: AppColors.backgroundApp,
                                                  size: 20.sp
                                              ),
                                            )
                                        ),
                                        SizedBox(width: 15.w),
                                        Container(
                                            height: 35.h,
                                            width: 35.w,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                            child: IconButton(onPressed: () {},
                                                icon: Icon(
                                                    TablerIcons.brand_facebook,
                                                    color: AppColors.backgroundApp,
                                                    size: 20.sp
                                                )
                                            )
                                        )
                                      ]
                                  )
                                ]
                            )
                        ),
                        SizedBox(height: 20.h),
                        Container(
                            width: Get.width,
                            padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 1)
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Ildiz kitoblari Xadra filiali'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
                                  SizedBox(height: 10.h),
                                  Row(
                                      children: [
                                        Icon(TablerIcons.world, color: AppColors.backgroundApp, size: 20.sp),
                                        SizedBox(width: 10.w),
                                        Text('Manzil'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                      ]
                                  ),
                                  SizedBox(height: 10.h),
                                  Text('Farg‘ona viloyati O‘zbekiston tumani'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                ]
                            )
                        )
                      ]
                  )
              ))
              : Column(children: [
                Container(
                    width: Get.width,
                    margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                    padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 1)
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bog‘lanish'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
                          SizedBox(height: 10.h),
                          Row(
                              children: [
                                Icon(Icons.phone, color: AppColors.backgroundApp, size: 20.sp),
                                SizedBox(width: 10.w),
                                Text('Bog‘lanish uchun:'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                              ]
                          ),
                          SizedBox(height: 10.h),
                          Text(_getController.contactUsModel.value.data!.result!.phone.toString(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                          SizedBox(height: 10.h),
                          Row(
                              children: [
                                Icon(Icons.phone, color: AppColors.backgroundApp, size: 20.sp),
                                SizedBox(width: 10.w),
                                Text('Hamkorlar uchun bog‘lanish:'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                              ]
                          ),
                          SizedBox(height: 10.w),
                          Text(_getController.contactUsModel.value.data!.result!.corpPhone.toString(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                          SizedBox(height: 10.w),
                          Row(
                              children: [
                                Icon(TablerIcons.world, color: AppColors.backgroundApp, size: 20.sp),
                                SizedBox(width: 10.w),
                                Text('Ijtimoiy tarmoqlar:'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                              ]
                          ),
                          SizedBox(height: 15.h),
                          Row(
                              children: [
                                Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                    child: IconButton(onPressed: () {
                                      launchUrl(Uri.parse(_getController.contactUsModel.value.data!.result!.socials!.youtube.toString()), mode: LaunchMode.externalApplication);
                                    },
                                        icon: Icon(
                                            TablerIcons.brand_youtube,
                                            color: AppColors.backgroundApp, size: 20.sp
                                        )
                                    )
                                ),
                                SizedBox(width: 15.w),
                                Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                    child: IconButton(onPressed: () {
                                      launchUrl(Uri.parse(_getController.contactUsModel.value.data!.result!.socials!.instagram.toString()), mode: LaunchMode.externalApplication);
                                    },
                                        icon: Icon(
                                            TablerIcons.brand_instagram,
                                            color: AppColors.backgroundApp, size: 20.sp
                                        )
                                    )
                                ),
                                SizedBox(width: 15.w),
                                Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                    child: IconButton(onPressed: () {
                                      launchUrl(Uri.parse(_getController.contactUsModel.value.data!.result!.socials!.telegram.toString()), mode: LaunchMode.externalApplication);
                                    },
                                      icon: Icon(
                                          TablerIcons.brand_telegram,
                                          color: AppColors.backgroundApp,
                                          size: 20.sp
                                      ),
                                    )
                                ),
                                SizedBox(width: 15.w),
                                Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                    child: IconButton(onPressed: () {
                                      launchUrl(Uri.parse(_getController.contactUsModel.value.data!.result!.socials!.facebook.toString()), mode: LaunchMode.externalApplication);
                                    },
                                        icon: Icon(
                                            TablerIcons.brand_facebook,
                                            color: AppColors.backgroundApp,
                                            size: 20.sp
                                        )
                                    )
                                )
                              ]
                          )
                        ]
                    )
                ),
                Container(
                    width: Get.width,
                    margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w, bottom: 20.h),
                    padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 1)
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ildiz kitoblari Xadra filiali'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
                          SizedBox(height: 10.h),
                          Row(
                              children: [
                                Icon(TablerIcons.world, color: AppColors.backgroundApp, size: 20.sp),
                                SizedBox(width: 10.w),
                                Text('Manzil'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                              ]
                          ),
                          SizedBox(height: 10.h),
                          Html(
                              style: {'p': Style(textAlign: TextAlign.justify, fontSize: FontSize(16.sp), fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface)},
                              data: _getController.contactUsModel.value.data!.result!.address!.uz.toString()
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: Get.width,
                            height: Get.height * 0.3,
                            child: GoogleMap(
                              mapType: MapType.hybrid,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                          ),
                          /*SizedBox(
                            width: Get.width,
                            height: Get.height * 0.5,
                            child: OpenStreetMapSearchAndPick(
                                buttonWidth: Get.width,
                                locationPinTextStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                                locationPinIconColor: Colors.red,
                                zoomInIcon: Icons.zoom_in,
                                zoomOutIcon: Icons.zoom_out,
                                baseUri: 'https://nominatim.openstreetmap.org',
                                locationPinText: 'Ildiz kitoblari Xadra filiali'.tr,
                                buttonTextStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                                currentLocationIcon: Icons.location_on,
                                hintText: 'Manzilni kiriting'.tr,
                                locationPinIcon: Icons.location_on,
                                buttonText: 'Open Map'.tr,
                                onPicked: (pickedData) {
                                  debugPrint('');
                                })
                          ),*/
                          /*SizedBox(
                            width: Get.width,
                            height: Get.height * 0.3,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                    child: FlutterMap(
                                        options: const MapOptions(center: LatLng(41.322518,69.241264), zoom: 15.0, maxZoom: 18, minZoom: 6),
                                        mapController: _getController.mapController,
                                        children: [
                                          TileLayer(
                                              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                              subdomains: const ['a', 'b', 'c']
                                          )
                                        ]
                                    )
                                ),
                                Positioned.fill(
                                  child: IgnorePointer(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Location',
                                              style: locationPinTextStyle,
                                              textAlign: TextAlign.center),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 50),
                                            child: Icon(
                                              Icons.location_on,
                                              size: 50,
                                              color: Colors.red
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 60,
                                    right: 5,
                                    child: FloatingActionButton(
                                        heroTag: 'btn3',
                                        backgroundColor: Colors.black54,
                                        onPressed: () async {
                                          if (mapCentre != null) {
                                            _getController.mapController.move(
                                                LatLng(mapCentre!.latitude, mapCentre!.longitude),
                                                _getController.mapController.zoom);
                                          } else {
                                            _getController.mapController.move(
                                                LatLng(50.5, 30.51), _getController.mapController.zoom);
                                          }
                                        },
                                        child: Icon(
                                            currentLocationIcon,
                                            color: buttonTextColor
                                        )
                                    )
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: buttonColor,
                                          foregroundColor: buttonTextColor,
                                          textStyle: buttonTextStyle,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                          )
                                        ),
                                        onPressed: (){
                                          getCurrentPosLatLong();
                                        },
                                        child: Text(buttonText)
                                      )
                                  ),
                                ))
                                *//*Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: WideButton(
                                        buttonText,
                                        textStyle: buttonTextStyle,
                                        height: buttonHeight,
                                        width: buttonWidth,
                                        onPressed: () async {
                                          final value = await pickData();
                                        },
                                        backgroundColor: buttonColor,
                                        foregroundColor: buttonTextColor,
                                      ),
                                    ),
                                  ),
                                )*//*
                              ]
                            )
                          )*/
                        ]
                    )
                )
              ])
          )
      )
    );
  }
}

class OSMdata {
  final String displayname;
  final double lat;
  final double lon;
  OSMdata({required this.displayname, required this.lat, required this.lon});
  @override
  String toString() {
    return '$displayname, $lat, $lon';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is OSMdata && other.displayname == displayname;
  }

  @override
  int get hashCode => Object.hash(displayname, lat, lon);
}

class LatLong {
  final double latitude;
  final double longitude;
  const LatLong(this.latitude, this.longitude);
}

class PickedData {
  final LatLong latLong;
  final String addressName;
  final Map<String, dynamic> address;

  PickedData(this.latLong, this.addressName, this.address);
}