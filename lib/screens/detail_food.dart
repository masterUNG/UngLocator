import 'package:flutter/material.dart';
import 'package:ung_locator/models/food_model.dart';
import 'package:ung_locator/screens/my_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailFood extends StatefulWidget {
  final FoodModel foodModel;
  DetailFood({Key key, this.foodModel}) : super(key: key);

  @override
  _DetailFoodState createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  // Explicit
  FoodModel myFoodModel;
  static const LatLng centerMap = const LatLng(13.667765, 100.621888);
  CameraPosition cameraPosition = CameraPosition(target: centerMap, zoom: 16);

  // Method
  @override
  void initState() {
    super.initState();
    setState(() {
      myFoodModel = widget.foodModel;
    });
  }

  Widget showNameShop() {
    return Text(
      'ชื่อร้านค้า ${myFoodModel.nameShop}',
      style: TextStyle(
        fontSize: MyStyle().h2,
      ),
    );
  }

  Widget showAddressShop() {
    return Text(
      'Address ${myFoodModel.address}',
      style: TextStyle(
        fontSize: MyStyle().h2,
      ),
    );
  }

  Widget showTimeShop() {
    return Text(
      'เวลาปิดเปิดร้าน ${myFoodModel.timeOpenCloss}',
      style: TextStyle(
        fontSize: MyStyle().h2,
      ),
    );
  }

  Widget showDetailFood() {
    return Text(
      'รายละเอียด ${myFoodModel.detail}',
      style: TextStyle(
        fontSize: MyStyle().h2,
      ),
    );
  }

  Widget showImageFood() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.all(20.0),
      child: Image.network(
        myFoodModel.pathURL,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget showNameFood() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          myFoodModel.nameFood,
          style: TextStyle(
            fontSize: MyStyle().h1,
            color: MyStyle().myTextColor,
          ),
        ),
      ],
    );
  }

  Widget showMap() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.width * 0.6,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController googleMapController) {},
      ),
    );
  }

  Widget showDetail() {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: <Widget>[
        showNameFood(),
        showImageFood(),
        showNameShop(),
        SizedBox(
          height: 8.0,
        ),
        showAddressShop(),
        SizedBox(
          height: 8.0,
        ),
        showTimeShop(),
        SizedBox(
          height: 8.0,
        ),
        showDetailFood(),
        SizedBox(
          height: 16.0,
        ),
        showMap(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().myMainColor,
        title: Text('Detail'),
      ),
      body: showDetail(),
    );
  }
}
