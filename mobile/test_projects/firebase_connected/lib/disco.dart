// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_connected/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


// class Discover extends StatefulWidget {
//   @override
//   _DiscoverState createState() => _DiscoverState();
// }

// class _DiscoverState extends State<Discover> {

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
//               final items = snapshot.data.documents;
//                 Widget drop = Container(
//                   width: MediaQuery.of(context).size.width* 0.33,
//                   // height: MediaQuery.of(context).size.height,
//                   child: DragTarget<int>(
//                     builder: (BuildContext context, List candidate, List rejected) {
//                       return Container();
//                     },

//                     onWillAccept: (data) {
//                       return true;
//                     },

//                     onAccept: (data) {
//                       String message = "${data.toString()} dismissed";
//                       setState(() {
//                         items.remove(data);
//                       });
//                       print(message);
//                       Scaffold.of(context).showSnackBar(SnackBar(
//                         content: Text(message),
//                       ));
//                     },
//                   ),
//                 );
//               return SafeArea(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         color: Colors.green,
//                         child: Stack(
//                           children: <Widget>[
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: drop,
//                             ),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: drop,
//                             ),
//                             Center(
//                               child: Column(
//                                 children: items.map<Widget>((DocumentSnapshot item) {
//                                 String baseUrl = "https://source.unsplash.com/500x300/?";
//                                 item['tags'].forEach((tag) => baseUrl += "$tag,");
//                                 final String description = item["description"];
//                                 final String title = item["title"];
//                                 final widget = Container(
//                                     width: MediaQuery.of(context).size.width * 0.9,
//                                     child: Card(
//                                       elevation: 0,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: <Widget>[
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(title, style: Theme.of(context).textTheme.headline5,),
//                                           ),
//                                           GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 items.remove(item);
//                                               });
//                                             },
//                                             child: ClipRRect(
//                                               borderRadius: BorderRadius.circular(10),
//                                               child: Image.network(baseUrl, fit: BoxFit.fitWidth,),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(description),
//                                           )
//                                         ],
//                                       ),
//                                     )
//                                   );
//                                   return Draggable<int>(
//                                     child: widget,
//                                     data: items.indexOf(item),
//                                     feedback: widget,
//                                     childWhenDragging: Container(),
//                                   );
//                                 }).toList()
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//               // return StaggeredGridView.count(
//                 // gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
//                 //   crossAxisCount: 4,
//                 //   crossAxisSpacing: 6,
//                 //   mainAxisSpacing: 6,
//                 //   staggeredTileBuilder: (int i) => StaggeredTile.fit(2)
//                 // ),
//                 // itemCount: snapshot.data.documents.length,
//               //   crossAxisCount: 4,
//               //   scrollDirection: Axis.vertical,
//               //   crossAxisSpacing: 5,
//               //   mainAxisSpacing: 5,
//               //   // staggeredTiles: StaggeredGridView[],
//               //   children: snapshot.data.documents.map<Widget>((DocumentSnapshot item) {
//               //     // final item = snapshot.data.document[index];
//               //     String baseUrl = "https://source.unsplash.com/1600x900/?";
//               //     item['tags'].forEach((tag) => baseUrl += "$tag,");
//               //     final String description = item["description"];
//               //     final widget = Material(
//               //       child: Card(
//               //         elevation: 7,
//               //         shape: RoundedRectangleBorder(
//               //           borderRadius: BorderRadius.circular(10),
//               //         ),
//               //         child: Column(
//               //           crossAxisAlignment: CrossAxisAlignment.center,
//               //           mainAxisAlignment: MainAxisAlignment.center,
//               //           mainAxisSize: MainAxisSize.min,
//               //           children: <Widget>[
//               //             ClipRRect(
//               //               borderRadius: BorderRadius.circular(10),
//               //               child: Image.network(baseUrl, fit: BoxFit.fitWidth,),
//               //             ),
//               //             Padding(
//               //               padding: const EdgeInsets.all(8.0),
//               //               child: Text(description),
//               //             )
//               //           ],
//               //         ),
//               //       ),
//               //     );
//               //     return Draggable<String>(
//               //       data: item["title"],
//               //       child: widget,
//               //       feedback: widget,
//               //       childWhenDragging: Container(),
//               //     );
//               //   }).toList(),
//               // );
//           }
//         },
//       ),
//     );
//   }
// }