import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection("user").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            Widget child;
            if (snapshot.hasError) {
              child = Text("something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              child = CircularProgressIndicator();
            }
            // if (snapshot.connectionState == ConnectionState.done) {
            //   if (snapshot.hasData) {
            //     if (snapshot.data.docs.length > 0) {
            //       child = ListView(
            //         children: snapshot.data.docs.map((date) {
            //           return Center(
            //               child: Text(
            //             date.data()["name"],
            //             style: TextStyle(
            //               fontSize: 20,
            //             ),
            //           ));
            //         }).toList(),
            //       );
            //     } else {
            //       child = Center(child: Text("No Record"));
            //     }
            //   }
            // }

            child = ListView(
              children: snapshot.data.docs.map((date) {
                return Center(
                    child: Text(
                  date.data()["name"],
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ));
              }).toList(),
            );
            return child;
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     var userCollection = await firestore.collection("user");
      //     // userCollection.add({"name": "ravi"});
      //     //var names = userCollection.get();
      //     // for (var item in names.docs) {
      //     //   //print("id -: ${item.id}");
      //     //   //print(item.get("name"));
      //     //   //print(item.data()["name"]);
      //     // }
      //   },
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
