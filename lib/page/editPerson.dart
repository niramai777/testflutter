import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testflutter/model/person.dart';

class editPerson extends StatefulWidget {

  late List<modelperson> personlist;
  late int id;

  editPerson.setText(List<modelperson> modellist, int id){
    this.personlist = modellist;
    this.id = id;
  }
  @override
  _editPersonState createState() => _editPersonState(personlist,id);
}

class _editPersonState extends State<editPerson> {


  @override
  String dropdownValue1 = 'Gender';

  late List<modelperson> list;
  late int id;

  var name = TextEditingController();
  var age = TextEditingController();
  var gender ;

  _editPersonState(List<modelperson> modellist, int idx){
    list = modellist;
    id = idx;
    name.text = modellist[id].name;
    age.text = modellist[id].age;
    gender = modellist[id].gender;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("edit Peson"),
      ),
      body:  Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 20.0),
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
                    onPressed: () {
                      var edit = list.firstWhere((element) => element.id == id);
                      edit.name = name.text;
                      edit.age = age.text;
                      edit.gender = gender;

                      print(name.text);
                      print(age.text);
                      print(gender);

                      Navigator.pop(context,list);
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
                        side: BorderSide(width: 1.0,color: Colors.red)
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
