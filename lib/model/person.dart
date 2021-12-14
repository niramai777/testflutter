class modelperson {

  //field
  late int id ;
  late String name,age,gender,imgpath;

  //method
  modelperson(
      this.id,
      this.name,
      this.age,
      this.gender,
      this.imgpath

      );

  @override
  String toString() {
    // TODO: implement toString
    return "id => $id, name => $name, age => $age, gender => $gender, imgpath => $imgpath ";
  }

}


