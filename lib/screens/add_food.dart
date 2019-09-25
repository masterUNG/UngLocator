import 'package:flutter/material.dart';

class AddFood extends StatefulWidget {
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  // Explicit

  // Method
  Widget nameFoodText() {
    Color color = Colors.purpleAccent;
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(
            Icons.fastfood,
            color: color,
            size: 36.0,
          ),
          labelText: 'ชื่อ อาหาร',
          labelStyle: TextStyle(color: color),
          helperText: 'กรุณากรอก ชื่ออาหาร',
          helperStyle: TextStyle(color: color)),
    );
  }

  Widget nameShopText() {
    Color color = Colors.green;
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(
            Icons.home,
            color: color,
            size: 36.0,
          ),
          labelText: 'ชื่อ ร้านอาหาร',
          labelStyle: TextStyle(color: color),
          helperText: 'กรุณากรอก ชื่อ ร้านอาหาร',
          helperStyle: TextStyle(color: color)),
    );
  }

  Widget addressText() {
    Color color = Colors.blue.shade800;
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            color: color,
            size: 36.0,
          ),
          labelText: 'ที่อยู่ร้านอาหาร',
          labelStyle: TextStyle(color: color),
          helperText: 'กรุณากรอก ที่อยู่อาหาร',
          helperStyle: TextStyle(color: color)),
    );
  }

  Widget detailText() {
    Color color = Colors.orange.shade400;
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      decoration: InputDecoration(
          icon: Icon(
            Icons.details,
            color: color,
            size: 36.0,
          ),
          labelText: 'รายละเอียด อาหาร',
          labelStyle: TextStyle(color: color),
          helperText: 'กรุณากรอก รายละอียด ของ อาหาร',
          helperStyle: TextStyle(color: color)),
    );
  }

  Widget showFoodImage() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Image.asset('images/food.png'),
    );
  }

  Widget galleryButton() {
    return Container(
      margin: EdgeInsets.only(left: 40.0, right: 40.0),
      child: RaisedButton.icon(
        icon: Icon(Icons.image),
        label: Text('Choose Image Food'),
        onPressed: () {},
      ),
    );
  }

  Widget showLat() {
    return ListTile(
      title: Text('13.1234567'),
      subtitle: Text('ละติจูด'),
    );
  }

  Widget showLng() {
    return ListTile(
      title: Text('100.1234567'),
      subtitle: Text('ลองติจูด'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30.0),
      children: <Widget>[
        nameFoodText(),
        nameShopText(),
        addressText(),
        detailText(),
        SizedBox(
          height: 16.0,
        ),
        showFoodImage(),
        SizedBox(
          height: 16,
        ),
        galleryButton(),
        SizedBox(height: 16.0,), showLat(), showLng(),
      ],
    );
  }
}
