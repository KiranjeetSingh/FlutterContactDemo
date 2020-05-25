import 'dart:io';

class ContactModel{
  String name="";
  String mobNum="";
  String landline="";
  bool isfav =false;
  File imageURI;
  ContactModel({this.name, this.mobNum,this.landline,this.isfav,this.imageURI});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['name'] = name;
    m['mobNum'] = mobNum;
    m['landline'] = landline;
    m['isfav'] = isfav;
    m['imageURI'] = imageURI;

    return m;
  }
}