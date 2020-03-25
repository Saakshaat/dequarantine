import 'package:flutter/material.dart';
import 'package:app/main.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class Liked extends StatefulWidget {
  @override
  _LikedState createState() => _LikedState();
}

class _LikedState extends State<Liked> {
  List liked = [];

  Widget events(String name, int index) {
    double radius = 10.0;
    return Card(
      elevation: 7,
      // borderRadius: BorderRadius.circular(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      color: category(liked[index][1]),
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(
          //   width: 2,
          //   color: Colors.black54
          // ),
          // borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Image.asset("assets/${liked[index][0]}", fit: BoxFit.contain,)
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("event $name as well as sample text\nidk what else to write in here i'm just testing"),
            )
          ],
        ),
      ),
    );
  }


  Color category(int index) {
    Color background;
    switch (index) {
      case 1:
        background = Colors.yellow[300];
        break;
      case 2:
        background = Colors.green[300];
        break;
      case 3:
        background = Colors.red[300];
        break;
      case 4:
        background = Colors.blue[300];
        break;
    }

    return background;
  }

  @override
  void initState() {
    super.initState();
    liked = data.getLiked();
  }


  @override
  Widget build(BuildContext context) {
    List liked = data.getLiked();

    if (liked.isEmpty) {
      return Center(child: Text("No liked events to display"),);
    }
    return StaggeredGridView.builder(
      gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        staggeredTileBuilder: (int i) => StaggeredTile.fit(2)
      ),
      itemCount: liked.length,
      itemBuilder: (context, index) {
        final item = liked[index][0];
        return Dismissible(
          // background: Container(color: backgroundSwipe),
          key: Key(item),
          onDismissed: (direction) {
            String message = "$item dismissed";
            setState(() {
              data.removeliked(index);
            });

            Scaffold.of(context)
                .showSnackBar(SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.black87
                ));
          },
          child: events(item.toString(), index)
        );
      },
    );
  }
}