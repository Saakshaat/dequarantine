import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';


void main() { 
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
    home: Home(),
    )
  );
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List images = [
    "assets/-vM6_5sFmqo.jpg",
    "assets/3Yy5vGzmpE8.jpg",
    "assets/3zsuBV7zVR4.jpg",
    "assets/5kjh--moFWU.jpg",
    "assets/bZOVo5uQLEM.jpg",
    "assets/BzP_MdFlzwI.jpg",
    "assets/cUC6B-3dhvs.jpg",
    "assets/DJcVOQUZxF0.jpg",
    "assets/gjYClqWbJJ4.jpg",
    "assets/HWCgw1QUnGU.jpg",
    "assets/iqa2CI6Kpug.jpg",
    "assets/mBhzTWgmepY.jpg",
    "assets/mcrQoYT8VFE.jpg",
    "assets/MEd4ghCu5wQ.jpg",
    "assets/swtcn5aBbro.jpg",
    "assets/wYSD6jh7XHk.jpg",
    "assets/XETYOuqXQqQ.jpg",
    "assets/yTjJN_c7GwI.jpg",
    "assets/ZWo_-II3Xck.jpg",
    "assets/_aZUDe5-0TM.jpg",
  ];

  CardController controller  = CardController();

  List liked = [];

  List buildCards(){
    List widgets = <Widget>[];
    for (int i = 0; i < images.length; i++){
      widgets.add(
        TinderSwapCard(
          totalNum: images.length,
          orientation: AmassOrientation.BOTTOM,
          cardController: controller,
          maxHeight: 200.0,
          maxWidth: 200.0,
          minHeight: 100.0,
          minWidth: 100.0,
          cardBuilder: (BuildContext context, int index) {
            return Card(
              child: Image.asset(images[i]),
            );
          },
          swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
            print(details);
            print(align);
          },
          swipeCompleteCallback: (orientation, index){
            if (orientation == CardSwipeOrientation.LEFT){
              setState(() {
                widgets.removeAt(index);
              });
            } else if (orientation == CardSwipeOrientation.RIGHT){
              setState(() {
                widgets.removeAt(index);
                liked.add(widgets.elementAt(index));
                widgets.removeAt(index);
              });
            }
          },
        )
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Dequarantined Events"),
                  FlatButton(
                    onPressed: () => print("tracking"),
                    child: Text("live tracking"),
                  )
                ],
              ),
            ),
            Center(
              child: Stack(
                children: buildCards(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                onPressed: () => print("Rewind"),
                icon: Icon(Icons.fast_rewind),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () => print("Rewind"),
                    icon: Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed: () => print("Rewind"),
                    icon: Icon(Icons.save),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () => print("Rewind"),
                icon: Icon(Icons.category),
              ),
            ),
          ],
        ),
      ),
    );
  }
}