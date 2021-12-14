import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testflutter/model/person.dart';
import 'package:testflutter/page/addPerson.dart';
import 'package:testflutter/page/editPerson.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

class _homepageState extends State<homepage> {

  File? image;

  int numvalue = 0;
  int idx = 0;
  List<modelperson> insert = <modelperson>[];
  late List Pesonsearch = [];


  late String searchText;

  TextEditingController textController = TextEditingController();

  void getText(){
    textController.addListener(() {
      textController.text;
      print("getText : "+textController.text);
    });
    setState(() {

    });
  }

  void search(String person) {
    if(person.isEmpty){
      Pesonsearch = insert;
      setState(() {});
      return ;
    }
    person = person.toLowerCase();
    print(person);
    List result = [];
    Pesonsearch.forEach((p) {
      var name = p.toString().toLowerCase();
      print("name : "+name);
      if(name.contains(person)){
        result.add(p);
        print(result);

      }
    });
    Pesonsearch = result;
    print(Pesonsearch);
    setState(() {});

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getText();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text("Person"),
          actions: <Widget>[
            Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 200),
                  child: TextField(

                    controller: textController ,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText:  'search',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    onChanged: search ,
                    style: new TextStyle(fontSize: 15.0, color: Colors.blue),
                  )


                )


            ),
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Show Snackbar',
              onPressed: () async{
                SharedPreferences preferences = await SharedPreferences.getInstance();
                Navigator.push(context,
                  new MaterialPageRoute(
                      builder: (context) => new addPerson()),).then((value) {
                  if (value == null){

                  }else{
                    insert.add(value);
                  }
                  setState(()  {

                   idx++;

                    print(idx);
                  });
                });
                preferences.setInt('idx', idx);
              },
            ),
          ]
      ),

      body: Center(
          child: (insert.length != 0 || Pesonsearch.isNotEmpty)?
          ListView.builder(
              itemCount: insert.length,
              itemBuilder: (BuildContext buildContext , int index )
              {
                return  ListTile(
                  leading: CircleAvatar(
                    child: Image.file(
                      File(insert[index].imgpath),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                    // backgroundImage:  getPref(insert[index].imgpath),
                   // radius: 20,
                  ),
                  title: Text(insert[index].name),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          insert[index].age
                      ),
                      Text(
                          insert[index].gender
                      ),

                    ],
                  ),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                new editPerson.setText(insert, index)),
                          ).then((value){
                            if (value == null){
                            }else{
                              insert = value;
                            }
                            setState(() {

                            });
                          });
                        },
                        icon: Icon(Icons.edit,color: Colors.blue,),),

                      IconButton(
                        onPressed: () {
                          insert.removeWhere(
                                  (element) => element.id == insert[index].id);
                          setState(() {

                          });
                        },
                        icon: Icon(Icons.delete,color: Colors.red,),),
                    ],
                  ),
                  // Icon(Icons.more_vert),
                  isThreeLine: true,
                );
              } )
              :Container()
      ),
    );
  }
}
