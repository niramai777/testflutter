
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testflutter/model/person.dart';

class addPerson extends StatefulWidget {

  const addPerson({Key? key}) : super(key: key);

  @override
  _addPersonState createState() => _addPersonState();
}

class _addPersonState extends State<addPerson> {

  File? image;
  // Future pickImage() async{
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //
  //     final imageTemporaly = File(image.path);
  //     setState(() => this.image = imageTemporaly);
  //   } on PlatformException catch (e) {
  //     // TODO
  //     print("Filied to pick image: $e");
  //   }
  // }

  String dropdownValue1 = 'Gender';
  List<modelperson> insert = <modelperson>[];
  List<modelperson> search = <modelperson>[];

  int idx =0;

  var name = TextEditingController();
  var age = TextEditingController();
  var gender ;


  late modelperson model ;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("add Peson"),
      ),
      body:  Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
              child: image != null? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  image!,
                  width: 150,
                  height: 200,
                  fit: BoxFit.fitHeight,
                ),
              ) : Container(
                child: Icon(
                  Icons.account_box_sharp,
                  color: Colors.grey[800],size: 150,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (image == null) return;
                      final imageTemporaly = File(image.path);
                      setState(() => this.image = imageTemporaly);
                    },
                    icon: Icon(Icons.add_photo_alternate,color: Colors.blue,size: 30,),
                  ),
                  IconButton(
                    onPressed: () async {
                      final image = await ImagePicker().pickImage(source: ImageSource.camera);
                      if (image == null) return;
                      final imageTemporaly = File(image.path);
                      setState(() => this.image = imageTemporaly);
                    },
                    icon: Icon(Icons.add_a_photo,color: Colors.blue,size: 30,),
                  ),
                ],
              ),

            ),
            SizedBox(height: 40.0),
            // Container(),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
              child: TextField(
                controller: name,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                    color: Colors.blue
                ),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    labelStyle: new TextStyle(
                      color: Colors.blue,
                    ),
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: Colors.blue
                        )
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
              child: TextField(
                controller: age,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                    color: Colors.blue
                ),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                    labelStyle: new TextStyle(
                      color: Colors.blue,
                    ),
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: Colors.blue
                        )
                    )
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
              width: 48.0,
              //height: 48.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                //border: Border.all(),

              ),
              child: Row(
                children: [

                  DropdownButton<String>(
                    value: dropdownValue1,
                    iconDisabledColor: Colors.white,
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.blue

                    ),
                    underline: Container(
                        height: 2,
                        color: Colors.blue
                    ),

                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue1 = newValue!;
                        gender = newValue;
                      });
                    },

                    items: <String>['Gender', 'men', 'women']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );

                    }).toList(),
                  ),

                ],
              ),
            ),
            SizedBox( height: 40,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child :
                  new FlatButton (
                    minWidth: 120.0,
                    height: 50.0,
                    color: Colors.green,

                    onPressed: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      idx = preferences.getInt('idx')!;
                     print( preferences.getInt('idx'));
                      setState(() {
                        modelperson insert = new modelperson(
                            idx,
                          name.text,
                          age.text,
                          gender,
                          image!.path
                        );
                        print(insert.imgpath);
                        print(insert.id);
                        //search = insert as List<modelperson>;
                        Navigator.pop(context,insert);
                      });

                    },
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ยืนยัน",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16  ,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                          ),
                        ),
                      ],
                    ),
                    shape: StadiumBorder(
                        side: BorderSide(width: 1.0,color: Colors.green,)
                    ),
                  ),

                ),

                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child :
                  new FlatButton (
                    minWidth: 120.0,
                    height: 50.0,
                    // color: Color.fromRGBO(247, 207, 205, 1),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ยกเลิก",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16  ,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                          ),
                        ),
                      ],
                    ),
                    shape: StadiumBorder(
                        side: BorderSide(width: 1.0,color: Colors.red,)
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}
