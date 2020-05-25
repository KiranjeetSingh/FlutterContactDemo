import 'dart:io';

import 'package:contactsflutterapp/ContactModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';


// Create a Form widget.
class AddNewContact extends StatefulWidget {
  static const String routeName = '/AddNewContact';

  bool isUpdate = false;
  ContactModel item;

// receive data from the FirstScreen as a parameter
  AddNewContact({Key key, @required this.isUpdate,this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MyCustomFormState();
  }

}
class MyCustomFormState extends State<AddNewContact> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _name;
  String _landline;
  String _mobile;
  bool isfav = false;


  File imageURI;

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageURI = image;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageURI = image;
    });
  }


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: widget.isUpdate ? Text("Update Contact") : Text(
            "Add New Contact"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isfav ? Icons.star : Icons.star_border,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isfav = !isfav;
              });
              // do something
            },
          )
        ],
      ),

      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      _settingModalBottomSheet(context);
                    },
                    child: Container(
                      height: 160.0,
                      width: 160.0,
                      decoration: new BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: new DecorationImage(
                          image: imageURI == null
                              ? new AssetImage('assets/images/user.png')
                              : new Image.file(imageURI).image,
                          fit: BoxFit.cover,
                        ),

                        borderRadius:
                        new BorderRadius.all(const Radius.circular(80.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              children: <Widget>[

                SizedBox(
                  width: 90.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Name",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new TextFormField(
                        keyboardType: TextInputType.text,
                        validator: validateName,
                        initialValue: widget.isUpdate ? widget.item.name : "",
                        onSaved: (String val) {
                          _name = val;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                          const EdgeInsets.only(
                              left: 5.0, bottom: 5.0, top: 5.0, right: 5.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            new Row(
              children: <Widget>[

                SizedBox(
                  width: 90.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Mobile",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: validateMobile,
                        maxLength: 10,
                        initialValue: widget.isUpdate ? widget.item.mobNum : "",
                        onSaved: (String val) {
                          _mobile = val;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                          const EdgeInsets.only(
                              left: 5.0, bottom: 5.0, top: 5.0, right: 5.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            new Row(
              children: <Widget>[
                SizedBox(
                  width: 90.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Landline",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new TextFormField(
                        keyboardType: TextInputType.phone,
                        initialValue: widget.isUpdate
                            ? widget.item.landline
                            : "",
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                          const EdgeInsets.only(
                              left: 5.0, bottom: 5.0, top: 5.0, right: 5.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    )),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.


                  if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
                    _formKey.currentState.save();

                    ContactModel contactModel = new ContactModel(name: _name,
                        mobNum: _mobile,
                        landline: _landline,
                        isfav: isfav,imageURI: imageURI);
                    Navigator.pop(context, contactModel);
                  } else {
//    If all data are not valid then start auto validation.
                    setState(() {
                      _autoValidate = true;
                    });
                  }
                },
                child: widget.isUpdate ? Text('Update') : Text('Save'),

              ),
            ),
          ],
        ),
      ),
    );
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera_alt),
                    title: new Text('Camera'),
                    onTap: () {
                      Navigator.of(context).pop();
                      getImageFromCamera();
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.image),
                    title: new Text('Gallery'),
                    onTap: () {
                      Navigator.of(context).pop();
                      getImageFromGallery();
                    }
                ),
              ],
            ),
          );
        }
    );
  }
}


