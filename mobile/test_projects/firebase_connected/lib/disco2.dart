// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import 'main.dart';

// class DiscoTest extends StatefulWidget {
//   @override
//   _DiscoTestState createState() => _DiscoTestState();
// }

// class _DiscoTestState extends State<DiscoTest> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: StreamBuilder(
//         stream: firestoreDB.collection("events").snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) return Center(child: Text("Error: ${snapshot.error}"),);
//           switch (snapshot.connectionState){
//             case ConnectionState.waiting: return Center(child: Text("Loading..."),);
//             case ConnectionState.done: return Center(child: Text("Done: ${snapshot.data}"),);
//             default:
//               return ListView(
//                 children: ,
//               );
//           }
//         }
//       ),
//     );
//   }
// }