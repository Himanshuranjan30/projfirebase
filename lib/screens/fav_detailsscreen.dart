import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projq/Providers/project.dart';
import 'package:projq/services/database.dart';
import 'package:projq/shared/loading.dart';
import 'package:provider/provider.dart';

class FavScreen extends StatelessWidget {
  

  String finalurl;

  String uid;

  String imagename;

  Future returnuid() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    uid = user.uid;
  }

  String docid;
  final firestoreInstance = Firestore.instance;

  
  Widget build(BuildContext context) {
    returnuid();
    docid = ModalRoute.of(context).settings.arguments;

    return StreamBuilder(
        stream: Firestore.instance.collection(uid).document(docid).snapshots(),
        builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.active) {
             
          
          if (snapshot.hasData) {
            

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.indigo,
                title: Text(snapshot.data['title']),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.delete,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        await Firestore.instance
                            .collection(uid)
                            .document(docid)
                            .delete();
                      })
                ],
              ),
              body: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Card(
                          child: Image.network(
                            snapshot.data['imageurl'],
                            fit: BoxFit.fill,
                          ),
                          margin: EdgeInsets.all(8),
                        ),
                        height: 200,
                        width: 200,
                      ),
                      SizedBox(width: 20),
                      FloatingActionButton(
                        backgroundColor: Colors.indigo,
                        onPressed: null,
                        child: Icon(Icons.check_circle),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text('About the Project:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            alignment: Alignment.topLeft,
                            child: Card(
                              child: Text(snapshot.data['description'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text('Prequisites:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            alignment: Alignment.topLeft,
                            child: Card(
                              child: Text(snapshot.data['prequisites'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text('Contact Info:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            alignment: Alignment.topLeft,
                            child: Card(
                              child: Text(snapshot.data['contact'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ));
         } }return Scaffold(
           body: Center(
           child: Loading(),));});
  }
}
