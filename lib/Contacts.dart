import 'package:contactsflutterapp/AddNewContact.dart';
import 'package:contactsflutterapp/ContactModel.dart';
import 'package:contactsflutterapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

class Contacts extends StatefulWidget{
  static const String routeName = '/Contacts';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new  ContactsState();
  }
}
class ContactsState extends State<Contacts> {
  List<ContactModel> contactList = new List<ContactModel>();
  final LocalStorage storage = new LocalStorage('contact_app');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: ListView.builder(
          itemCount: contactList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: contactList[index].imageURI!=null?new Image.file(contactList[index].imageURI).image:new AssetImage('assets/images/user.png'), // no matter how big it is, it won't overflow
              ),
              title: Text(contactList[index].name),
              subtitle: Text(contactList[index].mobNum),
              onTap: () {
                openUpdateContactpage(index,contactList[index], context);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openAddNewContactpage(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),

    );
  }

  Widget generateColumn(ContactModel item) =>
      Card(
        child: _buildItemsForListView(),
      );

  ListTile _buildItemsForListView() {
    return ListTile(
      title: Text("no title"),
      subtitle: Text("no data"),
    );
  }

  void openAddNewContactpage(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNewContact(isUpdate: false,),
        ));
    if (result != null) {
      setState(() {
        contactList.add(result as ContactModel);
        storage.setItem("contact", contactList.map((item) {
          return item.toJSONEncodable();
        }).toList());
      });
    }
  }

  void openUpdateContactpage(int index,ContactModel model, BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNewContact(isUpdate: true, item: model,),
        ));
    if (result != null) {
      setState(() {
        contactList.removeAt(index);
        contactList.insert(index,result as ContactModel);
        storage.setItem("contact", contactList.map((item) {
          return item.toJSONEncodable();
        }).toList());
      });
    }
  }
}