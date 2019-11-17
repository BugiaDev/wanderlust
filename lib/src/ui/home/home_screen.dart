import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  Stream _firebaseRequest = Firestore.instance.collection('categories').snapshots();

  _changeFirebaseRequest() {
    _counter ++;
    if(_counter == 3) _counter = 0;
    setState(() {
      switch(_counter) {
        case 0: _firebaseRequest = Firestore.instance.collection('categories').snapshots(); break;
        case 1: _firebaseRequest = Firestore.instance.collection('medals').snapshots(); break;
        case 2: _firebaseRequest = Firestore.instance.collection('users').snapshots(); break;
        default: _firebaseRequest = Firestore.instance.collection('categories').snapshots(); break;
      }
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return Row(children: <Widget>[
      Text(document['name'])
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: _firebaseRequest,
        builder: (context, snapshot) {
          if(!snapshot.hasData) return const Text('loading...');
          return ListView.builder(
            itemExtent: 80.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
              _buildListItem(context, snapshot.data.documents[index])
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeFirebaseRequest(),
        tooltip: 'Change request',
        child: Icon(Icons.change_history),
      ),
    );
  }
}