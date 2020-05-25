import 'package:contactsflutterapp/ContactModel.dart';
import 'package:contactsflutterapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

class FavouriteContacts extends StatefulWidget{
  static const String routeName = '/FavContacts';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new FavContactsState();
  }
}
class FavContactsState extends State<FavouriteContacts>{
  List<ContactModel> contactList = new List<ContactModel>();
  final LocalStorage storage = new LocalStorage('contact_app');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var items = storage.getItem("contact");
    if(items!=null){
      (items as List).forEach((item) {
        contactList.add(new ContactModel(name: item['name'],mobNum: item['mobNum'],landline: item['landline'],isfav: item['isfav'],imageURI: item['imageURI']));

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Favourite Contacts"),
      ),
      body:ListView.builder(
          itemCount: contactList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: contactList[index].imageURI!=null?new Image.file(contactList[index].imageURI).image:new AssetImage('assets/images/user.png'), // no matter how big it is, it won't overflow
              ),
              title: Text(contactList[index].name),
              subtitle: Text(contactList[index].mobNum),);
          }),

    );
  }
  Widget generateColumn(ContactModel item) => Card(
    child: _buildItemsForListView(),
  );
  ListTile _buildItemsForListView() {
    return ListTile(
      title: Text("no title") ,
      subtitle: Text("no data"),
    );
  }

}