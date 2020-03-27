import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';


class EventCard extends StatelessWidget {
  
  final String title;
  final String categories;
  final String time;
  final String dayDate;
  final String monthDate;

  EventCard({
    @required this.title,
    @required this.categories,
    @required this.time,
    @required this.dayDate,
    @required this.monthDate,
  });

  @override
  Widget build(BuildContext context) {
    String imageUrl = "assets/$title.jpg";
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            // direction: Axis.vertical,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), 
                  topRight: Radius.circular(20), 
                ),
                child: Image.asset(imageUrl)
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(title, style: Theme.of(context).textTheme.headline2),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(dayDate, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.w600)),
                                Text(monthDate, style: TextStyle(color: Colors.black, fontSize: 15),)
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(categories, style: Theme.of(context).textTheme.bodyText1,),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(time, style: Theme.of(context).textTheme.bodyText1,),
                          IconButton(
                            onPressed: () => null,
                            icon: Icon(LineIcons.heart_o),
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Container(
          //     padding: EdgeInsets.only(left: 30),
          //     child: 
          //   ),
          // ),
        ],
      ),
    );
  }
}