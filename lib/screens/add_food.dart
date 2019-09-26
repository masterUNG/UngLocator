import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';

class AddFood extends StatefulWidget {
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  // Explicit
  File file;
  final formKey = GlobalKey<FormState>();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String urlImage = '';
  String nameFood, nameShop, address, detail, latString = '0', lngString = '0', namePost;
  

  // Method
 @override
 void initState() { 
   super.initState();
   findLocation();
 }

  Future<void> findLocation()async{
    LocationData currentLocation = await locationData();
    setState(() {
      latString = currentLocation.latitude.toString();
    lngString = currentLocation.longitude.toString();
    });
  }

  Future<LocationData> locationData()async{
    Location location = Location();
    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      print('Location Error ==> ${e.code}');
    }
  } 


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
        helperStyle: TextStyle(color: color),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'กรุณา กรอก ชื่ออาหาร ด้วยคะ';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        nameFood = value.trim();
      },
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
        helperStyle: TextStyle(color: color),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'กรุณา กรอก ชื่อร้านอาหาร ด้วยคะ';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        nameShop = value.trim();
      },
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
        helperStyle: TextStyle(color: color),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'กรุณา กรอก ที่อยู่ ด้วยคะ';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        address = value.trim();
      },
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
        helperStyle: TextStyle(color: color),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'กรุณา กรอก รายละเอียด ด้วยคะ';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        detail = value.trim();
      },
    );
  }

  Widget showFoodImage() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.width * 0.5,
      child: file == null ? Image.asset('images/food.png') : Image.file(file),
    );
  }

  Widget galleryButton() {
    return Container(
      margin: EdgeInsets.only(left: 40.0, right: 40.0),
      child: RaisedButton.icon(
        icon: Icon(Icons.image),
        label: Text('Choose Image Food'),
        onPressed: () {
          chooseImageThread();
        },
      ),
    );
  }

  Future<void> chooseImageThread() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = image;
    });
  }

  Widget showLat() {
    return ListTile(
      title: Text(latString),
      subtitle: Text('ละติจูด'),
    );
  }

  Widget showLng() {
    return ListTile(
      title: Text(lngString),
      subtitle: Text('ลองติจูด'),
    );
  }

  Widget uploadButton() {
    return Container(
      margin: EdgeInsets.only(left: 40.0, right: 40.0),
      child: RaisedButton.icon(
        icon: Icon(Icons.cloud_upload),
        label: Text('Upload Value'),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            if (file == null) {
              myAlert('ยั่งไม่ได้ เลือกรูปภาพอาหาร คะ');
            } else {
              // upload
              uploadImageThread();
            }
          } else {
            myAlert('กรอกข้อมูล ไม่ครบ คะ');
          }
        },
      ),
    );
  }

  Future<void> uploadImageThread() async {
    int randInt = Random().nextInt(1000);
    String nameImage = 'food$randInt.jpg';

    StorageReference storageReference = firebaseStorage.ref().child('ImageFood/$nameImage');
    StorageUploadTask storageUploadTask = storageReference.putFile(file);

    urlImage = await (await storageUploadTask.onComplete).ref.getDownloadURL();
    print('urlImage = $urlImage');
    
  }

  Future<void> findURL() async {}

  Future<void> uploadDataThread() async {}

  void myAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('มีความ ผิดปกติ เกิดขึ้น'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
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
          SizedBox(
            height: 16.0,
          ),
          showLat(),
          showLng(),
          SizedBox(
            height: 16,
          ),
          uploadButton(),
          SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }
}
