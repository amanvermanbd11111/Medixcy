import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart' hide GeoPoint;
import 'package:videocalling_medical/main.dart';

class AddressAddUpdateController extends GetxController {

  bool isEdit = Get.arguments['isEdit'];

  late GoogleMapController mapController;
  LatLng? center;
  late BitmapDescriptor pinLocationIcon;
  final Map<String, Marker> markers = {};
  RxBool isGoogleMapLoading = true.obs;
  RxBool sLocationUpdated = false.obs;
  RxBool test = true.obs;

  late MapController mapController1;

  TextEditingController tcAddress = TextEditingController();
  RxBool isTcAddressError = false.obs;
  TextEditingController saveAs = TextEditingController();
  RxBool isSaveAsError = false.obs;

  RxBool isDefault = false.obs;
  RxBool mapChange = false.obs;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  onMapTap(LatLng latLng) {
    center = latLng;
    getAddress();
    locateMarker(latLng);
  }

  updateMarkers(LatLng position) async {
    final MarkerId markerId = MarkerId(position.toString());
    final Marker marker = Marker(
      markerId: markerId,
      position: position,
      icon:
          await BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      // Change color
      infoWindow: InfoWindow(
          title: 'New Marker',
          snippet: '${position.latitude}, ${position.longitude}'),
    );
    // Update marker in the map
    markers[markerId.value] = marker;
    // Print updated marker values
    print('Updated Markers: ${markers.values.toList()}');
  }

  Widget map() {
    return Obx(
      () => GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: (sLocationUpdated.value ? center : center) ??
              const LatLng(40.7731125115069, -73.96187393112228),
          zoom: 15.0,
        ),
        onTap: (latLang) {
          print('Tapped Location: $latLang');
          sLocationUpdated.value = false;
          center = latLang;
          onMapTap(latLang);
          locateMarker(center!);
        },
        buildingsEnabled: true,
        compassEnabled: true,
        markers: markers.values.toSet(),
      ),
    );
  }

  getAddress() async {
    if (center == null) {
      var position = await Geolocator.getCurrentPosition();
      center = LatLng(position.latitude, position.longitude);
    }

    List<Placemark> placemarks =
        await placemarkFromCoordinates(center!.latitude, center!.longitude);
    Placemark place = placemarks.first;

    String address =
        '${place.street}, ${place.postalCode}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
    tcAddress.text = address;
    locateMarker(center!);
    isGoogleMapLoading.value = false;
    update();
  }

  locateMarker(LatLng latLng) async {
    mapChange.value = !mapChange.value;
    final marker = Marker(
      draggable: true,
      alpha: 1,
      markerId: const MarkerId("curr_loc"),
      position: latLng,
      infoWindow: InfoWindow(title: 'your_location'.tr),
    );
    markers["Current Location"] = marker;
    sLocationUpdated.value = true;
    print("marker");
    mapChange.value = !mapChange.value;
  }

  initMap() async {
    await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AppImages.pinSvg,
    ).then((onValue) {
      pinLocationIcon = onValue;
    });
    if (!isEdit) {
      getAddress();
    }
    else {
      AddressModel editData = Get.arguments['addressData'];
      tcAddress.text = editData.address ?? '';
      saveAs.text = editData.tag ?? '';
      isDefault.value = editData.defaultAddress == 1;
      center = LatLng(
        double.parse(editData.lat ?? "0.0"),
        double.parse(editData.long ?? "0.0"),
      );
      locateMarker(center!);
      isGoogleMapLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isOsm == true?
    initMapOsm()
        :
    initMap();
  }

  initMapOsm() async {
    mapController1 = MapController(
      initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
      areaLimit: const BoundingBox(
        east: 10.4922941,
        north: 47.8084648,
        south: 45.817995,
        west: 5.9559113,
      ),
    );
    mapController1.init();
    _listenToLocationUpdates();
    isGoogleMapLoading.value = false;
  }

  void _listenToLocationUpdates() {
    mapController1.listenerMapSingleTapping.addListener(() async {
      GeoPoint? point = mapController1.listenerMapSingleTapping.value;
      if (point != null) {
        print("Tapped location: $point");
        onMapTapOsm(point);
      }
    });
    GetOsmAddress();
  }

  GetOsmAddress() async {
    if (!isEdit) {
      var position = await Geolocator.getCurrentPosition();
      center = LatLng(position.latitude, position.longitude);

      print(center);

      List<Placemark> placemarks =
      await placemarkFromCoordinates(center!.latitude, center!.longitude);
      Placemark place = placemarks.first;
      String address =
          '${place.street}, ${place.postalCode}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      tcAddress.text = address;

      double lat = double.tryParse(center!.latitude.toString()) ?? 0.0;
      double lon = double.tryParse(center!.longitude.toString()) ?? 0.0;


      try {
        await mapController1.addMarker(
          GeoPoint(latitude: lat, longitude: lon),
          markerIcon: MarkerIcon(
            iconWidget:
        Image.asset( AppImages.pinSvg,height: 60,width: 60,fit: BoxFit.cover,)
          ),
        );
        _lastMarkerPoint = GeoPoint(latitude: lat, longitude: lon);
      } catch (e) {
        print("Error adding marker: $e");
      }

    } else {
      AddressModel editData = Get.arguments['addressData'];

      if (editData.lat == null || editData.long == null) {
        print("Invalid latitude/longitude");
        return;
      }

      tcAddress.text = editData.address ?? '';
      saveAs.text = editData.tag ?? '';
      isDefault.value = editData.defaultAddress == 1;

      double lat = double.tryParse(editData.lat ?? "0.0") ?? 0.0;
      double lon = double.tryParse(editData.long ?? "0.0") ?? 0.0;

      center = LatLng(lat, lon);
      print("center123456: $center");

      await Future.delayed(Duration(seconds: 1));

      mapController1.init();

      try {
        await mapController1.addMarker(
          GeoPoint(latitude: lat, longitude: lon),
          markerIcon: MarkerIcon(
              iconWidget:
              Image.asset( AppImages.pinSvg,height: 60,width: 60,fit: BoxFit.cover,)
            // icon: Icon(
            //   Icons.location_pin,
            //   color: Colors.red,
            //   size: 48,
            // ),
          ),
        );
        _lastMarkerPoint = GeoPoint(latitude: lat, longitude: lon);
      } catch (e) {
        print("Error adding marker: $e");
      }
    }
  }


  GeoPoint? _lastMarkerPoint;
  String selectedAddress = "Tap on map to get address";

  Future<void> onMapTapOsm(GeoPoint point) async {
    print("object1");
    try {

      center = LatLng(point.latitude, point.longitude);

      print(point);
      print(center);
      print("center123");

      if (_lastMarkerPoint != null) {
        await mapController1.removeMarker(_lastMarkerPoint!);
      }

      await mapController1.addMarker(
        point,
        markerIcon: MarkerIcon(
            iconWidget:
            Image.asset( AppImages.pinSvg,height: 60,width: 60,fit: BoxFit.cover,)
        ),
      );
      // Fetch address details
      List<Placemark> placemarks = await placemarkFromCoordinates(
        point.latitude,
        point.longitude,
      );

      print("placemarks123");
      print(placemarks);

      String address = [
        placemarks.first.street,
        placemarks.first.postalCode,
        placemarks.first.subLocality,
        placemarks.first.locality,
        placemarks.first.administrativeArea,
        placemarks.first.country,
      ].where((e) => e != null && e.isNotEmpty).join(", ");

      _lastMarkerPoint = point;

        selectedAddress = address.isNotEmpty ? address : "Address not found";
      tcAddress.text = selectedAddress;
        print(selectedAddress);
    } catch (e) {
        selectedAddress = "Error fetching address";
        print(selectedAddress);

    }
  }

Widget OsmMapFunc(){
    return
      OSMFlutter(
        controller: mapController1,
        osmOption:  OSMOption(
          userLocationMarker: UserLocationMaker(
            personMarker: const MarkerIcon(
              icon: Icon(
                Icons.circle,
                color: Colors.transparent,
                size: 30,
              ),
            ),
            directionArrowMarker: const MarkerIcon(
              icon: Icon(
                Icons.circle,
                color: Colors.transparent,
                size: 30,
              ),
            ),
          ),
          userTrackingOption: UserTrackingOption(
            enableTracking: true,
            unFollowUser: false,
          ),
          zoomOption: ZoomOption(
            initZoom: 15,
            minZoomLevel: 3,
            maxZoomLevel: 19,
            stepZoom: 1.0,
          ),
          roadConfiguration: RoadOption(roadColor: Colors.yellowAccent),
        ),
        onGeoPointClicked: (GeoPoint point) {
          print("GeoPoint clicked: $point");
          onMapTapOsm(point);
        },
      );

}

  preformAction() async {
    isTcAddressError.value = false;
    isSaveAsError.value = false;
    if (tcAddress.text.isEmpty) {
      isTcAddressError.value = true;
      update();
    } else if (saveAs.text.isEmpty) {
      isSaveAsError.value = true;
      update();
    } else {
      if (isEdit) {
        AddressModel editData = Get.arguments['addressData'];
        int i = await DBHelperCart().updateAddress(
          id: editData.id ?? 0,
          img: AddressModel(
            address: tcAddress.text,
            tag: saveAs.text,
            defaultAddress: isDefault.value ? 1 : 0,
            lat: "${center!.latitude}",
            long: "${center!.longitude}",
          ),
        );

        if (i != 0) {
          Get.back();
        }
      }
      else {
        int i = await DBHelperCart().saveAddress(
          AddressModel(
            address: tcAddress.text,
            tag: saveAs.text,
            defaultAddress: isDefault.value ? 1 : 0,
            lat: "${center!.latitude}",
            long: "${center!.longitude}",
          ),
        );

        if (i != 0) {
          Get.back();
        }
      }
    }
  }

}
