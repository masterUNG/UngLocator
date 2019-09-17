import 'package:flutter/material.dart';
import 'package:ung_locator/models/food_model.dart';
import 'package:ung_locator/screens/my_style.dart';

class DetailFood extends StatefulWidget {
  final FoodModel foodModel;
  DetailFood({Key key, this.foodModel}) : super(key: key);

  @override
  _DetailFoodState createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  // Explicit
  FoodModel myFoodModel;

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

  Widget showDetail() {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: <Widget>[
        showNameFood(),
        showImageFood(),
        showNameShop(),
        showAddressShop(),
        showTimeShop(),
        showDetailFood(),
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
