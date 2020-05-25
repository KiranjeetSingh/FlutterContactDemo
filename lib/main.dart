import 'package:contactsflutterapp/AddNewContact.dart';
import 'package:contactsflutterapp/Contacts.dart';
import 'package:contactsflutterapp/FavouriteContact.dart';
import 'package:contactsflutterapp/Routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Contacts(),
      routes:  {
        Routes.contacts: (context) => Contacts(),
        Routes.addNewContact: (context) => AddNewContact(),
        Routes.favouriteContacts: (context) => FavouriteContacts(),
      },
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Contacts"),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      new PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) {
                            return new Contacts();
                          },
                          transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                            return new FadeTransition(
                                opacity: animation,
                                child: child
                            );
                          }
                      )
                  );
                },
            ),
            ListTile(
              title: Text("Favourite Contacts"),
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).push(
                    new PageRouteBuilder(
                        pageBuilder: (BuildContext context, _, __) {
                          return new FavouriteContacts();
                        },
                        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                          return new FadeTransition(
                              opacity: animation,
                              child: child
                          );
                        }
                    )
                );
              },
            ),
            ListTile(
              title: Text("Add New Contact"),
              onTap: ()  {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    new PageRouteBuilder(
                        pageBuilder: (BuildContext context, _, __) {
                          return new AddNewContact();
                        },
                        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                          return new FadeTransition(
                              opacity: animation,
                              child: child
                          );
                        }
                    )
                );
              },
            ),
          ],
        ),
    );
  }
}

